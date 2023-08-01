import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/presentation/app/widgets/show_card_widget.dart';

// Виджет сетки списка сериалов
class SeriesGrid extends StatefulWidget {
  const SeriesGrid(this.data, {super.key});

  // Данные для отображения
  final AsyncSnapshot<HomeModel?> data;

  @override
  State<SeriesGrid> createState() => _SeriesGridState();
}

class _SeriesGridState extends State<SeriesGrid> {
  // Асинхронный метод для отображения виджета SimpleDialog с описанием выбранного сериала
  Future _showMovieDescription(int index) async {
    // Текст для отображения в диалоге, если у сериала нет описания
    String parsedString = "Unknown";

    // Если у сериала есть описание
    if (widget.data.data?.results?[index].description != null) {
      // Используя библиотеку html удаляем из него все HTML-теги
      final document = parse(widget.data.data?.results?[index].description);
      parsedString = parse(document.body?.text).documentElement?.text ?? "";
    }

    await showDialog(
      context: context,
      builder: (BuildContext inContext) {
        return SimpleDialog(
          title: Text(
            "${widget.data.data?.results?[index].title} ${Local.description}",
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          children: [
            SimpleDialogOption(
              child: Text(parsedString),
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
        itemCount: widget.data.data?.results?.length ?? 0,
        itemBuilder: (BuildContext context, int listElementIndex) {
          // Виджет GestureDetector - детектор жестов. В данном случае, жест нажатия на определённую карточку сериала
          return GestureDetector(
            onTap: () {
              _showMovieDescription(listElementIndex);
            },
            child: Stack(
              children: [
                ShowCardWidget(
                  // Последовательный перебор элементов списка сериалов по индексу и их отображение
                  showCardModel: widget.data.data?.results?[listElementIndex],
                  // Так как мы отображаем список однотипных элементов (карточек сериала), то
                  // важно использовать свойство key для того, чтобы не происходило их
                  // кэширования при обновлении списка
                  key: ValueKey<String>(
                    widget.data.data?.results?[listElementIndex].id ?? "",
                  ),
                ),
                Positioned(
                  top: 150,
                  bottom: 0,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        // Если сериал уже в избранном
                        if (widget.data.data?.results?[listElementIndex]
                                .isFavorite ??
                            false) {
                          widget.data.data?.results?[listElementIndex]
                              .isFavorite = false; // Удаляем его оттуда
                        } else {
                          // Иначе делаем сериал избранным
                          widget.data.data?.results?[listElementIndex]
                              .isFavorite = true;
                        }
                      });
                    },
                    icon: widget.data.data?.results?[listElementIndex]
                                .isFavorite ??
                            false
                        ? const Icon(Icons.favorite) // true
                        : const Icon(Icons.favorite_border), // false
                    style: IconButton.styleFrom(
                      // Отключён эффект чернильницы при нажатии
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
          childAspectRatio: 0.580,
        ),
      ),
    );
  }
}
