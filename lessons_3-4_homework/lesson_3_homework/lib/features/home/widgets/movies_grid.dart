import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/widgets/movie_card_widget.dart';
import 'package:lesson_3_homework/features/home/widgets/movies_list.dart';

// Виджет сетки списка фильмов
class MoviesGrid extends StatefulWidget {
  const MoviesGrid({super.key});

  @override
  State<MoviesGrid> createState() => _MoviesGridState();
}

class _MoviesGridState extends State<MoviesGrid> {
  // Асинхронный метод для отображения виджета SimpleDialog с описанием выбранного фильма
  Future _showMovieDescription(int index) async {
    await showDialog(
      context: context,
      builder: (BuildContext inContext) {
        return SimpleDialog(
          title: Text("${MoviesList.horrors[index].title} Movie Description"),
          children: [
            SimpleDialogOption(
              child: Text(MoviesList.horrors[index].description),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      // GridView - подобие таблицы виджетов
      child: GridView.builder(
        itemCount: MoviesList.horrors.length,
        itemBuilder: (BuildContext context, int listElementIndex) {
          // Виджет GestureDetector - детектор жестов. В данном случае, жест нажатия на определённую карточку фильма
          return GestureDetector(
            onTap: () {
              _showMovieDescription(listElementIndex);
            },
            child: Stack(
              children: [
                MovieCardWidget.fromModel(
                  // Последовательный перебор элементов списка фильмов по индексу и их отображение
                  model: MoviesList.horrors[listElementIndex],
                ),
                Positioned(
                  top: 150,
                  bottom: 10,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        // Если фильм уже в избранном
                        if (MoviesList.horrors[listElementIndex].isFavorite) {
                          MoviesList.horrors[listElementIndex].isFavorite =
                              false; // Удаляем его оттуда
                        } else {
                          // Иначе делаем фильм избранным
                          MoviesList.horrors[listElementIndex].isFavorite =
                              true;
                        }
                      });
                    },
                    icon: MoviesList.horrors[listElementIndex].isFavorite
                        ? const Icon(Icons.favorite) // true
                        : const Icon(Icons.favorite_border), // false
                    style: IconButton.styleFrom(
                      // Отключен эффект чернильницы при нажатии
                      splashFactory: NoSplash.splashFactory,
                    ),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
        // gridDelegate - свойство, которое управляет расположением дочерних элементов в GridView.
        // Виджет SliverGridDelegateWithFixedCrossAxisCount создаёт макеты сетки
        // с фиксированным количеством плиток по поперечной оси (в данном случае 2 плитки)
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.595,
        ),
      ),
    );
  }
}
