import 'package:flutter/material.dart';
import 'dart:async';

List<HorrorMovie> horrors = [];

void main()
{
  runApp(const MyApp());

  HorrorMovie m1 = HorrorMovie("A Quiet Place", 4.3);
  HorrorMovie m2 = HorrorMovie("It", 4.4);
  HorrorMovie m3 = HorrorMovie("Psycho", 4.6);
  HorrorMovie m4 = HorrorMovie("Saw", 4.5);
  HorrorMovie m5 = HorrorMovie("The Thing", 4.7);

  horrors.add(m1);
  horrors.add(m2);
  horrors.add(m3);
  horrors.add(m4);
  horrors.add(m5);

  m1.language = "Chinese";
  m2.language = "English";
  m3.language = "French";
  m4.language = "German";
  m5.language = "Russian";
}

// Класс виджета приложения без состояний (StatelessWidget)
class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  // Переопределяем метод build, который отвечает за создание виджета, а также
  // за то как он будет выглядеть
  @override
  Widget build(BuildContext context)
  {
    // Виджет MaterialApp предназначен для создания графического интерфейса в
    // стиле Material Design (Android)
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple[100]!),
        useMaterial3: true,
      ),
      // Свойство home - это то, что будет отображаться на главном экране приложения
      home: const MyHomePage(title: "Movies List"),
    );
  }
}

// Класс виджета главного экрана приложения с состояниями (StatefulWidget)
class MyHomePage extends StatefulWidget
{
  const MyHomePage({super.key, required this.title});

  final String title;

  // Создаём начальное состояние
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Класс начального состояния виджета MyHomePage
class _MyHomePageState extends State<MyHomePage>
{
  List<MovieCardWidget> horrorsList = [];

  // Асинхронные методы можно вызывать только из асинхронных функций
  void _generateListOfMovies() async
  {
    horrorsList = await listOfMovies(); // Вызов асинхронного метода
  }

  // Функция для фильтрации фильмов по рейтингу
  void horrorsRatingSort()
  {
    horrorsList.sort((a, b) => b.m.rating!.compareTo(a.m.rating!));
  }

  // Переопределяем метод initState, который отвечает за инициализацию виджета
  @override
  void initState()
  {
    super.initState();

    // Функция setState обновляет состояние виджета, перерисовывает его и его потомков
    setState(()
    {
      _generateListOfMovies();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - виджет для компоновки пользовательского интерфейса
    return Scaffold(
      // AppBar - виджет верхнего меню
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              // ListView - виджет списка
              child: ListView(
                scrollDirection: Axis.horizontal,
                // В качестве элементов списка ListView указываем список фильмов,
                // который мы получили выше во вспомогательной функции _generateListOfMovies
                children: [...horrorsList],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 145, right: 145),
              child: ElevatedButton(
                  // Функция, которая вызывается по нажатию на кнопку
                  onPressed: ()
                  {
                    // Сортируем список фильмов по убыванию рейтинга
                    horrorsRatingSort();
                    // Обновляем состояние виджета, чтобы увидеть изменения
                    setState(() { });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                      ),
                      Text("Sort")
                    ],
                  )
              ),
            )
          ],
        ),
      ), backgroundColor: Colors.black,
    );
  }
}

abstract class Movie
{
  String? id, title, picture, releaseDate, description, language;
  double? rating;

  Movie.build(this.title, this.rating); // Конструктор для дочернего класса
}

class HorrorMovie extends Movie
{
  HorrorMovie(title, rating) : super.build(title, rating);
}

// Асинхронный метод, который возвращает список фильмов
Future listOfMovies() async
{
  List<MovieCardWidget> tempList = [];
  Iterator i = horrors.iterator; // Получаем итератор списка для его перебора

  while (i.moveNext())
  {
    tempList.add(MovieCardWidget(m: i.current));
  }

  return tempList;
}

// Класс виджета карточки фильма с состояниями
class MovieCardWidget extends StatefulWidget 
{
  final HorrorMovie m;

  // required - обязательный параметр
  const MovieCardWidget({super.key, required this.m});

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> 
{
  @override
  void initState() { super.initState(); }

  @override
  Widget build(BuildContext context)
  {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(
          color: Colors.purple[200],
          child: SizedBox(
            height: 285,
            width: 150,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                          // widget - любой из экземпляров данного виджета
                          "assets/${widget.m.title.toString().toLowerCase()}.jpeg",
                          width: 140,
                          height: 200,
                          fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                        widget.m.title.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                    ),
                    Text(
                        widget.m.language.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic
                        ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                            Icons.star,
                            color: Colors.yellow,
                        ),
                        Text(
                          widget.m.rating.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}