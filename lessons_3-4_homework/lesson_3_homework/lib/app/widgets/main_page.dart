import 'package:flutter/material.dart';
import 'package:lesson_3_homework/features/home/pages/home_page.dart';
import 'package:lesson_3_homework/features/home/pages/news_page.dart';

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
      label: "Feed",
      page: HomePage(title: "Movies"), // Страница со списком фильмов
    ),
    const Tab(
      icon: Icon(Icons.newspaper),
      label: "News",
      page: NewsPage(title: "News"), // Страница со списком новостей
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage.tabs.elementAt(selectedTabIndex).page,
      bottomNavigationBar: BottomNavigationBar(
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
        backgroundColor: Colors.purple[200],
      ),
      backgroundColor: Colors.black,
    );
  }
}
