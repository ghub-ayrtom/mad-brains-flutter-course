import 'package:flutter/material.dart';
import 'package:lesson_3_homework/components/constants.dart';
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

  // Список страниц в нижнем навигационном меню
  static List<Tab> tabs = [
    const Tab(
      icon: Icon(Icons.local_movies_outlined),
      label: Local.homePageBNBText,
      // Страница со списком сериалов
      page: HomePage(),
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

  // Именованный путь для метода Navigator.pushNamed
  static const path = "/main";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Индекс выбранной страницы в нижнем навигационном меню
  int selectedTabIndex = 0;

  // Функция изменения индекса выбранной страницы в нижнем навигационном меню
  void _onItemTapped(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  // Вспомогательный метод для добавления градиента в виджет BottomNavigationBar
  Widget _createBottomNavigationBar() {
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
        currentIndex: selectedTabIndex,
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
    return Scaffold(
      body: MainPage.tabs.elementAt(selectedTabIndex).page,
      bottomNavigationBar: _createBottomNavigationBar(),
      backgroundColor: Colors.black,
    );
  }
}
