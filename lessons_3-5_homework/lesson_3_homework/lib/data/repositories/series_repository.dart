import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:lesson_3_homework/components/constants.dart' as constant;
import 'package:lesson_3_homework/data/db/database.dart';
import 'package:lesson_3_homework/data/dtos/show_card_dto.dart';
import 'package:lesson_3_homework/data/mappers/show_mapper.dart';
import 'package:lesson_3_homework/data/repositories/interceptors/dio_error_interceptor.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Класс репозитория для получения данных о сериалах по HTTP-запросам
class SeriesRepository {
  // Функция обработки ошибок
  final Function(String, String) onErrorHandler;
  // Основной объект библиотеки Dio для выполнения HTTP-запросов
  late final Dio _dio;
  // Основной объект базы данных библиотеки Drift
  late final Database _db;

  SeriesRepository({required this.onErrorHandler}) {
    _dio = Dio()
      ..interceptors.addAll([
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
        // Прерывание Dio на ошибку через специальный класс интерцептора
        // (файл dio_error_interceptor.dart)
        ErrorInterceptor(onErrorHandler),
      ]);

    _db = Database(); // Инициализируем базу данных
  }

  // Метод для получения данных.
  // Благодаря использованию BLoC, удалось избавиться от контекста и отделить
  // бизнес-логику приложения от пользовательского интерфейса (UI)
  Future<HomeModel?> loadData([String searchQuery = ""]) async {
    final Response<dynamic> response;

    // Если строка поиска конкретного сериала не пуста (осуществляется поиск)
    if (searchQuery != "") {
      // Формируем URL-адрес с названием сериала для выполнения по нему HTTP-запроса
      String rapidApiUrlSearch =
          "${constant.Query.rapidApiUrlSearch}/$searchQuery";

      // Выполняем запрос
      response = await _dio.get<Map<String, dynamic>>(rapidApiUrlSearch,
          options: Options(headers: {
            // API-ключ
            "X-RapidAPI-Key":
                "98aba1127emshe2546fbbc424fb9p12aae0jsndf90204c9dad",
            "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com",
          }));
    } else {
      // Иначе формируем URL-адрес для получения по нему списка 250 сериалов с
      // наивысшим рейтингом
      const String rapidApiUrl = constant.Query.rapidApiUrl;

      response = await _dio.get<Map<String, dynamic>>(
        rapidApiUrl,
        options: Options(headers: {
          "X-RapidAPI-Key":
              "98aba1127emshe2546fbbc424fb9p12aae0jsndf90204c9dad",
          "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com",
        }),
      );
    }

    // Data Transfer Object (DTO) — один из шаблонов проектирования, который
    // используется для передачи данных между подсистемами приложения
    final dtos = <ShowCardDataDTO>[];
    // Список из 10 случайных сериалов с наивысшим рейтингом
    final responseList = response.data["results"] as List<dynamic>;

    // Парсим DTO
    for (final data in responseList) {
      dtos.add(ShowCardDataDTO.fromJson(data as Map<String, dynamic>));
    }

    const String tvMazeApiUrl = constant.Query.tvMazeApiUrl;
    final showModels = <ShowCardModel>[];

    // Преобразуем DTO в модели с помощью mapper
    for (final dto in dtos) {
      // Модель карточки сериала
      ShowCardModel showCardModel = dto.toDomain();

      // Выполняем HTTP-запрос к другому API для получения дополнительных данных
      // о конкретном сериале
      final Response<dynamic> response = await _dio.get<List<dynamic>>(
        tvMazeApiUrl,
        // Параметр URL-адреса с названием сериала
        queryParameters: <String, dynamic>{'q': showCardModel.title},
      );

      // Список найденных по заданному названию сериалов
      final responseList = response.data as List<dynamic>;

      for (int i = 0; i < responseList.length; i++) {
        // Если IMDb ID сериалов из разных списков совпадают
        if (responseList[i]["show"]["externals"]["imdb"] == showCardModel.id) {
          // По названию ключей извлекаем из второго API те данные о сериале,
          // которых нет в первом API (краткое описание, язык и IMDb-рейтинг)
          showCardModel.description = responseList[i]["show"]["summary"] ?? "";
          showCardModel.language = responseList[i]["show"]["language"] ?? "";

          if (responseList[i]["show"]["rating"]["average"] != null) {
            // Если IMDb-рейтинг сериала целочисленный (особенность API)
            if (responseList[i]["show"]["rating"]["average"] is int) {
              // Добавляем в его конец .0
              showCardModel.rating =
                  (responseList[i]["show"]["rating"]["average"]).toDouble();
            } else {
              showCardModel.rating =
                  responseList[i]["show"]["rating"]["average"];
            }
          } else {
            showCardModel.rating = 0.0;
          }
        }
      }

      showModels.add(showCardModel);
    }

    // Собираем все преобразованные модели карточек сериалов в единую общую модель
    final HomeModel model = HomeModel(showModels);
    return model; // Возвращаем её
  }

  // Асинхронный метод (возвращает результаты не сразу) для работы с БД, который
  // позволяет получить весь список избранных (favorites) сериалов из неё
  Future<HomeModel?> getAllSeries() async {
    // Получаем список объектов из базы данных в её моделях (SeriesTableData)
    List<SeriesTableData> series = await _db.select(_db.seriesTable).get();

    // Преобразуем модели БД (SeriesTableData) в единую общую модель (HomeModel)
    // для её отображения на пользовательском интерфейсе (UI)
    final HomeModel model = HomeModel(
        series.map((SeriesTableData data) => data.toDomain()).toList());
    return model;
  }

  // Метод для работы с БД, который позволяет получить искомый список избранных
  // сериалов из неё
  Future<HomeModel?> getSearchedSeries(String searchQuery) async {
    // Если строка поиска не пустая
    if (searchQuery.isNotEmpty) {
      // Получаем список объектов из базы данных, которые содержат (contains) в
      // своём названии (столбец title) искомую строку searchQuery
      List<SeriesTableData> series = await (_db.select(_db.seriesTable)
            ..where((table) => table.title.contains(searchQuery)))
          .get();

      final HomeModel model = HomeModel(
          series.map((SeriesTableData data) => data.toDomain()).toList());
      return model;
    } else {
      // Иначе, если строка поиска пустая, получаем весь список избранных сериалов
      return getAllSeries();
    }
  }

  // Метод для работы с БД, который позволяет добавить в неё избранный сериал
  Future<void> insertShow(ShowCardModel model) async {
    // Передаём чистую модель (ShowCardModel), преобразуя её в модель, понятную
    // базе данных (SeriesTableData) с помощью метода toDatabase
    // (файл show_card_model.dart)
    await _db.into(_db.seriesTable).insert(
          model.toDatabase(),
          // Если подобной записи нет, то добавляем новую, иначе - обновляем старую
          mode: InsertMode.insertOrReplace,
        );
  }

  // Метод для работы с БД, который позволяет удалить из неё избранный сериал по
  // его ID
  Future<void> deleteShow(String id) async {
    await (_db.delete(_db.seriesTable)..where((table) => table.id.equals(id)))
        .go();
  }

  // Метод для работы с БД, который позволяет подписаться на любые изменения в ней
  Stream<List<ShowCardModel>> onChangeShows() {
    return (_db.select(_db.seriesTable))
        .map((SeriesTableData data) => data.toDomain())
        .watch();
  }
}
