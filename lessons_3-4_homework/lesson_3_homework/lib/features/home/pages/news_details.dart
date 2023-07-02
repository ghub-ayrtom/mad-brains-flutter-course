import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/models/news_card_model.dart';
import 'package:lesson_3_homework/features/home/widgets/image_network.dart';

// Виджет страницы с более детальным описанием новости из списка
class NewsDetails extends StatefulWidget {
  // В конструкторе получаем модель выбранной новости и callback-функцию для сокрытия
  // данного виджета
  const NewsDetails(this.news, this.hideNewsDetails, {super.key});

  final NewsCardModel news;
  final Function hideNewsDetails;

  @override
  State<NewsDetails> createState() => NewsDetailsState();
}

class NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    widget.news.releaseDate,
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
                    widget.news.title,
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
              widget.news.picture,
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
                    widget.news.description,
                    // Выравнивание текста по всей ширине контейнера
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.news.source,
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
          // При нажатии на кнопку "Назад", вызываем callback-функцию, которая
          // обновит состояние родителя данного виджета, а именно его параметр body
          widget.hideNewsDetails();
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
