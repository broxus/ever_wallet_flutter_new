import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'account_balance.freezed.dart';
part 'account_balance.g.dart';

/// Model of cached fiat and token balance that could be saved and restored
/// to access balance before creating subscription.
@immutable
@freezed
class AccountBalanceModel with _$AccountBalanceModel {
  const factory AccountBalanceModel({
    @NekotonAddressConverter() required Address rootTokenContract,
    @moneyFromStringJsonConverter required Money fiatBalance,
    @moneyFromStringJsonConverter required Money tokenBalance,
    @JsonKey(defaultValue: false) required bool isNative,
  }) = _AccountBalanceModel;

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceModelFromJson(json);
}

extension AccountBalancesExt on List<AccountBalanceModel> {
  AccountBalanceModel? tokenBalance(
    Address rootTokenContract, {
    bool isNative = false,
  }) =>
      firstWhereOrNull(
        (b) =>
            b.rootTokenContract == rootTokenContract && b.isNative == isNative,
      );
}
