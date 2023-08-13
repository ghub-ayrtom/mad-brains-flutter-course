// Единый интерфейс со всеми строками в приложении, которые необходимо локализовать
abstract class LocaleBase {
  String get error;
  String get unknown;
  String get description;

  String get searchTextFieldHint;
  String get genreTextFieldHint;
  String get dropDownButtonHint;

  String get newsPagesTitle;
  String get favoritesPageTitle;
  String get settingsPageTitle;

  String get homePageBNBText;
  String get clearGenreButtonText;
  String get breakAllButtonText;
}
