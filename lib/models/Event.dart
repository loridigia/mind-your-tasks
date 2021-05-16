import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'Task.dart';
import 'User.dart';

part 'Event.g.dart';

@JsonSerializable(explicitToJson: true)
class Event {
  String UUID;
  String name;
  DateTime date;
  List<Task> tasks;
  List<User> users;
  DateTime creationTime;

  Event(this.name, this.date, this.users) {
    this.UUID = Uuid().v4();
    this.creationTime = DateTime.now();
  }

  addTask(Task task) {
    this.tasks.add(task);
  }

  factory Event.fromJson(Map<String, dynamic> data) => _$EventFromJson(data);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}