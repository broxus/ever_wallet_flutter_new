// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyDtoImplAdapter extends TypeAdapter<_$CurrencyDtoImpl> {
  @override
  final int typeId = 4;

  @override
  _$CurrencyDtoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$CurrencyDtoImpl(
      currency: fields[0] as String,
      address: fields[1] as String,
      price: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$CurrencyDtoImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyDtoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
