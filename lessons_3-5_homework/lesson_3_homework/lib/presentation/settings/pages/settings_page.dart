import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_bloc.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_event.dart';
import 'package:lesson_3_homework/presentation/settings/bloc/settings_state.dart';

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

  @override
  void dispose() {
    // Уничтожаем контроллер перед уничтожением виджета для экономии памяти
    genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Кнопка "Назад" (логика задана по умолчанию)
        leading: const BackButton(
          color: Colors.black54,
        ),
        title: const Text(Local.settingsPageTitle),
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
      body: Center(
        child: Column(
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
                    bottom: 10.0,
                  ),
                  // Поле ввода жанра
                  child: TextField(
                    controller: genreController,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: Local.genreTextFieldHint,
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
                borderRadius: BorderRadius.circular(5),
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
                child: const Text(Local.clearGenreButtonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
