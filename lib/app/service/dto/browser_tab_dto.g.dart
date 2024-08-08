// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_tab_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrowserTabImplAdapter extends TypeAdapter<_$BrowserTabImpl> {
  @override
  final int typeId = 55;

  @override
  _$BrowserTabImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$BrowserTabImpl(
      url: fields[0] as String,
      image: fields[1] as String?,
      title: fields[2] as String?,
      lastScrollPosition: fields[3] == null ? 0 : fields[3] as int,
      screenshot: fields[4] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, _$BrowserTabImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.lastScrollPosition)
      ..writeByte(4)
      ..write(obj.screenshot);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrowserTabImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
