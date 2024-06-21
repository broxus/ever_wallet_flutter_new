// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_meta_data_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SiteMetaDataDtoImplAdapter extends TypeAdapter<_$SiteMetaDataDtoImpl> {
  @override
  final int typeId = 2;

  @override
  _$SiteMetaDataDtoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$SiteMetaDataDtoImpl(
      url: fields[0] as String,
      title: fields[1] as String?,
      image: fields[2] as String?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$SiteMetaDataDtoImpl obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SiteMetaDataDtoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
