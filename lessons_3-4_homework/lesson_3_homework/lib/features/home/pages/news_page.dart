import 'package:flutter/material.dart';
import 'package:lesson_3_homework/features/home/widgets/news_list.dart';

// Виджет экрана со списком новостей
class NewsPage extends StatefulWidget {
  const NewsPage({super.key, required this.title});

  final String title;

  @override
  State<NewsPage> createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
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
      body: const NewsList(),
      backgroundColor: Colors.black,
    );
  }
}
