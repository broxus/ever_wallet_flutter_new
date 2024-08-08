// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_interaction_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountInteractionDtoImplAdapter
    extends TypeAdapter<_$AccountInteractionDtoImpl> {
  @override
  final int typeId = 222;

  @override
  _$AccountInteractionDtoImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$AccountInteractionDtoImpl(
      address: fields[0] as String,
      publicKey: fields[1] as String,
      contractType: fields[2] as WalletContractTypeDto,
    );
  }

  @override
  void write(BinaryWriter writer, _$AccountInteractionDtoImpl obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.publicKey)
      ..writeByte(2)
      ..write(obj.contractType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountInteractionDtoImplAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
