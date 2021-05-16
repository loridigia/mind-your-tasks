import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'User.dart';
part 'Task.g.dart';

enum Status {
  COMPLEATED,
  ACTIVE,
  PENDING
}

@JsonSerializable(explicitToJson: true)
class Task {
  String UUID;
  String name;
  DateTime date;
  Status status = Status.PENDING;
  User user;
  String description;
  DateTime creationTime;

  Task(this.name, this.date, this.user, this.description) {
    this.UUID = Uuid().v4();
    this.description = description;
    this.creationTime = DateTime.now();
  }

  factory Task.fromJson(Map<String, dynamic> data) => _$TaskFromJson(data);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  /*
  Task.fromJson(Map<String, dynamic> json)
    : UUID = json['UUID'],
      name = json['name'],
      date = json['date'],
      user = json['user'],
      status = json['status'],
      description = json['description'],
      creationTime = json['creationTime'];

  Map<String, dynamic> toJson() => {
    'UUID' : UUID,
    'name' : name,
    'date' : date.millisecondsSinceEpoch,
    'user' : user,
    'status' : status.toString(),
    'description' : description,
    'creationTime' : creationTime.millisecondsSinceEpoch
  };

   */
}