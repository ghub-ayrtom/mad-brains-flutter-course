import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/locals/locals.dart';
import 'package:lesson_3_homework/presentation/home/pages/favorites_page.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_bloc.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_event.dart';
import 'package:lesson_3_homework/presentation/home/bloc/home_state.dart';
import 'package:lesson_3_homework/presentation/home/pages/home_page.dart';
import 'package:lesson_3_homework/presentation/home/pages/news_page.dart';

// Класс страницы в нижнем навигационном меню
class Tab {
  const Tab({required this.icon, required this.label, required this.page});

  final Icon icon;
  final String label;
  final Widget page;
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Список страниц в нижнем навигационном меню (BottomNavigationBar)
  List<Tab>? tabs;

  // Вспомогательный метод для заполнения данными списка страниц
  void _fillTabsList() {
    tabs = [
      Tab(
        icon: const Icon(Icons.local_movies_outlined),
        label: context.locale.homePageBNBText,
        // Страница со списком сериалов
        page: const HomePage(),
      ),
      Tab(
        icon: const Icon(Icons.favorite),
        label: context.locale.favoritesPageTitle,
        // Страница со списком избранных (favorites) сериалов
        page: const FavoritesPage(),
      ),
      Tab(
        icon: const Icon(Icons.newspaper),
        label: context.locale.newsPagesTitle,
        // Страница со списком новостей
        page: const NewsPage(),
      ),
    ];
  }

  // Функция изменения индекса выбранной страницы в нижнем навигационном меню
  void _onItemTapped(int index) {
    // Добавляем новое событие переключения вкладки в нижнем навигационном меню
    // (BottomNavigationBar) в основной BLoC-компонент главного экрана приложения,
    // задавая новое значение для определённого в состоянии поля
    // selectedTabIndex - индекса текущей выбранной страницы (index)
    context.read<HomeBloc>().add(TabSwitchEvent(selectedTabIndex: index));
  }

  // Вспомогательный метод для генерации списка страниц, а также для добавления
  // градиента в виджет BottomNavigationBar
  Widget _createBottomNavigationBar(int? index) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purple.shade300],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: BottomNavigationBar(
        // Генерация списка иконок (страниц) в нижнем навигационном меню
        items: List.generate(
          tabs!.length,
          (index) {
            final Tab tab = tabs![index];

            return BottomNavigationBarItem(
              icon: tab.icon,
              label: tab.label,
            );
          },
        ),
        currentIndex: index ?? 0,
        onTap: _onItemTapped,
        elevation: 0,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _fillTabsList();

    // BlocBuilder позволяет подписать его дочерний виджет на изменение
    // состояния и перерисовать его в случае необходимости
    // (задано условие перерисовки buildWhen) или каждый раз при добавлении
    // нового события в основной BLoC-компонент
    // (не задано условие перерисовки buildWhen)
    return BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (oldState, newState) =>
            // Перерисовать виджет ниже (Scaffold), когда произошло переключение
            // между страницами в нижнем навигационном меню (BottomNavigationBar),
            // и индекс текущей выбранной страницы изменился
            oldState.selectedTabIndex != newState.selectedTabIndex,
        builder: (context, state) {
          return Scaffold(
            // state.selectedTabIndex - индекс текущей выбранной страницы в
            // новом состоянии state
            body: tabs!.elementAt(state.selectedTabIndex ?? 0).page,
            bottomNavigationBar:
                _createBottomNavigationBar(state.selectedTabIndex),
            backgroundColor: Colors.black,
          );
        });
  }
}
