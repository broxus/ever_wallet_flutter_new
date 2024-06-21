// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PermissionsDtoImplAdapter extends TypeAdapter<_$PermissionsDtoImpl> {
  @override
  final int typeId = 223;

  @override
  _$PermissionsDtoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$PermissionsDtoImpl(
      basic: fields[0] as bool?,
      accountInteraction: fields[1] as AccountInteractionDto?,
    );
  }

  @override
  void write(BinaryWriter writer, _$PermissionsDtoImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.basic)
      ..writeByte(1)
      ..write(obj.accountInteraction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PermissionsDtoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
