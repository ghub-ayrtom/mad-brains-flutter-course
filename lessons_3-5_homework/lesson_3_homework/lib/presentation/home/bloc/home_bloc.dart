import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/data/repositories/series_repository.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_event.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_state.dart';

// Основной класс BLoC-компонента главного экрана приложения, в котором собраны
// все события (файл  home_event.dart) и состояния (файл home_state.dart)
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SeriesRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    // Ниже привязка событий из класса HomeEvent к бизнес-логике самого
    // BLoC-компонента
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);
    on<TabSwitchedEvent>(_onTabSwitched);
  }

  // Геттер-метод для получения текущего значения поля поиска
  String get search {
    final stateSearch = state.searchQuery;

    return (stateSearch != null && stateSearch.isNotEmpty)
        ? stateSearch
        : Query.initialQ;
  }

  // Данный метод вызывается при событии изменения поля поиска сериала
  void _onSearchChanged(SearchChangedEvent event, Emitter<HomeState> emit) {
    // emit - отправка сообщения об изменении состояния виджетов.
    // В качестве аргументов передаются новые значения полей, определённых
    // в классе HomeState
    emit(state.copyWith(search: event.searchQuery));
    emit(state.copyWith(data: repository.loadData(search)));
  }

  // Данный метод вызывается при событии загрузки списка сериалов
  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(search)));
  }

  // Данный метод вызывается при событии переключения вкладки в нижнем
  // навигационном меню (BottomNavigationBar)
  void _onTabSwitched(TabSwitchedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(index: event.selectedTabIndex));
  }
}
