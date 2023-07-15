// Класс модели карточки новости для отображения на UI
class NewsCardModel {
  NewsCardModel({
    required this.id,
    required this.title,
    this.picture = "",
    this.releaseDate = "",
    this.description = "",
    this.source = "",
  });

  final int id;
  final String title, picture, releaseDate, description, source;
}
