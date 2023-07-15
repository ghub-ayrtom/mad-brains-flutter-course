import 'package:flutter/material.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/components/delayed_action.dart';
import 'package:lesson_3_homework/data/repositories/series_repository.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:lesson_3_homework/presentation/home/widgets/series_grid.dart';

// Виджет главного экрана приложения с состояниями (StatefulWidget)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Создаём начальное состояние
  @override
  State<HomePage> createState() => HomePageState();
}

// Класс начального состояния виджета HomePage
class HomePageState extends State<HomePage> {
  // Контроллер для работы с полем поиска конкретного сериала
  final TextEditingController searchController = TextEditingController();
  // Данные сериалов для отображения
  Future<HomeModel?>? dataLoadingState;
  // Список сериалов для их убывающей сортировки по IMDb-рейтингу
  late List<ShowCardModel> series;

  // Данный метод вызывается каждый раз при изменениях в поле поиска
  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      setState(() {
        dataLoadingState = SeriesRepository.loadData(
          context,
          // initialQ - параметр URL-адреса с названием сериала по умолчанию
          // (для HTTP-запроса ко второму API)
          text.isNotEmpty ? text : Query.initialQ,
        );
      });
    });
  }

  // Выполняем HTTP-запросы и загружаем сериалы сразу при запуске данного виджета
  @override
  void didChangeDependencies() {
    dataLoadingState ??= SeriesRepository.loadData(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Уничтожаем контроллер перед уничтожением виджета для экономии памяти
    searchController.dispose();
    super.dispose();
  }

  // Метод для реализации функционала pull-to-refresh
  Future refreshData() async {
    setState(() {
      dataLoadingState = SeriesRepository.loadData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold - виджет для компоновки пользовательского интерфейса
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Поле поиска
        title: TextField(
          controller: searchController,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: Local.search,
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: _onSearchFieldTextChanged,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // По нажатию на данную кнопку, сортируем список сериалов по убыванию
              // их рейтинга и обновляем состояние виджета
              setState(() {
                series.sort((a, b) => b.rating!.compareTo(a.rating!));
              });
            },
            icon: const Icon(
              Icons.sort,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      // pull-to-refresh
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: refreshData,
        // Список сериалов. FutureBuilder - виджет, который строится на основе
        // последнего снимка (snapshot) взаимодействия с Future
        child: FutureBuilder<HomeModel?>(
          future: dataLoadingState,
          builder: (BuildContext context, AsyncSnapshot<HomeModel?> data) {
            switch (data.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting: // Загрузка в процессе
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                );
              case ConnectionState.done: // Загрузка завершена
                // Если есть данные
                if (data.hasData) {
                  // Если данные не пустые
                  if (data.data?.results?.isNotEmpty == true) {
                    // Сохраняем их в список сериалов и передаём для отображения
                    // на UI в виджете GridView
                    series = data.data!.results!;
                    return SeriesGrid(data);
                  }
                }
            }

            return Container(height: 0);
          },
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
