import 'package:app/data/models/wallet_contract_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_interaction.freezed.dart';
part 'account_interaction.g.dart';

@freezed
class AccountInteraction with _$AccountInteraction {
  const factory AccountInteraction({
    required String address,
    required String publicKey,
    required WalletContractType contractType,
  }) = _AccountInteraction;

  factory AccountInteraction.fromJson(Map<String, dynamic> json) =>
      _$AccountInteractionFromJson(json);
}
