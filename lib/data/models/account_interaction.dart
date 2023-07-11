import 'package:app/data/models/wallet_contract_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_interaction.freezed.dart';
part 'account_interaction.g.dart';

@freezed
class AccountInteraction with _$AccountInteraction {
  const factory AccountInteraction({
    required Address address,
    required PublicKey publicKey,
    required WalletContractType contractType,
  }) = _AccountInteraction;

  factory AccountInteraction.fromJson(Map<String, dynamic> json) =>
      _$AccountInteractionFromJson(json);
}
