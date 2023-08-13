import 'package:equatable/equatable.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';

// События, которые приводят к изменению состояния виджетов главного экрана приложения
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// Событие изменения поля поиска сериала
class SearchChangeEvent extends HomeEvent {
  // Строка пользовательского ввода
  final String searchQuery;

  const SearchChangeEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

// Событие загрузки списка сериалов
class LoadDataEvent extends HomeEvent {}

// Событие переключения вкладки в нижнем навигационном меню (BottomNavigationBar)
class TabSwitchEvent extends HomeEvent {
  // Индекс вкладки на которую произошло переключение
  final int selectedTabIndex;

  const TabSwitchEvent({required this.selectedTabIndex});

  @override
  List<Object> get props => [selectedTabIndex];
}

// Событие добавления сериала в избранное
class AddFavoriteShowEvent extends HomeEvent {
  final ShowCardModel? model; // Чистая модель с данными конкретного сериала

  const AddFavoriteShowEvent({required this.model});
}

// Событие удаления сериала из избранного
class RemoveFavoriteShowEvent extends HomeEvent {
  final ShowCardModel? model;

  const RemoveFavoriteShowEvent({required this.model});
}

// Событие изменения данных в БД
class DBSeriesChangeEvent extends HomeEvent {
  final Future<HomeModel?> series; // Обновлённые данные

  const DBSeriesChangeEvent({required this.series});
}

// Событие сортировки списка сериалов по убыванию их IMDb-рейтинга
class SeriesRatingSortEvent extends HomeEvent {
  final List<ShowCardModel>? series; // Список сериалов (общий или избранный)

  const SeriesRatingSortEvent({required this.series});
}
