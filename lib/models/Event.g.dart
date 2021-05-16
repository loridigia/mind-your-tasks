// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    json['name'] as String,
    json['date'] == null ? null : DateTime.parse(json['date'] as String),
    (json['users'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..UUID = json['UUID'] as String
    ..tasks = (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime'] as String);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'UUID': instance.UUID,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'tasks': instance.tasks?.map((e) => e?.toJson())?.toList(),
      'users': instance.users?.map((e) => e?.toJson())?.toList(),
      'creationTime': instance.creationTime?.toIso8601String(),
    };
