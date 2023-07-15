import 'package:json_annotation/json_annotation.dart';

part 'show_card_dto.g.dart';

// i-ый элемент списка results - корневого элемента Json
@JsonSerializable()
class ShowCardDataDTO {
  ShowCardDataDTO(
      this.id, this.originalTitleText, this.primaryImage, this.releaseYear);

  @JsonKey(name: "id", defaultValue: "")
  final String id;

  @JsonKey(name: "originalTitleText")
  final ShowCardDataTitleDTO? originalTitleText;

  @JsonKey(name: "primaryImage")
  final ShowCardDataImageDTO? primaryImage;

  @JsonKey(name: "releaseYear")
  final ShowCardDataDateDTO? releaseYear;

  // Именованный factory-конструктор для автоматической генерации .g.dart файла
  // Json-генератора
  factory ShowCardDataDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataDTOFromJson(json);
}

// Map originalTitleText i-го элемента списка results
@JsonSerializable()
class ShowCardDataTitleDTO {
  ShowCardDataTitleDTO(this.title);

  @JsonKey(name: "text")
  final String? title;

  factory ShowCardDataTitleDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataTitleDTOFromJson(json);
}

// Map primaryImage i-го элемента списка results
@JsonSerializable()
class ShowCardDataImageDTO {
  ShowCardDataImageDTO(this.picture);

  @JsonKey(name: "url")
  final String? picture;

  factory ShowCardDataImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataImageDTOFromJson(json);
}

// Map releaseYear i-го элемента списка results
@JsonSerializable()
class ShowCardDataDateDTO {
  ShowCardDataDateDTO(this.releaseDate);

  @JsonKey(name: "year")
  final int? releaseDate;

  factory ShowCardDataDateDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataDateDTOFromJson(json);
}
