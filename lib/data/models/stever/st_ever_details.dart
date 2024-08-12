import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'st_ever_details.freezed.dart';
part 'st_ever_details.g.dart';

/// This is not full contract info, but only used fields here
@freezed
class StEverDetails with _$StEverDetails {
  /// Total amount of assets in blockchain.
  /// Exchange rate calculates as totalAssets / stEverSupply
  const factory StEverDetails({
    @amountJsonConverter required BigInt stEverSupply,
    @amountJsonConverter required BigInt totalAssets,
    // Time before withdrawing in secodns
    required String withdrawHoldTime,
  }) = _StEverDetails;

  factory StEverDetails.fromJson(Map<String, dynamic> json) =>
      _$StEverDetailsFromJson(json);
}
