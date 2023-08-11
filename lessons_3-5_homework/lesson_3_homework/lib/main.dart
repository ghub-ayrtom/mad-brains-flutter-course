/*
  Everything's a Widget
 */

import 'package:country_codes/country_codes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
// BLoC (Business Logic Component, Компонент Бизнес-логики) - один из основных
// подходов к state management (управлению состояниями виджетов) во Flutter.
// В BLoC каждое окно приложения отделено своей логикой от других
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';
import 'package:lesson_3_homework/data/repositories/series_repository.dart';
import 'package:lesson_3_homework/error_bloc/error_bloc.dart';
import 'package:lesson_3_homework/error_bloc/error_event.dart';
import 'package:lesson_3_homework/locale_bloc/locale_bloc.dart';
import 'package:lesson_3_homework/locale_bloc/locale_event.dart';
import 'package:lesson_3_homework/locale_bloc/locale_state.dart';
import 'package:lesson_3_homework/presentation/app/widgets/main_page.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_bloc.dart';
import 'package:lesson_3_homework/presentation/home/pages/news_details.dart';
import 'package:lesson_3_homework/presentation/settings/pages/settings_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  // Прединициализация виджетов для предотвращения ошибки
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем подключенные сервисы Firebase
  await Firebase.initializeApp();
  // Включаем у Firebase Crashlytics возможность сбора всех коллекций
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  // Позволяем Crashlytics записывать все предупреждения, исключения и ошибки
  // Flutter
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // Инициализируем основной объект для работы с библиотекой Country Codes,
  // которая позволяет получить дополнительную информацию о локализации
  // (двузначный код страны, код номера телефона, название страны и так далее)
  await CountryCodes.init();

  runApp(const MyApp()); // Запуск приложения
}

// Виджет приложения без состояний (StatelessWidget)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Переопределяем метод build, который отвечает за создание виджета, а также
  // за то как он будет выглядеть
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocaleBloc>(
      lazy: false,
      // Инициализируем локализацию, которая ранее была выбрана пользователем
      create: (_) => LocaleBloc()..add(LoadLocaleEvent()),
      // Будем перестраивать всё приложение при возникновении соответствующих
      // событий, связанных с локализацией
      child: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          // Виджет MaterialApp предназначен для создания графического интерфейса в
          // стиле Material Design (Android)
          return MaterialApp(
            title: "Slapp",
            locale: state.locale, // Текущая локализация всего приложения
            localizationsDelegates: <LocalizationsDelegate<dynamic>>[
              // Ниже 3 делегата-обработчика по умолчанию
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              // При смене локали, наш делегат будет проверять её на возможность
              // использования, сверяясь со свойством supportedLocales ниже, и
              // загружать соответствующий словарь
              MyLocalizationsDelegate(initialLocals),
            ],
            // Поддерживаемые приложением локали для делегата-обработчика выше
            supportedLocales: availableLocales.values,
            // BlocProvider - модифицированный Provider для использования BLoC.
            // Позволяет получить доступ к экземпляру BLoC во всех дочерних виджетах
            // через обращение к BuildContext
            home: BlocProvider<ErrorBloc>(
              // Будет создаваться заранее до первого обращения к ErrorBloc
              lazy: false,
              // Общий BLoC-компонент для отображения ошибок
              create: (_) => ErrorBloc(),
              // Дочерний виджет, из которого можно получить доступ к данному BLoC-компоненту
              child: RepositoryProvider<SeriesRepository>(
                lazy: true,
                // Создаём репозиторий только один раз, чтобы все его дочерние виджеты
                // делали запрос через него (аналог Singleton)
                create: (BuildContext context) => SeriesRepository(
                  context,
                  // При возникновении ошибки при работе с репозиторием, добавляем
                  // соответствующее событие (ивент) в ErrorBloc
                  onErrorHandler: (String code, String message) {
                    context.read<ErrorBloc>().add(
                          ShowDialogEvent(
                            title: code,
                            message: message,
                          ),
                        );
                  },
                ),
                child: BlocProvider<HomeBloc>(
                  lazy: false,
                  create: (BuildContext context) => HomeBloc(
                    context.read<SeriesRepository>(), // Читаем наш репозиторий
                  ),
                  child: const MainPage(),
                ),
              ),
            ),
            // Свойство onGenerateRoute позволяет получить объект класса RouteSettings,
            // из которого можно узнать на какую страницу мы переходим
            onGenerateRoute: (RouteSettings settings) {
              // Если путь перехода совпадает в заданным (страница новостей)
              if (settings.name == NewsDetails.path) {
                // Формируем аргументы из Object settings.arguments
                final NewsDetailsArguments arguments =
                    settings.arguments as NewsDetailsArguments;
                return MaterialPageRoute(
                  builder: (context) {
                    return NewsDetails(arguments: arguments);
                  },
                );
              }

              // Переход на страницу настроек
              if (settings.name == SettingsPage.path) {
                return MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
