import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_event.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Основной класс BLoC-компонента экрана настроек, в котором собраны
// все события (файл settings_event.dart) и состояния (файл settings_state.dart)
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  // Ключ по которому будет храниться, а также загружаться, сохраняться и
  // удаляться значение любимого жанра сериалов пользователя
  static const String genreKey = "genre";

  SettingsBloc() : super(const SettingsState()) {
    // Ниже привязка событий из класса SettingsEvent к бизнес-логике самого
    // BLoC-компонента
    on<LoadGenreEvent>(_onLoadGenre);
    on<SaveGenreEvent>(_onSaveGenre);
    on<ClearGenreEvent>(_onClearGenre);
  }

  // Данный метод вызывается при событии загрузки любимого жанра сериалов
  // пользователя из системного хранилища Shared Preferences
  void _onLoadGenre(LoadGenreEvent event, Emitter<SettingsState> emit) async {
    // Получаем основной объект для работы с Shared Preferences
    final sharedPrefsInstance = await SharedPreferences.getInstance();
    // Получаем из него значение жанра по ключу
    final String? genre = sharedPrefsInstance.getString(genreKey);

    // emit - отправка сообщения об изменении состояния виджетов.
    // В качестве аргументов передаются новые значения полей, определённых
    // в классе SettingsState
    emit(state.copyWith(genre: genre));
  }

  // Данный метод вызывается при событии сохранения жанра в Shared Preferences
  void _onSaveGenre(SaveGenreEvent event, Emitter<SettingsState> emit) async {
    final sharedPrefsInstance = await SharedPreferences.getInstance();
    // Записываем в объект Shared Preferences новое значение жанра по ключу
    await sharedPrefsInstance.setString(genreKey, event.genre);

    emit(state.copyWith(genre: event.genre));
  }

  // Данный метод вызывается при событии удаления жанра из Shared Preferences
  void _onClearGenre(ClearGenreEvent event, Emitter<SettingsState> emit) async {
    final sharedPrefsInstance = await SharedPreferences.getInstance();
    // Удаляем из объекта Shared Preferences значение жанра по ключу
    await sharedPrefsInstance.remove(genreKey);

    emit(state.copyWith()); // genre == null
  }
}
