// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_contract_asset_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenContractAssetDtoImplAdapter
    extends TypeAdapter<_$TokenContractAssetDtoImpl> {
  @override
  final int typeId = 1;

  @override
  _$TokenContractAssetDtoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$TokenContractAssetDtoImpl(
      name: fields[0] as String,
      symbol: fields[2] as String,
      decimals: fields[3] as int,
      address: fields[4] as String,
      version: fields[6] as int,
      chainId: fields[1] as int?,
      logoURI: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$TokenContractAssetDtoImpl obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.symbol)
      ..writeByte(3)
      ..write(obj.decimals)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.version)
      ..writeByte(1)
      ..write(obj.chainId)
      ..writeByte(5)
      ..write(obj.logoURI);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenContractAssetDtoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
