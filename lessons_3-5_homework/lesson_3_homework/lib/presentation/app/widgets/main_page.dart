import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson_3_homework/components/constants.dart';
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

  // Список страниц в нижнем навигационном меню (BottomNavigationBar)
  static List<Tab> tabs = [
    const Tab(
      icon: Icon(Icons.local_movies_outlined),
      label: Local.homePageBNBText,
      // Страница со списком сериалов
      page: HomePage(),
    ),
    const Tab(
      icon: Icon(Icons.favorite),
      label: Local.favoritesPageTitle,
      // Страница со списком избранных (favorites) сериалов
      page: FavoritesPage(),
    ),
    const Tab(
      icon: Icon(Icons.newspaper),
      label: Local.newsPagesTitle,
      // Страница со списком новостей
      page: NewsPage(
        title: Local.newsPagesTitle,
      ),
    ),
  ];

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Функция изменения индекса выбранной страницы в нижнем навигационном меню
  void _onItemTapped(int index) {
    // Добавляем новое событие переключения вкладки в нижнем навигационном меню
    // (BottomNavigationBar) в основной BLoC-компонент главного экрана приложения,
    // задавая новое значение для определённого в состоянии поля
    // selectedTabIndex - индекса текущей выбранной страницы (index)
    context.read<HomeBloc>().add(TabSwitchEvent(selectedTabIndex: index));
  }

  // Вспомогательный метод для добавления градиента в виджет BottomNavigationBar
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
          MainPage.tabs.length,
          (index) {
            final Tab tab = MainPage.tabs[index];

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
            body: MainPage.tabs.elementAt(state.selectedTabIndex ?? 0).page,
            bottomNavigationBar:
                _createBottomNavigationBar(state.selectedTabIndex),
            backgroundColor: Colors.black,
          );
        });
  }
}
