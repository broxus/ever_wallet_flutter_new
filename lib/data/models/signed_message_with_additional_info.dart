import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'signed_message_with_additional_info.freezed.dart';

@freezed
class SignedMessageWithAdditionalInfo with _$SignedMessageWithAdditionalInfo {
  const factory SignedMessageWithAdditionalInfo({
    required SignedMessage message,
    String? dst,
    @amountJsonConverter BigInt? amount,
  }) = _SignedMessageWithAdditionalInfo;
}
