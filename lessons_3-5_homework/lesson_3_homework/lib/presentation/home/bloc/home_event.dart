import 'package:equatable/equatable.dart';

// События, которые приводят к изменению состояния виджетов главного экрана приложения
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// Событие изменения поля поиска сериала
class SearchChangedEvent extends HomeEvent {
  // Строка пользовательского ввода
  final String searchQuery;

  const SearchChangedEvent({required this.searchQuery});

  @override
  List<Object> get props => [searchQuery];
}

// Событие загрузки списка сериалов
class LoadDataEvent extends HomeEvent {}

// Событие переключения вкладки в нижнем навигационном меню (BottomNavigationBar)
class TabSwitchedEvent extends HomeEvent {
  // Индекс вкладки на которую произошло переключение
  final int selectedTabIndex;

  const TabSwitchedEvent({required this.selectedTabIndex});

  @override
  List<Object> get props => [selectedTabIndex];
}
