import 'package:flutter/material.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';
import 'package:lesson_3_homework/presentation/home/widgets/news_list.dart';
import 'package:lesson_3_homework/presentation/settings/pages/settings_page.dart';

// Виджет экрана со списком новостей
class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          context.locale.newsPagesTitle,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Переход на страницу настроек
              Navigator.pushNamed(context, SettingsPage.path);
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      body: const NewsList(),
      backgroundColor: Colors.black,
    );
  }
}
