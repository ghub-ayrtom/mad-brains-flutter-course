import 'package:lesson_3_homework/components/locals/locale_base.dart';

// Словарь русской локализации
class LocaleRu implements LocaleBase {
  @override
  String get error => "Ошибка";
  @override
  String get unknown => "Неизвестно";
  @override
  String get description => "Описание сериала";

  @override
  String get searchTextFieldHint => "Найти сериал...";
  @override
  String get genreTextFieldHint => "Ваш любимый жанр сериалов...";
  @override
  String get dropDownButtonHint => "Язык приложения";

  @override
  String get newsPagesTitle => "Новости";
  @override
  String get favoritesPageTitle => "Избранное";
  @override
  String get settingsPageTitle => "Настройки";

  @override
  String get homePageBNBText => "Лента";
  @override
  String get clearGenreButtonText => "Очистить жанр";
  @override
  String get breakAllButtonText => "Сломать всё";
}
