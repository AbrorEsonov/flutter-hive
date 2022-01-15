import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Users{
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String? email;

  @HiveField(2)
  final String? first_name;

  @HiveField(3)
  final String? last_name;

  @HiveField(4)
  final String? avatar;

  Users(
      {this.id, this.email, this.first_name, this.last_name, this.avatar});

  factory Users.fromJson(Map<String, dynamic> json) {
    return _$UsersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UsersToJson(this);

}