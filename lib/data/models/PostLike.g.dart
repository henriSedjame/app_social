// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostLike.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLike _$PostLikeFromJson(Map<String, dynamic> json) {
  return PostLike(
    _$enumDecodeNullable(_$LikeTypeEnumMap, json['type']),
    json['likerName'] as String,
    json['likerId'] as String,
  );
}

Map<String, dynamic> _$PostLikeToJson(PostLike instance) => <String, dynamic>{
      'type': _$LikeTypeEnumMap[instance.type],
      'likerName': instance.likerName,
      'likerId': instance.likerId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$LikeTypeEnumMap = {
  LikeType.LIKE: 'LIKE',
  LikeType.LOVE: 'LOVE',
  LikeType.UNLIKE: 'UNLIKE',
};
