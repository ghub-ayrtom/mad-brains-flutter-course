import 'dart:async' show Future;
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter/material.dart'
    show BuildContext, Locale, Localizations, LocalizationsDelegate;
import 'package:lesson_3_homework/components/locals/en.dart';
import 'package:lesson_3_homework/components/locals/locale_base.dart';
import 'package:lesson_3_homework/components/locals/ru.dart';
import 'package:lesson_3_homework/components/locals/cn.dart';

const String ruLocale = "ru_RU"; // language code _ country code
const String enLocale = "en_US";
const String cnLocale = "zh_CN";

// Связываем языковые константы выше с соответствующими словарями
Map<String, LocaleBase> get initialLocals => <String, LocaleBase>{
      ruLocale: LocaleRu(),
      enLocale: LocaleEn(),
      cnLocale: LocaleCn(),
    };

// Связываем языковые константы выше с соответствующими локалями.
// Locale - основной объект локализации
Map<String, Locale> get availableLocales => <String, Locale>{
      ruLocale: const Locale("ru", "RU"),
      enLocale: const Locale("en", "US"),
      cnLocale: const Locale("zh", "CN"),
    };

// Расширение на контекст для получения доступа к текущей локализации
extension LocalContextExtension on BuildContext {
  // Геттер для получения словаря из текущей локализации
  LocaleBase get locale =>
      Localizations.of<Locals>(this, Locals)!.currentLocale;
}

// Класс состояния текущей локализации
class Locals {
  Locals(this.locale, this.localizedValues) {
    // При инициализации локализации, подставляем необходимый словарь по его
    // сокращённому наименованию (по умолчанию - русский)
    currentLocale =
        localizedValues[locale.toString()] ?? initialLocals[ruLocale]!;
  }

  final Locale locale; // Текущая локализация
  // Все доступные в приложении словари
  final Map<String, LocaleBase> localizedValues;
  late LocaleBase currentLocale; // Текущий словарь
}

// Делегат-обработчик для локализации
class MyLocalizationsDelegate extends LocalizationsDelegate<Locals> {
  Map<String, LocaleBase> localizedValues;

  MyLocalizationsDelegate(this.localizedValues);

  // Переопределяем метод проверки поддерживаемости приложением конкретной
  // локализации
  @override
  bool isSupported(Locale locale) =>
      localizedValues.keys.toList().contains(locale.toString());

  // Переопределяем метод загрузки локализации
  @override
  // locale - объект локализации, которую необходимо загрузить
  Future<Locals> load(Locale locale) => SynchronousFuture<Locals>(
        // Если она поддерживается, то ставим её, иначе, ставим русскую
        // локализацию
        Locals(
          isSupported(locale) ? locale : availableLocales[ruLocale]!,
          localizedValues,
        ),
      );

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
