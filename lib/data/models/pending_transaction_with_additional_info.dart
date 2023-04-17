import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'pending_transaction_with_additional_info.freezed.dart';
part 'pending_transaction_with_additional_info.g.dart';

@freezed
class PendingTransactionWithAdditionalInfo
    with _$PendingTransactionWithAdditionalInfo
    implements Comparable<PendingTransactionWithAdditionalInfo> {
  const factory PendingTransactionWithAdditionalInfo({
    required PendingTransaction transaction,
    String? dst,
    String? amount,
    required int createdAt,
  }) = _PendingTransactionWithAdditionalInfo;

  factory PendingTransactionWithAdditionalInfo.fromJson(Map<String, dynamic> json) =>
      _$PendingTransactionWithAdditionalInfoFromJson(json);

  const PendingTransactionWithAdditionalInfo._();

  @override
  int compareTo(PendingTransactionWithAdditionalInfo other) =>
      -createdAt.compareTo(other.createdAt);
}
