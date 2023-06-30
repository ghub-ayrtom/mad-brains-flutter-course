// Модель (класс) карточки с фильмом.
class MovieCardModel {
  MovieCardModel({
    required this.id,
    required this.title,
    this.picture = "",
    this.releaseDate = "",
    this.description = "",
    this.language = "",
    this.rating = 0.0,
    this.isFavorite = false,
  });

  final int id;
  final String title, picture, releaseDate, description, language;
  final double rating;
  bool isFavorite;
}
