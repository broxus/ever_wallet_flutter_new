import 'package:app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'stever_withdraw_request.freezed.dart';
part 'stever_withdraw_request.g.dart';

/// Request of stever withdraw. This request can be cancelled to return
/// stever back
@freezed
class StEverWithdrawRequest with _$StEverWithdrawRequest {
  const factory StEverWithdrawRequest({
    required String nonce,
    required StEverWithdrawRequestData data,
    @NekotonAddressConverter() required Address accountAddress,
  }) = _StEverWithdrawRequest;

  factory StEverWithdrawRequest.fromJson(Map<String, dynamic> json) =>
      _$StEverWithdrawRequestFromJson(json);
}

@freezed
class StEverWithdrawRequestData with _$StEverWithdrawRequestData {
  const factory StEverWithdrawRequestData({
    @amountJsonConverter required BigInt amount,
    @timestampFromStringJsonConverter required DateTime timestamp,
  }) = _StEverWithdrawRequestData;

  factory StEverWithdrawRequestData.fromJson(Map<String, dynamic> json) =>
      _$StEverWithdrawRequestDataFromJson(json);
}
