import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:lesson_3_homework/data/db/tables/series_table.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// Данный файл - часть другого сгенерированного файла, который содержит модель
// объекта таблицы (файл series_table.dart) в базе данных для работы с ней
part "database.g.dart";

// Класс для создания базы данных Drift.
// Параметр tables - таблицы в ней (файл series_table.dart)
@DriftDatabase(tables: [SeriesTable])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1; // Номер версии базы данных

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      // Получаем основной каталог приложения
      final dbFolder = await getApplicationDocumentsDirectory();
      // Создаём в нём или получаем (если ранее уже был создан) файл db.sqlite
      // базы данных
      final dbFile = File(p.join(dbFolder.path, "db.sqlite"));

      // Возвращаем объект базы данных Drift
      return NativeDatabase(dbFile);
    });
  }
}

// flutter pub run build_runner build --delete-conflicting-outputs
