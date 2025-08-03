// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDto _$PlaceDtoFromJson(Map<String, dynamic> json) => PlaceDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  placeType: PlaceTypeDto.fromJson(json['type'] as String),
  images: (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
  lat: (json['lat'] as num).toDouble(),
  lon: (json['lng'] as num).toDouble(),
);
