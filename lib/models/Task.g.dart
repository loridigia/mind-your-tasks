// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['name'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    json['description'] as String,
  )
    ..UUID = json['UUID'] as String
    ..status = _$enumDecodeNullable(_$StatusEnumMap, json['status'])
    ..creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime'] as String);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'UUID': instance.UUID,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'status': _$StatusEnumMap[instance.status],
      'user': instance.user?.toJson(),
      'description': instance.description,
      'creationTime': instance.creationTime?.toIso8601String(),
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

const _$StatusEnumMap = {
  Status.COMPLEATED: 'COMPLEATED',
  Status.ACTIVE: 'ACTIVE',
  Status.PENDING: 'PENDING',
};
