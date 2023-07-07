import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/models/news_card_model.dart';
import 'package:lesson_3_homework/features/home/widgets/image_network.dart';

// Отдельный класс, через который передаются аргументы в Navigator
class NewsDetailsArguments {
  const NewsDetailsArguments(this.news);

  // Необходимые для передачи параметры
  final NewsCardModel news;
}

// Виджет страницы с более детальным описанием новости из списка
class NewsDetails extends StatefulWidget {
  // В конструкторе получаем объект класса аргументов, через который
  // сможем получить модель выбранной новости
  const NewsDetails({required this.arguments, super.key});

  final NewsDetailsArguments arguments;
  // Именованный путь для метода Navigator.pushNamed
  static const path = "/details";

  @override
  State<NewsDetails> createState() => NewsDetailsState();
}

class NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text("News"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      // Виджет SingleChildScrollView позволяет скроллить один виджет, который
      // является его потомком (в данном случае - виджет Column)
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // Выравнивание виджетов-потомков по горизонтальной оси
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.arguments.news.releaseDate,
                    maxLines: 1,
                    // Если текст не помещается в свой контейнер, то добавляем
                    // в его конец троеточие...
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    widget.arguments.news.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.purple[200],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ImageNetwork(
              widget.arguments.news.picture,
              // Виджет MediaQuery даёт доступ ко множеству свойств, описывающих
              // текущий пользовательский контекст. В данном случае мы получаем
              // полную ширину размера окна, содержащего приложение
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.arguments.news.description,
                    // Выравнивание текста по всей ширине контейнера
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.arguments.news.source,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // При нажатии на кнопку "Назад", вызываем метод pop, который
          // при помощи context находит ближайший Navigator в дереве виджетов и
          // удаляет из его стека самую верхнюю страницу (в данном случае - текущую).
          // Таким образом происходит возврат на предыдущую страницу со списком новостей
          Navigator.pop(context);
        },
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        backgroundColor: Colors.purple[200],
        child: const Icon(Icons.arrow_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      backgroundColor: Colors.black,
    );
  }
}
