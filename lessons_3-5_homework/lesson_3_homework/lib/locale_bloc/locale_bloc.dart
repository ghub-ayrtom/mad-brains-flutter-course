import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/locale_bloc/locale_event.dart';
import 'package:lesson_3_homework/locale_bloc/locale_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Основной класс BLoC-компонента локализации приложения
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  // Ключи по которым будут храниться, загружаться и сохраняться код языка,
  // а также код страны текущей локализации
  static const String lCodeKey = "languageCode";
  static const String cCodeKey = "countryCode";

  LocaleBloc() : super(const LocaleState()) {
    on<LoadLocaleEvent>(_onLocaleLoaded);
    on<ChangeLocaleEvent>(_onLocaleChanged);
  }

  // Данный метод вызывается при событии загрузки выбранной пользователем ранее
  // локализации из системного хранилища Shared Preferences
  void _onLocaleLoaded(LoadLocaleEvent event, Emitter<LocaleState> emit) async {
    // Получаем основной объект для работы с Shared Preferences
    final sharedPrefsInstance = await SharedPreferences.getInstance();

    // Получаем из него значения кода языка и кода страны по их ключам
    final String? languageCode = sharedPrefsInstance.getString(lCodeKey);
    final String? countryCode = sharedPrefsInstance.getString(cCodeKey);

    // Формируем из них объект локали для отображения локализации
    // (по умолчанию - русская)
    Locale defaultLocale = Locale(languageCode ?? "ru", countryCode ?? "RU");
    emit(state.copyWith(locale: defaultLocale));
  }

  // Данный метод вызывается при событии изменения локализации
  void _onLocaleChanged(
      ChangeLocaleEvent event, Emitter<LocaleState> emit) async {
    final sharedPrefsInstance = await SharedPreferences.getInstance();

    // Перезаписываем в объекте Shared Preferences старые значения кода языка и
    // кода страны по их ключам или записываем новые, если приложение было
    // запущено первый раз
    await sharedPrefsInstance.setString(
      lCodeKey,
      event.locale.languageCode.toString().toLowerCase(),
    );
    await sharedPrefsInstance.setString(
      cCodeKey,
      event.locale.countryCode.toString().toUpperCase(),
    );

    emit(state.copyWith(locale: event.locale));
  }
}
