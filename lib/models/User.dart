
import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
//@JsonSerializable(explicitToJson: true)
class User {
  final String username;
  final String email;

  User(this.username, this.email);

  factory User.fromJson(Map<String, dynamic> data) => _$UserFromJson(data);

  Map<String, dynamic> toJson() => _$UserToJson(this);

}