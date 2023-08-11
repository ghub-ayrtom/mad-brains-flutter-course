import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:lesson_3_homework/presentation/app/widgets/show_card_widget.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_bloc.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_event.dart';
import 'package:collection/collection.dart';

// Виджет сетки списка сериалов
class SeriesGrid extends StatefulWidget {
  const SeriesGrid(this.data, this.favoriteShows, {super.key});

  // Данные для отображения
  final AsyncSnapshot<HomeModel?> data; // на экране с общим списком сериалов
  final List<ShowCardModel>?
      favoriteShows; // на экране со списком избранных сериалов

  @override
  State<SeriesGrid> createState() => _SeriesGridState();
}

class _SeriesGridState extends State<SeriesGrid> {
  // Асинхронный метод для отображения виджета SimpleDialog с описанием выбранного сериала
  Future _showMovieDescription(int index) async {
    Text titleText = Text(context.locale.unknown);
    // Текст по умолчанию для отображения в диалоге, если у сериала нет описания
    String parsedString = context.locale.unknown;
    // Двузначный код языка текущей локализации приложения
    String currentLanguageCode = Localizations.localeOf(context).languageCode;

    switch (currentLanguageCode) {
      case "ru":
        // "Описание сериала ...", если язык приложения русский
        titleText = Text(
          "${context.locale.description} ${widget.data.data?.results?[index].title}",
        );
        break;

      default:
        // "... {context.locale.description}" при любом другом языке
        titleText = Text(
          "${widget.data.data?.results?[index].title} ${context.locale.description}",
        );
        break;
    }

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
          title: titleText,
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
          // Если список избранных сериалов не пуст
          if (widget.favoriteShows?.isNotEmpty == true) {
            // Пытаемся найти в нём текущий отображаемый сериал по его ID
            var favoriteShow = widget.favoriteShows?.firstWhereOrNull((show) =>
                show.id == widget.data.data?.results?[listElementIndex].id);

            // Если нашли
            if (favoriteShow != null) {
              // Делаем его избранным ещё раз, так как загрузка сериалов
              // происходит из разных мест (API и БД)
              widget.data.data?.results?[listElementIndex].isFavorite = true;
            }
          }

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
                      // Если сериал уже в избранном
                      if (widget.data.data?.results?[listElementIndex]
                              .isFavorite ??
                          false) {
                        widget.data.data?.results?[listElementIndex]
                            .isFavorite = false; // Удаляем его оттуда

                        // Добавляем соответствующее событие (event) в основной
                        // BLoC-компонент главного экрана приложения
                        // (подробнее в директории ../home/bloc)
                        context.read<HomeBloc>().add(
                              RemoveFavoriteShowEvent(
                                model: widget
                                    .data.data?.results?[listElementIndex],
                              ),
                            );
                      } else {
                        // Иначе делаем сериал избранным
                        widget.data.data?.results?[listElementIndex]
                            .isFavorite = true;

                        // Добавляем соответствующее событие в HomeBloc
                        context.read<HomeBloc>().add(
                              AddFavoriteShowEvent(
                                model: widget
                                    .data.data?.results?[listElementIndex],
                              ),
                            );
                      }
                    },
                    icon: widget.data.data?.results?[listElementIndex]
                                .isFavorite ??
                            false
                        ? const Icon(Icons.favorite) // true
                        : const Icon(Icons.favorite_border), // false
                    style: IconButton.styleFrom(
                      // Отключаем эффект чернильницы при нажатии
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
