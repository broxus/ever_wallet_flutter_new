import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'stever_withdraw_request.freezed.dart';

part 'stever_withdraw_request.g.dart';

/// Request of stever withdraw. This request can be cancelled to return
/// stever back
class StEverWithdrawRequest {
  const StEverWithdrawRequest({
    required this.nonce,
    required this.data,
    required this.accountAddress,
  });

  final StEverWithdrawRequestData data;
  final String nonce;
  final String accountAddress;
}

@freezed
class StEverWithdrawRequestData with _$StEverWithdrawRequestData {
  const factory StEverWithdrawRequestData({
    @amountJsonConverter required BigInt amount,
    required String timestamp,
  }) = _StEverWithdrawRequestData;

  factory StEverWithdrawRequestData.fromJson(Map<String, dynamic> json) =>
      _$StEverWithdrawRequestDataFromJson(json);
}
