import 'package:lesson_3_homework/components/locals/locale_base.dart';

// Словарь китайской локализации
class LocaleCn implements LocaleBase {
  @override
  String get error => "错误";
  @override
  String get unknown => "未知";
  @override
  String get description => "系列说明";

  @override
  String get searchTextFieldHint => "搜索系列...";
  @override
  String get genreTextFieldHint => "您最喜欢的节目类型...";
  @override
  String get dropDownButtonHint => "应用语言";

  @override
  String get newsPagesTitle => "新闻";
  @override
  String get favoritesPageTitle => "收藏夹";
  @override
  String get settingsPageTitle => "设置";

  @override
  String get homePageBNBText => "喂食";
  @override
  String get clearGenreButtonText => "明确流派";
  @override
  String get breakAllButtonText => "全部中断";
}
