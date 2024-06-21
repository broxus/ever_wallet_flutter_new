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
      priceChange: fields[3] as String,
      tvl: fields[4] as String,
      tvlChange: fields[5] as String,
      volume24h: fields[6] as String,
      volumeChange24h: fields[7] as String,
      volume7d: fields[8] as String,
      fee24h: fields[9] as String,
      transactionsCount24h: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$CurrencyDtoImpl obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.currency)
      ..writeByte(1)
      ..write(obj.address)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.priceChange)
      ..writeByte(4)
      ..write(obj.tvl)
      ..writeByte(5)
      ..write(obj.tvlChange)
      ..writeByte(6)
      ..write(obj.volume24h)
      ..writeByte(7)
      ..write(obj.volumeChange24h)
      ..writeByte(8)
      ..write(obj.volume7d)
      ..writeByte(9)
      ..write(obj.fee24h)
      ..writeByte(10)
      ..write(obj.transactionsCount24h);
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
