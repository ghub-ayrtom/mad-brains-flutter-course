import 'package:lesson_3_homework/domain/models/show_card_model.dart';

// Класс единой общей модели списка моделей карточек сериалов для его отображения
// на главном экране приложения
class HomeModel {
  HomeModel(this.results);
  final List<ShowCardModel>? results;
}
