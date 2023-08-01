import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/constants.dart';
import 'package:lesson_3_homework/components/delayed_action.dart';
import 'package:lesson_3_homework/domain/models/home_model.dart';
import 'package:lesson_3_homework/domain/models/show_card_model.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_bloc.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_event.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_state.dart';
import 'package:lesson_3_homework/presentation/home/widgets/series_grid.dart';

// Виджет главного экрана приложения с состояниями (StatefulWidget)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // Глобальный статический ключ для получения контекста главного экрана
  // приложения из его других окон
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  // Создаём начальное состояние
  @override
  State<HomePage> createState() => HomePageState();
}

// Класс начального состояния виджета HomePage
class HomePageState extends State<HomePage> {
  // Контроллер для работы с полем поиска конкретного сериала
  final TextEditingController searchController = TextEditingController();
  // Список сериалов для их убывающей сортировки по IMDb-рейтингу
  late List<ShowCardModel> series;

  // Данный метод вызывается каждый раз при изменениях в поле поиска
  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      // initialQ - параметр URL-адреса с названием сериала по умолчанию
      // (для HTTP-запроса ко второму API).
      // text - строка пользовательского ввода

      // Добавляем новое событие изменения поля поиска сериала в основной
      // BLoC-компонент главного экрана приложения, задавая новое значение для
      // определённого в состоянии поля searchQuery
      context.read<HomeBloc>().add(SearchChangedEvent(
          searchQuery: text.isNotEmpty ? text : Query.initialQ));
    });
  }

  // Выполняем HTTP-запросы и загружаем сериалы сразу при запуске данного виджета,
  // но после выполнения метода initState (когда уже доступен контекст приложения)
  @override
  void didChangeDependencies() {
    // Добавляем новое событие загрузки списка сериалов в основной BLoC-компонент
    // главного экрана приложения
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Уничтожаем контроллер перед уничтожением виджета для экономии памяти
    searchController.dispose();
    super.dispose();
  }

  // Метод для реализации функционала pull-to-refresh
  Future refreshData() async {
    context.read<HomeBloc>().add(LoadDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold - виджет для компоновки пользовательского интерфейса
    return Scaffold(
      key: HomePage.globalKey,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // Поле поиска
        title: TextField(
          controller: searchController,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: Local.search,
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: _onSearchFieldTextChanged,
        ),
        actions: [
          IconButton(
            onPressed: () {
              // По нажатию на данную кнопку, сортируем список сериалов по убыванию
              // их рейтинга и обновляем состояние виджета
              setState(() {
                series.sort((a, b) => b.rating!.compareTo(a.rating!));
              });
            },
            icon: const Icon(
              Icons.sort,
              color: Colors.black54,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      // pull-to-refresh
      body: RefreshIndicator(
        color: Colors.purple,
        onRefresh: refreshData,
        // BlocBuilder позволяет подписать его дочерний виджет на изменение
        // состояния и перерисовать его в случае необходимости
        // (задано условие перерисовки buildWhen) или каждый раз при добавлении
        // нового события в основной BLoC-компонент
        // (не задано условие перерисовки buildWhen)
        child: BlocBuilder<HomeBloc, HomeState>(
            // data - список сериалов конкретного состояния
            buildWhen: (oldState, newState) => oldState.data != newState.data,
            builder: (context, state) {
              // Список сериалов. FutureBuilder - виджет, который строится на основе
              // последнего снимка (snapshot) взаимодействия с Future
              return FutureBuilder<HomeModel?>(
                future: state.data,
                builder:
                    (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                  switch (data.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.active:
                    case ConnectionState.waiting: // Загрузка в процессе
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      );
                    case ConnectionState.done: // Загрузка завершена
                      // Если есть данные
                      if (data.hasData) {
                        // Если данные не пустые
                        if (data.data?.results?.isNotEmpty == true) {
                          // Сохраняем их в список сериалов и передаём для отображения
                          // на UI в виджете GridView
                          series = data.data!.results!;
                          return SeriesGrid(data);
                        }
                      }
                  }

                  return Container(height: 0);
                },
              );
            }),
      ),
      backgroundColor: Colors.black,
    );
  }
}
