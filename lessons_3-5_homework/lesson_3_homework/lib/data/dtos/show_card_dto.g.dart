// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowCardDataDTO _$ShowCardDataDTOFromJson(Map<String, dynamic> json) =>
    ShowCardDataDTO(
      json['id'] as String? ?? '',
      json['originalTitleText'] == null
          ? null
          : ShowCardDataTitleDTO.fromJson(
              json['originalTitleText'] as Map<String, dynamic>),
      json['primaryImage'] == null
          ? null
          : ShowCardDataImageDTO.fromJson(
              json['primaryImage'] as Map<String, dynamic>),
      json['releaseYear'] == null
          ? null
          : ShowCardDataDateDTO.fromJson(
              json['releaseYear'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowCardDataDTOToJson(ShowCardDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalTitleText': instance.originalTitleText,
      'primaryImage': instance.primaryImage,
      'releaseYear': instance.releaseYear,
    };

ShowCardDataTitleDTO _$ShowCardDataTitleDTOFromJson(
        Map<String, dynamic> json) =>
    ShowCardDataTitleDTO(
      json['text'] as String?,
    );

Map<String, dynamic> _$ShowCardDataTitleDTOToJson(
        ShowCardDataTitleDTO instance) =>
    <String, dynamic>{
      'text': instance.title,
    };

ShowCardDataImageDTO _$ShowCardDataImageDTOFromJson(
        Map<String, dynamic> json) =>
    ShowCardDataImageDTO(
      json['url'] as String?,
    );

Map<String, dynamic> _$ShowCardDataImageDTOToJson(
        ShowCardDataImageDTO instance) =>
    <String, dynamic>{
      'url': instance.picture,
    };

ShowCardDataDateDTO _$ShowCardDataDateDTOFromJson(Map<String, dynamic> json) =>
    ShowCardDataDateDTO(
      json['year'] as int?,
    );

Map<String, dynamic> _$ShowCardDataDateDTOToJson(
        ShowCardDataDateDTO instance) =>
    <String, dynamic>{
      'year': instance.releaseDate,
    };
