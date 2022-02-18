import 'package:hive/hive.dart';
import 'package:hive_example/entity/users.dart';
import 'package:json_annotation/json_annotation.dart';

part 'custom_response.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class CustomResponse {
  @HiveField(0)
  final int? page;

  @HiveField(1)
  final int? per_page;

  @HiveField(2)
  final int? total;

  @HiveField(3)
  final int? total_pages;

  @HiveField(4)
  final List<Users>? data;

  CustomResponse(
      {this.page, this.per_page, this.total, this.total_pages, this.data});

  CustomResponse copyWith(
      {int? page, int? per_page, int? total, List<Users>? data}) {
    return CustomResponse(
      page: page ?? this.page,
      per_page: per_page ?? this.per_page,
      total: total ?? this.total,
      data: data ?? this.data,
    );
  }

  factory CustomResponse.fromJson(Map<String, dynamic> json) {
    return _$CustomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CustomResponseToJson(this);
}
