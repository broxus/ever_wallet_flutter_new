import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_balance.freezed.dart';
part 'token_balance.g.dart';

@freezed
class TokenBalanceModel with _$TokenBalanceModel {
  const factory TokenBalanceModel({
    required String amount,
    required Address ownerAddress,
    required Address rootAddress,
    required Address tokenWalletAddress,
    required String token,
  }) = _TokenBalanceModel;

  factory TokenBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$TokenBalanceModelFromJson(json);
}
