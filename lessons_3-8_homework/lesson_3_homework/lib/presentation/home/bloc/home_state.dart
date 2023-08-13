// Библиотека Equatable позволяет сравнить два отдельных состояния по их полям
// без жёсткой привязки к указателям в памяти
import 'package:equatable/equatable.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';

// Состояние BLoC-компонента главного экрана приложения
class HomeState extends Equatable {
  // Ниже список полей, которые относятся к состоянию виджета (могут изменяться)
  final String? searchQuery; // Поле поиска сериала
  final Future<HomeModel?>? data; // Список сериалов
  // Индекс текущей страницы в нижнем навигационном меню (BottomNavigationBar)
  final int? selectedTabIndex;
  final Future<HomeModel?>? favoriteShows; // Список избранных сериалов

  const HomeState({
    this.searchQuery,
    this.data,
    this.selectedTabIndex,
    this.favoriteShows,
  });

  // Данный метод подменяет (копирует) состояние виджета с новыми
  // (необязательными) значениями полей
  HomeState copyWith({
    String? search,
    Future<HomeModel?>? data,
    int? index,
    Future<HomeModel?>? shows,
  }) =>
      HomeState(
        searchQuery: search ?? searchQuery, // ?? - if null
        data: data ?? this.data,
        selectedTabIndex: index ?? selectedTabIndex,
        favoriteShows: shows ?? favoriteShows,
      );

  // Поля, по которым будет происходить сравнение двух отдельных состояний
  // (старого и нового)
  @override
  List<Object> get props => [
        searchQuery ?? "",
        data ?? 0,
        selectedTabIndex ?? 0,
        favoriteShows ?? []
      ];
}
