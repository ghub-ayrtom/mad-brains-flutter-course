/*
  Everything's a Widget
 */

import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/widgets/main_page.dart';
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
      // В свойстве initialRoute находится путь страницы, которая
      // будет отображаться на главном экране приложения при запуске
      initialRoute: MainPage.path,
      // Свойство onGenerateRoute позволяет получить объект класса RouteSettings,
      // из которого можно узнать на какую страницу мы переходим
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == MainPage.path) {
          return MaterialPageRoute(
            builder: (context) {
              return const MainPage();
            },
          );
        }

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
