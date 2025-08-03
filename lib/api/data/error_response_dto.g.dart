// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponseDto _$ErrorResponseDtoFromJson(Map<String, dynamic> json) =>
    ErrorResponseDto(
      code: (json['code'] as num).toInt(),
      detail: json['detail'] as String?,
    );

Map<String, dynamic> _$ErrorResponseDtoToJson(ErrorResponseDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      if (instance.detail case final value?) 'detail': value,
    };
