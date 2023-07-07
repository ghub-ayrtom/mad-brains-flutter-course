import 'package:flutter/material.dart';
import 'package:lesson_3_homework/app/models/news_card_model.dart';
import 'package:lesson_3_homework/app/widgets/news_card_widget.dart';
import 'package:lesson_3_homework/features/home/pages/news_details.dart';

// Виджет списка новостей из киноиндустрии
class NewsList extends StatefulWidget {
  const NewsList({super.key});

  static final List<NewsCardModel> news = <NewsCardModel>[
    NewsCardModel(
      id: 0,
      title: "Evan Peters to Star in 'Tron 3' With Jared Leto",
      picture:
          "https://upload.wikimedia.org/wikipedia/commons/0/05/Evan_Peters_by_Gage_Skidmore_3.jpg",
      releaseDate: "Jun 28, 2023 11:00 AM",
      description:
          "Evan Peters, star of “Dahmer – Monster: The Jeffrey Dahmer Story” "
          "and “Mare of Easttown,” is joining Jared Leto in “Tron: Ares,” "
          "the third film in Disney’s extremely long-lived cyberspace franchise.",
      source: "By Adam B. Vary",
    ),
    NewsCardModel(
      id: 1,
      title: "Oscars Invite 398 New Members: Taylor Swift, Austin Butler, "
          "Ke Huy Quan, ‘RRR’ Stars Ram Charan and NTR Jr and More",
      picture:
          "https://static.toiimg.com/thumb/imgsize-23456,msid-90620076,width-600,resizemode-4/90620076.jpg",
      releaseDate: "Jun 28, 2023 11:30 AM",
      description:
          "The 2023 class is 40% women. 34% belong to underrepresented ethnic/racial "
          "communities and 52% hail from 51 countries and territories outside the United States. "
          "There are many recent Oscar nominees among the invitees, such as Austin Butler (“Elvis”), "
          "Paul Mescal (“Aftersun”), Stephanie Hsu (“Everything Everywhere All at Once”) and "
          "Kerry Condon (“The Banshees of Inisherin”). The list also includes "
          "many of the 95th ceremony’s winners, such as Ke Huy Quan "
          "(supporting actor for “Everything Everywhere All at Once”) "
          "cinematographer James Friend (“All Quiet on the Western Front”) "
          "and composer and songwriter M.M. Keeravani and Chandrabose (“Naatu Naatu” from “RRR”). "
          "Even the dynamic “RRR” lead acting duo of Ram Charan and "
          "N. T. Rama Rao Jr. have also been extended invitations, along "
          "with the film’s production designer Sabu Cyril and cinematographer K.K. Senthil Kumar.",
      source: "By Clayton Davis",
    ),
    NewsCardModel(
      id: 2,
      title: "These Are the Most Emmy-Winning Shows of All Time",
      picture:
          "https://i0.wp.com/static1.colliderimages.com/wordpress/wp-content/uploads/2023/06/the-emmys-frasier.jpg",
      releaseDate: "Jun 30, 2023 06:25 AM",
      description:
          "With television's biggest night only a few months away, the nominees "
          "for the 75th Annual Primetime Emmy Awards will need a miracle if "
          "they hope to get even close to catching up to some of the ceremony's "
          "most awarded shows. Still, the prospective nominees for the upcoming "
          "ceremony are nothing to scoff at, with so many shows in the running "
          "to be recognized. House of the Dragon, The Last of Us, Barry, "
          "Succession, Better Call Saul, Abbott Elementary, and The Bear are "
          "just some of the acclaimed shows expected to be nominated, making "
          "a serious case that this past year may have been one of the best "
          "runs for television programming ever.",
      source: "By Aidan Kelley",
    ),
  ];

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: NewsList.news.length,
      itemBuilder: (BuildContext context, int listElementIndex) {
        // Виджет GestureDetector - детектор жестов. В данном случае, жест нажатия на определённую карточку новости
        return GestureDetector(
          onTap: () {
            // При нажатии на определённую новость из списка, используя декларативный подход,
            // вызываем метод pushNamed у Navigator, в который передаём путь path
            // страницы на которую осуществляется переход и элемент списка новостей по его
            // индексу, который выступает в качестве аргумента классу NewsDetailsArguments.
            // Таким образом, на вершину стека Navigator помещается новая страница
            // (в данном случае - NewsDetails), которая открывается поверх текущей
            Navigator.pushNamed(
              context,
              "/details",
              arguments: NewsDetailsArguments(NewsList.news[listElementIndex]),
            );
          },
          child: NewsCardWidget.fromModel(
            // Последовательный перебор элементов списка новостей по индексу и их отображение
            model: NewsList.news[listElementIndex],
          ),
        );
      },
    );
  }
}
