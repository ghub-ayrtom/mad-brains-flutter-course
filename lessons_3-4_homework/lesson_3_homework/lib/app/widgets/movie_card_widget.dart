import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/models/movie_card_model.dart';
import 'package:lesson_3_homework/features/home/widgets/image_network.dart';

// Виджета карточки фильма без состояний
class MovieCardWidget extends StatelessWidget {
  // required - обязательный параметр
  MovieCardWidget({
    required this.id,
    required this.title,
    required this.picture,
    required this.releaseDate,
    required this.description,
    required this.language,
    required this.rating,
    required this.isFavorite,
    Key? key,
  }) : super(key: key);

  // factory - именованный конструктор, который позволяет взять из модели только
  // необходимые параметры и соединить их с вёрсткой.
  // Модели хранят в себе параметры объекта, которые могут быть показаны пользователю
  factory MovieCardWidget.fromModel({
    required MovieCardModel
        model, // Объект класса модели (/app/models/movie_card_model.dart)
    Key? key,
  }) {
    return MovieCardWidget(
      id: model.id,
      title: model.title,
      picture: model.picture,
      releaseDate: model.releaseDate,
      description: model.description,
      language: model.language,
      rating: model.rating,
      isFavorite: model.isFavorite,
      key: key,
    );
  }

  final int id;
  final String title, picture, releaseDate, description, language;
  final double rating;
  bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.purple[200],
        child: SizedBox(
          width: 150,
          height: 270,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              // Виджет Stack позволяет размещать виджеты друг над другом
              Stack(children: [
                // Виджет ClipRRect позволяет закруглить края изображения
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: picture == ""
                      ? Image.asset(
                          // true
                          "assets/${title.toLowerCase()}.jpeg",
                          width: 140,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : ImageNetwork(picture, width: 140, height: 200), // false
                ),
                // Positioned - виджет, который будет размещён над виджетом выше
                Positioned(
                  top: 20,
                  right: -25,
                  child: _RatingChip(rating),
                ),
              ]),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                language,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

// Виджет плашки с рейтингом фильма
class _RatingChip extends StatelessWidget {
  const _RatingChip(this.rating);

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..scale(0.75),
      child: Chip(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        avatar: const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        label: Text(
          rating.toStringAsFixed(1),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: rating < 5.0
                ? Colors.redAccent // true
                : rating < 8.0 // false
                    ? Colors.orangeAccent
                    : Colors.greenAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[200],
      ),
    );
  }
}
