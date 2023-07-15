import 'package:flutter/material.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:lesson_3_homework/presentation/home/widgets/image_network.dart';

// Виджета карточки сериала без состояний
class ShowCardWidget extends StatelessWidget {
  const ShowCardWidget({
    this.showCardModel,
    Key? key,
  }) : super(key: key);

  // Модель карточки сериала, данные которой необходимо отобразить в виджете
  final ShowCardModel? showCardModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          width: 150,
          height: 270,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.5),
                child: Text(
                  showCardModel?.releaseDate ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              // Виджет Stack позволяет размещать виджеты друг над другом
              Stack(children: [
                // Виджет ClipRRect позволяет закруглить края изображения
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageNetwork(
                    showCardModel?.picture ?? "",
                    width: 140,
                    height: 200,
                  ),
                ),
                // Positioned - виджет, который будет размещён над виджетом выше
                Positioned(
                  top: 20,
                  right: -25,
                  child: _RatingChip(showCardModel?.rating ?? 0.0),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  showCardModel?.title ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                showCardModel?.language ?? "Unknown",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: showCardModel?.language != null
                      ? Colors.white
                      : Colors.white54,
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

// Виджет плашки с IMDb рейтингом сериала
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
        backgroundColor: Colors.deepPurple[400],
      ),
    );
  }
}
