import 'package:flutter/material.dart';
import 'package:lesson_3_homework/features/home/widgets/movies_grid.dart';
import 'package:lesson_3_homework/features/home/widgets/movies_list.dart';

// Виджет главного экрана приложения с состояниями (StatefulWidget)
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  // Создаём начальное состояние
  @override
  State<HomePage> createState() => HomePageState();
}

// Класс начального состояния виджета HomePage
class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold - виджет для компоновки пользовательского интерфейса
    return Scaffold(
      // AppBar - виджет верхнего меню
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              // По нажатию на данную кнопку сортируем список фильмов по рейтингу
              // и обновляем состояние виджета
              setState(() {
                MoviesList.horrorsRatingSort();
              });
            },
            icon: const Icon(Icons.sort),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body:
          // Если добавить ключевое слово const, то состояние виджета перестанет
          // обновляться и сортировку списка фильмов по рейтингу нельзя будет отследить
          MoviesGrid(),
      backgroundColor: Colors.black,
    );
  }
}
