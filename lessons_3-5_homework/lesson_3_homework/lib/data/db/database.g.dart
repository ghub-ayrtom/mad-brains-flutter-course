// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $SeriesTableTable extends SeriesTable
    with TableInfo<$SeriesTableTable, SeriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pictureMeta =
      const VerificationMeta('picture');
  @override
  late final GeneratedColumn<String> picture = GeneratedColumn<String>(
      'picture', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  @override
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'release_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _languageMeta =
      const VerificationMeta('language');
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
      'language', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite =
      GeneratedColumn<bool>('is_favorite', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        picture,
        releaseDate,
        description,
        language,
        rating,
        isFavorite
      ];
  @override
  String get aliasedName => _alias ?? 'series_table';
  @override
  String get actualTableName => 'series_table';
  @override
  VerificationContext validateIntegrity(Insertable<SeriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('picture')) {
      context.handle(_pictureMeta,
          picture.isAcceptableOrUnknown(data['picture']!, _pictureMeta));
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language']!, _languageMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      picture: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}picture']),
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}release_date']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      language: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $SeriesTableTable createAlias(String alias) {
    return $SeriesTableTable(attachedDatabase, alias);
  }
}

class SeriesTableData extends DataClass implements Insertable<SeriesTableData> {
  final String id;
  final String title;
  final String? picture;
  final String? releaseDate;
  final String? description;
  final String? language;
  final double? rating;
  final bool isFavorite;
  const SeriesTableData(
      {required this.id,
      required this.title,
      this.picture,
      this.releaseDate,
      this.description,
      this.language,
      this.rating,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || picture != null) {
      map['picture'] = Variable<String>(picture);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['release_date'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  SeriesTableCompanion toCompanion(bool nullToAbsent) {
    return SeriesTableCompanion(
      id: Value(id),
      title: Value(title),
      picture: picture == null && nullToAbsent
          ? const Value.absent()
          : Value(picture),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      isFavorite: Value(isFavorite),
    );
  }

  factory SeriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeriesTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      picture: serializer.fromJson<String?>(json['picture']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      description: serializer.fromJson<String?>(json['description']),
      language: serializer.fromJson<String?>(json['language']),
      rating: serializer.fromJson<double?>(json['rating']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'picture': serializer.toJson<String?>(picture),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'description': serializer.toJson<String?>(description),
      'language': serializer.toJson<String?>(language),
      'rating': serializer.toJson<double?>(rating),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  SeriesTableData copyWith(
          {String? id,
          String? title,
          Value<String?> picture = const Value.absent(),
          Value<String?> releaseDate = const Value.absent(),
          Value<String?> description = const Value.absent(),
          Value<String?> language = const Value.absent(),
          Value<double?> rating = const Value.absent(),
          bool? isFavorite}) =>
      SeriesTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        picture: picture.present ? picture.value : this.picture,
        releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
        description: description.present ? description.value : this.description,
        language: language.present ? language.value : this.language,
        rating: rating.present ? rating.value : this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('SeriesTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('picture: $picture, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('description: $description, ')
          ..write('language: $language, ')
          ..write('rating: $rating, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, picture, releaseDate, description,
      language, rating, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeriesTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.picture == this.picture &&
          other.releaseDate == this.releaseDate &&
          other.description == this.description &&
          other.language == this.language &&
          other.rating == this.rating &&
          other.isFavorite == this.isFavorite);
}

class SeriesTableCompanion extends UpdateCompanion<SeriesTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> picture;
  final Value<String?> releaseDate;
  final Value<String?> description;
  final Value<String?> language;
  final Value<double?> rating;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const SeriesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.picture = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.description = const Value.absent(),
    this.language = const Value.absent(),
    this.rating = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeriesTableCompanion.insert({
    required String id,
    required String title,
    this.picture = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.description = const Value.absent(),
    this.language = const Value.absent(),
    this.rating = const Value.absent(),
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        isFavorite = Value(isFavorite);
  static Insertable<SeriesTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? picture,
    Expression<String>? releaseDate,
    Expression<String>? description,
    Expression<String>? language,
    Expression<double>? rating,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (picture != null) 'picture': picture,
      if (releaseDate != null) 'release_date': releaseDate,
      if (description != null) 'description': description,
      if (language != null) 'language': language,
      if (rating != null) 'rating': rating,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeriesTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? picture,
      Value<String?>? releaseDate,
      Value<String?>? description,
      Value<String?>? language,
      Value<double?>? rating,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return SeriesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      picture: picture ?? this.picture,
      releaseDate: releaseDate ?? this.releaseDate,
      description: description ?? this.description,
      language: language ?? this.language,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (picture.present) {
      map['picture'] = Variable<String>(picture.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('picture: $picture, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('description: $description, ')
          ..write('language: $language, ')
          ..write('rating: $rating, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $SeriesTableTable seriesTable = $SeriesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [seriesTable];
}
