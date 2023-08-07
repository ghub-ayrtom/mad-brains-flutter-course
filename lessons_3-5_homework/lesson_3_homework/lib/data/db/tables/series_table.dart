// Drift - это кроссплатформенная реактивная библиотека хранилище для Flutter и
// Dart, построенная поверх SQLite. Поддерживает кодогенерацию и миграции
import 'package:drift/drift.dart';

// Основная таблица в базе данных Drift
class SeriesTable extends Table {
  @override
  Set<Column<Object>> get primaryKey => <TextColumn>{id};

  TextColumn get id => text()();
  TextColumn get title => text()();
  // .nullable() - заданное для данного столбца таблицы свойство
  // (их может быть много или совсем не быть)
  TextColumn get picture => text().nullable()();
  TextColumn get releaseDate => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get language => text().nullable()();
  RealColumn get rating => real().nullable()();
  BoolColumn get isFavorite => boolean()();
}
