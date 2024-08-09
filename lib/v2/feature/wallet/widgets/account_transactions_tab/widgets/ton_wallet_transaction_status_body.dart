import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Status of transaction that could be used to display additional information
/// about transaction
enum TonWalletTransactionStatus {
  completed, // transaction fully completed
  pending, // transaction in progress
  waitingConfirmation, // waiting for confirmation
  expired, // transaction time expired
  unstakingInProgress; // custom status for unstaking request

  String? get title {
    return switch (this) {
      TonWalletTransactionStatus.completed => null,
      TonWalletTransactionStatus.pending =>
        LocaleKeys.transactionStatusInProgress.tr(),
      TonWalletTransactionStatus.waitingConfirmation =>
        LocaleKeys.transactionStatusWaitingConfirmation.tr(),
      TonWalletTransactionStatus.expired =>
        LocaleKeys.transactionStatusExpired.tr(),
      TonWalletTransactionStatus.unstakingInProgress =>
        LocaleKeys.unstakingInProgress.tr(),
    };
  }

  CommonChipsType chipType() => switch (this) {
        TonWalletTransactionStatus.completed => CommonChipsType.success,
        TonWalletTransactionStatus.pending => CommonChipsType.note,
        TonWalletTransactionStatus.waitingConfirmation =>
          CommonChipsType.warning,
        TonWalletTransactionStatus.expired => CommonChipsType.warning,
        TonWalletTransactionStatus.unstakingInProgress => CommonChipsType.note,
      };
}

/// Widget that displays status of TonWallet transaction.
/// If status title is null, then returns null.
Widget? tonWalletTransactionStatusBody(TonWalletTransactionStatus status) {
  final title = status.title;
  if (title == null) return null;

  return CommonChips(
    title: title,
    type: status.chipType(),
  );
}
