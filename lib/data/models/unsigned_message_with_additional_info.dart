import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'unsigned_message_with_additional_info.freezed.dart';

@freezed
class UnsignedMessageWithAdditionalInfo
    with _$UnsignedMessageWithAdditionalInfo {
  const factory UnsignedMessageWithAdditionalInfo({
    required UnsignedMessage message,
    String? dst,
    @amountJsonConverter BigInt? amount,
  }) = _UnsignedMessageWithAdditionalInfo;
}
