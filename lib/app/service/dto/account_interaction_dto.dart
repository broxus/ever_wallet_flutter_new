// ignore_for_file: no-magic-number

import 'package:app/app/service/dto/wallet_contract_type_dto.dart';
import 'package:app/data/models/account_interaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_interaction_dto.freezed.dart';
part 'account_interaction_dto.g.dart';

@freezed
class AccountInteractionDto with _$AccountInteractionDto {
  @HiveType(typeId: 222)
  const factory AccountInteractionDto({
    @HiveField(0) required String address,
    @HiveField(1) required String publicKey,
    @HiveField(2) required WalletContractTypeDto contractType,
  }) = _AccountInteractionDto;
}

extension AccountInteractionX on AccountInteraction {
  AccountInteractionDto toDto() => AccountInteractionDto(
        address: address.address,
        publicKey: publicKey.publicKey,
        contractType: contractType.toDto(),
      );
}

extension AccountInteractionDtoX on AccountInteractionDto {
  AccountInteraction toModel() => AccountInteraction(
        address: Address(address: address),
        publicKey: PublicKey(publicKey: publicKey),
        contractType: contractType.toModel(),
      );
}
