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
    required Address rootTokenContract,
    @moneyFromStringJsonConverter required Money fiatBalance,
    @moneyFromStringJsonConverter required Money tokenBalance,
  }) = _AccountBalanceModel;

  factory AccountBalanceModel.fromJson(Map<String, dynamic> json) =>
      _$AccountBalanceModelFromJson(json);

  @override
  int get hashCode => rootTokenContract.hashCode;

  @override
  bool operator ==(Object other) =>
      other is AccountBalanceModel &&
      other.rootTokenContract == rootTokenContract;
}

extension AccountBalancesExt on List<AccountBalanceModel> {
  AccountBalanceModel? tokenBalance(Address rootTokenContract) =>
      firstWhereOrNull((b) => b.rootTokenContract == rootTokenContract);
}