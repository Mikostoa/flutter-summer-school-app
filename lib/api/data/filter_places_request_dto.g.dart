// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_places_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterPlacesRequestDto _$FilterPlacesRequestDtoFromJson(
  Map<String, dynamic> json,
) => FilterPlacesRequestDto(
  lat: (json['lat'] as num?)?.toDouble(),
  lng: (json['lng'] as num?)?.toDouble(),
  radius: (json['radius'] as num?)?.toDouble(),
  typeFilter:
      (json['typeFilter'] as List<dynamic>?)
          ?.map((e) => PlaceTypeDto.fromJson(e as String))
          .toList(),
  nameFilter: json['nameFilter'] as String?,
);

Map<String, dynamic> _$FilterPlacesRequestDtoToJson(
  FilterPlacesRequestDto instance,
) => <String, dynamic>{
  'lat': instance.lat,
  'lng': instance.lng,
  'nameFilter': instance.nameFilter,
  'radius': instance.radius,
  'typeFilter': instance.typeFilter,
};
