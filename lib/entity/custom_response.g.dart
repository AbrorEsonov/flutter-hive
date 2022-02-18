// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomResponseAdapter extends TypeAdapter<CustomResponse> {
  @override
  final int typeId = 0;

  @override
  CustomResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomResponse(
      page: fields[0] as int?,
      per_page: fields[1] as int?,
      total: fields[2] as int?,
      total_pages: fields[3] as int?,
      data: (fields[4] as List?)?.cast<Users>(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.page)
      ..writeByte(1)
      ..write(obj.per_page)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.total_pages)
      ..writeByte(4)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomResponse _$CustomResponseFromJson(Map<String, dynamic> json) =>
    CustomResponse(
      page: json['page'] as int?,
      per_page: json['per_page'] as int?,
      total: json['total'] as int?,
      total_pages: json['total_pages'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Users.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomResponseToJson(CustomResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.per_page,
      'total': instance.total,
      'total_pages': instance.total_pages,
      'data': instance.data,
    };
