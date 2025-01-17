import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'gas_price_params.freezed.dart';
part 'gas_price_params.g.dart';

@immutable
@freezed
class GasPriceParams with _$GasPriceParams {
  const factory GasPriceParams({
    /// Flat tag
    required String tag1,

    /// Ext tag
    required String tag2,

    /// The price of gas unit
    @amountJsonConverter required BigInt gasPrice,

    /// The maximum amount of gas available for a compute phase of
    /// an ordinary transaction
    @amountJsonConverter required BigInt gasLimit,

    /// The maximum amount of gas available for a compute phase of
    /// a special transaction
    @amountJsonConverter required BigInt specialGasLimit,

    /// The maximum amount of gas available before `ACCEPT`
    @amountJsonConverter required BigInt gasCredit,

    /// The maximum amount of gas units per block
    @amountJsonConverter required BigInt blockGasLimit,

    /// Amount of debt (in tokens) after which the account will be frozen
    @amountJsonConverter required BigInt freezeDueLimit,

    /// Amount of debt (in tokens) after which the contract will be deleted
    @amountJsonConverter required BigInt deleteDueLimit,

    /// Size of the first portion of gas with different price
    @amountJsonConverter required BigInt flatGasLimit,

    /// The gas price for the first portion determinted by flatGasLimit
    @amountJsonConverter required BigInt flatGasPrice,
  }) = _GasPriceParams;

  factory GasPriceParams.fromJson(Map<String, dynamic> json) =>
      _$GasPriceParamsFromJson(json);
}
