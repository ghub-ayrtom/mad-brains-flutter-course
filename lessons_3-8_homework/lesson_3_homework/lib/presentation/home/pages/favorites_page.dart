import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/components/delayed_action.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:lesson_3_homework/presentation/app/widgets/series_grid.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_bloc.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_event.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_state.dart';
import 'package:lesson_3_homework/presentation/settings/pages/settings_page.dart';

// Страница со списком избранных сериалов (Favorites)
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  // Контроллер для работы с полем поиска конкретного сериала
  final TextEditingController searchController = TextEditingController();
  // Список избранных сериалов для их убывающей сортировки по IMDb-рейтингу
  List<ShowCardModel>? series;

  // Данный метод вызывается каждый раз при изменениях в поле поиска
  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      // initialQ - параметр URL-адреса с названием сериала по умолчанию
      // (для HTTP-запроса ко второму API).
      // text - строка пользовательского ввода

      // Добавляем новое событие изменения поля поиска сериала в основной
      // BLoC-компонент главного экрана приложения, задавая новое значение для
      // определённого в состоянии поля searchQuery
      context.read<HomeBloc>().add(SearchChangeEvent(
          searchQuery: text.isNotEmpty ? text : Query.initialQ));
    });
  }

  @override
  void dispose() {
    // Уничтожаем контроллер перед уничтожением виджета для экономии памяти
    searchController.dispose();
    super.dispose();
  }

  // Метод для преобразования объекта Future<HomeModel?> в объект
  // List<ShowCardModel> для отображения на пользовательском интерфейсе (UI)
  Future<List<ShowCardModel>?> futureHomeModelToList(
      Future<HomeModel?>? model) async {
    HomeModel? inModel = await model;
    return inModel?.results;
  }

  @override
  Widget build(BuildContext context) {
    // BlocBuilder позволяет подписать его дочерний виджет на изменение
    // состояния и перерисовать его в случае необходимости
    // (задано условие перерисовки buildWhen) или каждый раз при добавлении
    // нового события в основной BLoC-компонент
    // (не задано условие перерисовки buildWhen)
    return BlocBuilder<HomeBloc, HomeState>(
        // favoriteShows - список сериалов конкретного состояния
        buildWhen: (oldState, newState) =>
            oldState.favoriteShows != newState.favoriteShows,
        builder: (context, state) {
          // Получаем из текущего состояния state основного BLoC-компонента
          // список избранных сериалов и преобразуем его для корректного
          // отображения в виджете SeriesGrid (../../app/widgets/series_grid.dart)
          List<ShowCardModel>? favoriteShows;
          futureHomeModelToList(state.favoriteShows)
              .then((shows) => favoriteShows = shows);

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
                decoration: InputDecoration(
                  hintText: context.locale.searchTextFieldHint,
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                onChanged: _onSearchFieldTextChanged,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (series != null) {
                      // По нажатию на данную кнопку, отправляем в HomeBloc событие
                      // сортировки списка сериалов по убыванию их рейтинга
                      // (подробнее в директории ../bloc)
                      context.read<HomeBloc>().add(
                            SeriesRatingSortEvent(
                              series: series,
                            ),
                          );
                    }
                  },
                  icon: const Icon(
                    Icons.sort,
                    color: Colors.black54,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Переход на страницу настроек
                    Navigator.pushNamed(context, SettingsPage.path);
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            // Список сериалов. FutureBuilder - виджет, который строится на основе
            // последнего снимка (snapshot) взаимодействия с Future
            body: FutureBuilder<HomeModel?>(
              future: state.favoriteShows,
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
                        // Сохраняем их в общий список сериалов и передаём в
                        // событие сортировки SeriesRatingSortEvent (см. выше)
                        series = data.data!.results!;
                        return SeriesGrid(data, favoriteShows);
                      }
                    }
                }

                return Container(height: 0);
              },
            ),
            backgroundColor: Colors.black,
          );
        });
  }
}
