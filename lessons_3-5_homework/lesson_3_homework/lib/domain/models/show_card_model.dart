import 'package:lesson_3_homework/data/db/database.dart';

// Расширение для преобразования чистой модели ShowCardModel (отображение на UI)
// в модель базы данных SeriesTableData (файл database.g.dart)
extension ShowCardModelToDatabase on ShowCardModel {
  SeriesTableData toDatabase() {
    return SeriesTableData(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      description: description,
      language: language,
      rating: rating,
      isFavorite: isFavorite,
    );
  }
}

// Расширение для преобразования модели базы данных SeriesTableData в чистую
// модель ShowCardModel
extension SeriesTableDataToDomain on SeriesTableData {
  ShowCardModel toDomain() {
    return ShowCardModel(
      id: id,
      title: title,
      picture: picture,
      releaseDate: releaseDate,
      description: description,
      language: language,
      rating: rating,
      isFavorite: isFavorite,
    );
  }
}

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
