import 'package:lesson_3_homework/app/models/movie_card_model.dart';

// Вспомогательный класс со списком фильмов (в данном случае ужасов)
class MoviesList {
  static final List<MovieCardModel> horrors = <MovieCardModel>[
    MovieCardModel(
      id: 0,
      title: "A Quiet Place",
      releaseDate: "2018",
      description:
          "A family struggles for survival in a world where most humans "
          "have been killed by blind but noise-sensitive creatures. They are "
          "forced to communicate in sign language to keep the creatures at bay.",
      language: "Chinese",
      rating: 7.5,
    ),
    MovieCardModel(
      id: 1,
      title: "It",
      releaseDate: "2017",
      description:
          "In the summer of 1989, a group of bullied kids band together "
          "to destroy a shape-shifting monster, which disguises itself as "
          "a clown and preys on the children of Derry, their small Maine town.",
      language: "English",
      rating: 7.3,
    ),
    MovieCardModel(
      id: 2,
      title: "Psycho",
      releaseDate: "1960",
      description:
          "A Phoenix secretary embezzles \$40,000 from her employer's client, "
          "goes on the run and checks into a remote motel run by a young man "
          "under the domination of his mother.",
      language: "French",
      rating: 8.5,
    ),
    MovieCardModel(
      id: 3,
      title: "Saw",
      releaseDate: "2004",
      description: "Two strangers awaken in a room with no recollection of how "
          "they got there, and soon discover they're pawns in a deadly game "
          "perpetrated by a notorious serial killer.",
      language: "German",
      rating: 7.6,
    ),
    MovieCardModel(
      id: 4,
      title: "The Thing",
      releaseDate: "1982",
      description:
          "A research team in Antarctica is hunted by a shape-shifting "
          "alien that assumes the appearance of its victims.",
      language: "Russian",
      rating: 8.2,
    ),
    MovieCardModel(
      id: 5,
      title: "Astral",
      picture:
          "https://upload.wikimedia.org/wikipedia/en/3/3e/Astral%28Film%29Poster.jpeg",
      releaseDate: "2018",
      description:
          "A detached university student faces the consequences of astral "
          "projection when he uses it to reconnect with his dead mother.",
      language: "Arabic",
      rating: 4.6,
    ),
  ];

  // Функция для фильтрации списка фильмов по убыванию их рейтинга
  static void horrorsRatingSort() {
    horrors.sort((a, b) => b.rating.compareTo(a.rating));
  }
}
