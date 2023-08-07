import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/data/repositories/series_repository.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_event.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_state.dart';

// Основной класс BLoC-компонента главного экрана приложения, в котором собраны
// все события (файл home_event.dart) и состояния (файл home_state.dart)
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SeriesRepository repository;

  HomeBloc(this.repository) : super(const HomeState(selectedTabIndex: 0)) {
    // Ниже привязка событий из класса HomeEvent к бизнес-логике самого
    // BLoC-компонента
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangeEvent>(_onSearchChanged);
    on<TabSwitchEvent>(_onTabSwitched);
    on<AddFavoriteShowEvent>(_onFavoriteAdded);
    on<RemoveFavoriteShowEvent>(_onFavoriteRemoved);
    on<DBSeriesChangeEvent>(_onDBChanged);
    on<SeriesRatingSortEvent>(_onSeriesSorted);

    // Подписываемся (listen) на Stream (поток) об изменениях данных в БД
    repository
        .onChangeShows()
        // changedSeries - обновлённые данные
        .listen((List<ShowCardModel> changedSeries) async {
      // Создаём объект единой общей модели для отображения на UI
      HomeModel model = HomeModel(changedSeries);

      // Добавляем соответствующее событие, преобразуя модель в необходимый для
      // отображения на пользовательском интерфейсе формат (Future<HomeModel?>)
      add(DBSeriesChangeEvent(series: homeModelToFuture(model)));
    });
  }

  // Метод для преобразования объекта HomeModel в объект Future<HomeModel?>
  // (особенность формата хранения данных для отображения)
  Future<HomeModel?> homeModelToFuture(HomeModel model) async {
    return model;
  }

  // Геттер-метод для получения текущего значения поля поиска
  String get search {
    final stateSearch = state.searchQuery;

    return (stateSearch != null && stateSearch.isNotEmpty)
        ? stateSearch
        : Query.initialQ;
  }

  // Данный метод вызывается при событии изменения поля поиска сериала
  void _onSearchChanged(SearchChangeEvent event, Emitter<HomeState> emit) {
    // Если поиск осуществляется на основной странице (Feed)
    if (state.selectedTabIndex == 0) {
      // emit - отправка сообщения об изменении состояния виджетов.
      // В качестве аргументов передаются новые значения полей, определённых
      // в классе HomeState
      emit(state.copyWith(search: event.searchQuery));
      // Обновляем data - общий список сериалов
      emit(state.copyWith(data: repository.loadData(search)));
    } else {
      // Иначе, поиск осуществляется на странице избранного (Favorites)
      emit(state.copyWith(search: event.searchQuery));
      // Обновляем shows - список избранных сериалов
      emit(state.copyWith(shows: repository.getSearchedSeries(search)));
    }
  }

  // Данный метод вызывается при событии загрузки списка сериалов
  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(search)));
  }

  // Данный метод вызывается при событии переключения вкладки в нижнем
  // навигационном меню (BottomNavigationBar)
  void _onTabSwitched(TabSwitchEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(index: event.selectedTabIndex));
    emit(state.copyWith(search: Query.initialQ));
    emit(state.copyWith(shows: repository.getAllSeries()));
  }

  // Данный метод вызывается при событии добавления сериала в избранное
  void _onFavoriteAdded(
      AddFavoriteShowEvent event, Emitter<HomeState> emit) async {
    // Выбранный пользователем сериал
    final ShowCardModel? targetShow = event.model;

    if (targetShow != null) {
      // Подробнее о методе insertShow в файле series_repository.dart
      // (../../data/repositories)
      await repository.insertShow(targetShow);
    }
  }

  // Данный метод вызывается при событии удаления сериала из избранного
  void _onFavoriteRemoved(
      RemoveFavoriteShowEvent event, Emitter<HomeState> emit) async {
    final ShowCardModel? targetShow = event.model;

    if (state.favoriteShows != null) {
      if (targetShow != null) {
        await repository.deleteShow(targetShow.id);
      }
    }
  }

  // Данный метод вызывается при событии изменения данных в БД
  void _onDBChanged(DBSeriesChangeEvent event, Emitter<HomeState> emit) {
    // event.series - обновлённые данные
    emit(state.copyWith(shows: event.series));
  }

  // Данный метод вызывается при событии сортировки списка сериалов по убыванию
  // их IMDb-рейтинга
  void _onSeriesSorted(SeriesRatingSortEvent event, Emitter<HomeState> emit) {
    // event.series - список сериалов (List<ShowCardModel>)
    event.series.sort((a, b) => b.rating!.compareTo(a.rating!));
    HomeModel model = HomeModel(event.series);

    // Если сортировка осуществляется на основной странице (Feed)
    if (state.selectedTabIndex == 0) {
      emit(state.copyWith(data: homeModelToFuture(model)));
    } else {
      // Иначе, сортировка осуществляется на странице избранного (Favorites)
      emit(state.copyWith(shows: homeModelToFuture(model)));
    }
  }
}
