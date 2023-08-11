import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';
import 'package:lesson_3_homework/locale_bloc/locale_bloc.dart';
import 'package:lesson_3_homework/locale_bloc/locale_event.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_bloc.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_event.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_state.dart';
import 'package:country_codes/country_codes.dart';
import 'package:country_flags/country_flags.dart';

// Страница настроек
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Именованный путь для метода Navigator.pushNamed
  static const path = "/settings";

  @override
  Widget build(BuildContext context) {
    // BlocProvider - модифицированный Provider для использования BLoC.
    // Позволяет получить доступ к экземпляру BLoC во всех дочерних виджетах
    // через обращение к BuildContext
    return BlocProvider<SettingsBloc>(
      // Будет создаваться заранее до первого обращения к SettingsBloc
      lazy: false,
      // Создаём основной BLoC-компонент для данного экрана и сразу добавляем в
      // него событие загрузки любимого жанра сериалов пользователя из
      // системного хранилища Shared Preferences
      create: (_) => SettingsBloc()..add(LoadGenreEvent()),
      // Дочерний виджет, из которого можно получить доступ к данному BLoC-компоненту
      child: const SettingsPageContent(),
    );
  }
}

// Содержимое страницы настроек
class SettingsPageContent extends StatefulWidget {
  const SettingsPageContent({super.key});

  @override
  State<SettingsPageContent> createState() => _SettingsPageContentState();
}

class _SettingsPageContentState extends State<SettingsPageContent> {
  // Контроллер для работы с полем ввода жанра
  final TextEditingController genreController = TextEditingController();

  // Список доступных языков приложения.
  // "Alpha-2 country code": "language local name"
  final Map<String, String> appLanguages = {
    "ru": "Русский",
    "us": "English",
    "cn": "中文",
  };

  @override
  void dispose() {
    // Уничтожаем контроллер перед уничтожением виджета для экономии памяти
    genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Используя библиотеку Country Codes, получаем дополнительную информацию о
    // текущей локали приложения (двузначный код страны, код номера телефона,
    // название страны и так далее)
    final CountryDetails currentLanguageCountryDetails =
        CountryCodes.detailsForLocale(Localizations.localeOf(context));

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Кнопка "Назад" (логика задана по умолчанию)
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: Text(context.locale.settingsPageTitle),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // BlocBuilder позволяет подписать его дочерний виджет на изменение
          // состояния и перерисовать его в случае необходимости
          // (задано условие перерисовки buildWhen) или каждый раз при добавлении
          // нового события в основной BLoC-компонент
          // (не задано условие перерисовки buildWhen)
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              // Получаем из текущего состояния state основного BLoC-компонента
              // строку с любимым жанром сериалов пользователя и присваиваем её
              // контроллеру
              genreController.text = state.genre ?? "";

              return Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  bottom: 5.0,
                ),
                // Поле ввода жанра
                child: TextField(
                  controller: genreController,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: context.locale.genreTextFieldHint,
                    hintStyle: const TextStyle(color: Colors.white54),
                    // Кнопка сохранения жанра в Shared Preferences
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Добавляем соответствующее событие в SettingsBloc
                        // (подробнее в директории ../bloc)
                        context
                            .read<SettingsBloc>()
                            .add(SaveGenreEvent(genre: genreController.text));

                        // Скрываем экранную клавиатуру
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      icon: const Icon(
                        Icons.save_as,
                        color: Colors.white,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              );
            },
          ),
          Container(
            width: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purple.shade300],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
            ),
            // Кнопка удаления жанра из Shared Preferences
            child: ElevatedButton(
              onPressed: () {
                context.read<SettingsBloc>().add(ClearGenreEvent());
                genreController.clear();
              },
              style: ButtonStyle(
                // Делаем фон кнопки по умолчанию прозрачным для отображения
                // градиента
                backgroundColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
                // Делаем тени от кнопки по умолчанию прозрачными
                shadowColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
                // Отключаем эффект чернильницы при нажатии
                splashFactory: NoSplash.splashFactory,
              ),
              child: Text(
                context.locale.clearGenreButtonText,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35.0,
          ),
          // Специальный виджет для отключения отображения нижней черты у
          // виджета DropdownButton
          DropdownButtonHideUnderline(
            child: Theme(
              data: Theme.of(context).copyWith(
                // Отключаем все возможные эффекты при нажатии
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
              // Выпадающий список выбора языка приложения
              child: DropdownButton<String>(
                items: appLanguages
                    .map((countryCode, languageName) {
                      return MapEntry(
                        countryCode,
                        // Элемент списка (конкретный язык)
                        DropdownMenuItem<String>(
                          value: languageName,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5.0,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      width: 24,
                                      height: 19,
                                      // Библиотека Country Flags позволяет
                                      // получить SVG-изображение иконки флага
                                      // определённой страны по её двузначному
                                      // коду
                                      child: CountryFlag.fromCountryCode(
                                        countryCode,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 12.0,
                                      ),
                                      // Локальное название языка
                                      child: Text(
                                        languageName,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.check,
                                    // Отображаем данную иконку, если двузначный
                                    // код страны выбранного пользователем языка
                                    // совпадает с кодом страны языка текущего
                                    // элемента списка
                                    size: currentLanguageCountryDetails
                                                .alpha2Code
                                                .toString()
                                                .toLowerCase() ==
                                            countryCode
                                        ? 25.0 // true
                                        : 0.0, // false
                                    color: Colors.deepPurple,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })
                    .values
                    .toList(),
                hint: Text(
                  context.locale.dropDownButtonHint,
                  style: TextStyle(
                    color: Colors.purple[300],
                  ),
                ),
                onChanged: (language) {
                  // language - выбранный пользователем язык
                  switch (language) {
                    case "Русский":
                      // Отдельно отправляем в основной BLoC-компонент
                      // локализации приложения событие о смене каждого языка на
                      // выбранный (нет привязки между language и ..Locale)
                      context
                          .read<LocaleBloc>()
                          .add(ChangeLocaleEvent(availableLocales[ruLocale]!));
                      break;
                    case "English":
                      context
                          .read<LocaleBloc>()
                          .add(ChangeLocaleEvent(availableLocales[enLocale]!));
                      break;
                    case "中文":
                      context
                          .read<LocaleBloc>()
                          .add(ChangeLocaleEvent(availableLocales[cnLocale]!));
                      break;
                  }
                },
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white54,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // При нажатии на данную кнопку инициируем тестовый краш всего
              // приложения для проверки работоспособности сервиса
              // Firebase Crashlytics
              FirebaseCrashlytics.instance.crash();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.red,
              ),
              splashFactory: NoSplash.splashFactory,
            ),
            child: Text(
              context.locale.breakAllButtonText,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
