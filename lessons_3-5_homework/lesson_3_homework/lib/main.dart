/*
  Everything's a Widget
 */

import 'package:flutter/material.dart';
// BLoC (Business Logic Component, Компонент Бизнес-логики) - один из основных
// подходов к state management (управлению состояниями виджетов) во Flutter.
// В BLoC каждое окно приложения отделено своей логикой от других
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/data/repositories/series_repository.dart';
import 'package:lesson_3_homework/error_bloc/error_bloc.dart';
import 'package:lesson_3_homework/error_bloc/error_event.dart';
import 'package:lesson_3_homework/presentation/app/widgets/main_page.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_bloc.dart';
import 'package:lesson_3_homework/presentation/home/pages/news_details.dart';

void main() {
  runApp(const MyApp()); // Запуск приложения
}

// Виджет приложения без состояний (StatelessWidget)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Переопределяем метод build, который отвечает за создание виджета, а также
  // за то как он будет выглядеть
  @override
  Widget build(BuildContext context) {
    // Виджет MaterialApp предназначен для создания графического интерфейса в
    // стиле Material Design (Android)
    return MaterialApp(
      title: 'Series List App',
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
          // BlocProvider главного экрана приложения (желательно перенести его туда)
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
        // Если путь перехода совпадает в заданным
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

        return null;
      },
    );
  }
}
