// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchHistoryDtoImplAdapter extends TypeAdapter<_$SearchHistoryDtoImpl> {
  @override
  final int typeId = 56;

  @override
  _$SearchHistoryDtoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SearchHistoryDtoImpl(
      url: fields[0] as String,
      openTime: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, _$SearchHistoryDtoImpl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.openTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchHistoryDtoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
