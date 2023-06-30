import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/models/news_card_model.dart';
import 'package:lesson_3_homework/features/home/widgets/image_network.dart';

// Виджет карточки новости
class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    required this.id,
    required this.title,
    required this.picture,
    required this.releaseDate,
    required this.description,
    required this.source,
    Key? key,
  }) : super(key: key);

  // factory - именованный конструктор, который позволяет взять из модели только
  // необходимые параметры и соединить их с вёрсткой.
  // Модели хранят в себе параметры объекта, которые могут быть показаны пользователю
  factory NewsCardWidget.fromModel({
    required NewsCardModel
        model, // Объект класса модели (/app/models/news_card_model.dart)
    Key? key,
  }) {
    return NewsCardWidget(
      id: model.id,
      title: model.title,
      picture: model.picture,
      releaseDate: model.releaseDate,
      description: model.description,
      source: model.source,
      key: key,
    );
  }

  final int id;
  final String title, picture, releaseDate, description, source;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageNetwork(picture, width: 150),
        Expanded(
          // Флекс-фактор указывает на часть пространства контейнера, которая
          // будет отдаваться виджету Expanded. При вычислении данной части
          // пространства флекс-фактор данного виджета делиться на сумму флекс-факторов всех элементов.
          // Полученное значение умножается на общее доступное простанство контейнера
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  releaseDate,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.purple[200],
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  source,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Divider(
                  height: 20,
                  color: Colors.purple[200],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
