// Класс модели карточки сериала для отображения на UI
class ShowCardModel {
  ShowCardModel({
    required this.id,
    required this.title,
    this.picture,
    this.releaseDate,
    this.description,
    this.language,
    this.rating = 0.0,
    this.isFavorite = false,
  });

  final String id;
  final String title;
  final String? picture;
  final String? releaseDate;
  late String? description;
  late String? language;
  late double? rating;
  bool isFavorite;
}
