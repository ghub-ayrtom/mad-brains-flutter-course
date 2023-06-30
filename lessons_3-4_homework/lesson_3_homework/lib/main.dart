/*
  Everything's a Widget
 */

import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/widgets/main_page.dart';

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
      title: 'Movies List App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple[100]!),
        useMaterial3: true,
      ),
      // Свойство home - это то, что будет отображаться на главном экране приложения
      home: const MainPage(),
    );
  }
}
