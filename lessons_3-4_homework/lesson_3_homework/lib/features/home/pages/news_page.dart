import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/models/news_card_model.dart';
import 'package:lesson_3_homework/features/home/pages/news_details.dart';
import 'package:lesson_3_homework/features/home/widgets/news_list.dart';

// Виджет экрана со списком новостей
class NewsPage extends StatefulWidget {
  NewsPage({super.key, required this.title});

  final String title;
  late NewsCardModel news; // Модель выбранной из списка новости

  @override
  State<NewsPage> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  // Булевая переменная нажатия на определённую новость из списка
  bool newsTapped = false;

  // Метод для отображения деталей выбранной новости
  void showNewsDetails(NewsCardModel model) {
    // Обновляем состояние данного виджета для отображения изменений
    setState(() {
      widget.news = model;
      newsTapped = true;
    });
  }

  // Функция для сокрытия деталей выбранной новости
  void hideNewsDetails() {
    setState(() {
      newsTapped = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: newsTapped
          ? NewsDetails(widget.news, hideNewsDetails) // true
          : NewsList(showNewsDetails), // false (по умолчанию)
      backgroundColor: Colors.black,
    );
  }
}
