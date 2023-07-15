import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/components/dialogs/error_dialog.dart';
import 'package:lesson_3_homework/data/dtos/show_card_dto.dart';
import 'package:lesson_3_homework/data/mappers/show_mapper.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// Класс репозитория для получения данных о сериалах по HTTP-запросам
class SeriesRepository {
  // Статический объект библиотеки Dio для выполнения HTTP-запросов
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

  // Статический метод для получения данных
  static Future<HomeModel?> loadData(BuildContext context,
      [String q = ""]) async {
    try {
      final Response<dynamic> response;

      // Если строка поиска конкретного сериала не пуста (осуществляется поиск)
      if (q != "") {
        // Формируем URL-адрес с названием сериала для выполнения по нему HTTP-запроса
        String rapidApiUrlSearch = "${Query.rapidApiUrlSearch}/$q";

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
        const String rapidApiUrl = Query.rapidApiUrl;

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

      const String tvMazeApiUrl = Query.tvMazeApiUrl;
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
          if (responseList[i]["show"]["externals"]["imdb"] ==
              showCardModel.id) {
            // По названию ключей извлекаем из второго API те данные о сериале,
            // которых нет в первом API (краткое описание, язык и IMDb-рейтинг)
            showCardModel.description =
                responseList[i]["show"]["summary"] ?? "";
            showCardModel.language = responseList[i]["show"]["language"] ?? "";
            showCardModel.rating =
                responseList[i]["show"]["rating"]["average"] ?? 0.0;
          }
        }

        showModels.add(showCardModel);
      }

      // Собираем все преобразованные модели карточек сериалов в единую общую модель
      final HomeModel model = HomeModel(showModels);

      return model; // Возвращаем её
    } on DioException catch (exception) {
      // todo Firebase Crashlytics report

      final statusCode = exception.response?.statusCode;
      // При возникновении исключения отобразим его текст в диалоге с ошибкой
      showExceptionDialog(context, exception: statusCode?.toString() ?? "");

      return null;
    }
  }
}
