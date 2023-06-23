/*
  Добавляет возможность программе оценивать код, который не был буквально указан во время компиляции,
  например, вызов метода, имя которого предоставляется в качестве аргумента
*/
import 'dart:mirrors';

abstract class Movie with LanguageStrToEnumConverter
{
  String? id, title, picture, releaseDate, description, language;
  double? rating;

  Movie.build(this.title, this.rating); // Конструктор для дочернего класса
}

class HorrorMovie extends Movie
{
  HorrorMovie(title, rating) : super.build(title, rating);
}

// Примесь (mixin) для преобразования строки языка в перечисление (enum)
mixin LanguageStrToEnumConverter
{
  dynamic convert(String? language, type) // type - тип класса у объекта
  {
    /*
      * ClassMirror отражает языковой класс (?) Dart
      *
      * Далее получаем значения values у перечисления (enum) Languages
      *
      * Функция reflectee возвращает зеркало ClosureMirror экземпляра Languages класса enum,
      * которое, в свою очередь, вызывает замыкание (closure) для запоминания своего
      * лексического окружения (?)
      *
      * При помощи лямбда-функции получаем название перечисления - Languages и
      * по символу-точке (Languages.russian) отделяем от него текущее значение.
      * Преобразуем значение из enum в строчный шрифт и сравниваем с параметром
      * language, который был передан (russian == russian)
    */
    return (reflectType(type) as ClassMirror).getField(#values).reflectee.firstWhere((l) =>
    l.toString().split('.')[1].toLowerCase() == language.toString().toLowerCase());
  }
}

enum Languages
{
  chinese,
  english,
  french,
  german,
  russian
}

// Расширение для перечисления (enum) Languages, которое возвращает строку с приветствием на языке фильма
extension LanguagesExtension on Languages
{
  String get language // Метод-геттер
  {
    switch (this)
    {
      case Languages.chinese:
        return "你好，世界!";
      case Languages.english:
        return "Hello, World!";
      case Languages.french:
        return "Bonjour à tous !";
      case Languages.german:
        return "Hallo, Welt!";
      case Languages.russian:
        return "Привет, Мир!";
      default:
        return "Language not found";
    }
  }
}

List<HorrorMovie> horrors = [];

// Асинхронный метод, который возвращает список фильмов
Future listOfMovies() async
{
  Iterator i = horrors.iterator; // Получаем итератор списка для его перебора

  while (i.moveNext())
  {
    print("${i.current.title} [${i.current.rating}]");
  }

  print("");

  return horrors;
}

// Функция для фильтрации фильмов по рейтингу
void horrorsRatingSort()
{
  horrors.sort((a, b) => a.rating!.compareTo(b.rating!));
}

void main() async // Асинхронные методы можно вызывать только из асинхронных функций
{
  HorrorMovie m1 = HorrorMovie("It", 4.4);
  HorrorMovie m2 = HorrorMovie("Psycho", 4.6);
  HorrorMovie m3 = HorrorMovie("Saw", 4.5);

  horrors.add(m1);
  horrors.add(m2);
  horrors.add(m3);

  m1.language = "Russian";

  await listOfMovies(); // Вызов асинхронного метода

  // С помощью функции convert преобразуем строку языка в перечисление (enum) и сохраняем его в переменную lang
  Languages lang = m1.convert(m1.language, Languages);

  print(lang);
  print(lang.language);
  print("");

  horrorsRatingSort();
  await listOfMovies();
}