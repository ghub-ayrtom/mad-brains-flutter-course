import 'package:lesson_3_homework/components/locals/locale_base.dart';

// Словарь английской локализации
class LocaleEn implements LocaleBase {
  @override
  String get error => "Error";
  @override
  String get unknown => "Unknown";
  @override
  String get description => "Series Description";

  @override
  String get searchTextFieldHint => "Search series...";
  @override
  String get genreTextFieldHint => "Your favorite show genre...";
  @override
  String get dropDownButtonHint => "Application Language";

  @override
  String get newsPagesTitle => "News";
  @override
  String get favoritesPageTitle => "Favorites";
  @override
  String get settingsPageTitle => "Settings";

  @override
  String get homePageBNBText => "Feed";
  @override
  String get clearGenreButtonText => "Clear Genre";
  @override
  String get breakAllButtonText => "Break All";
}
