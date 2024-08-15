import 'package:app/generated/generated.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/widgets/chips/chips.dart';

/// Status of transaction that could be used to display additional information
/// about transaction
enum TonWalletTransactionStatus {
  completed, // transaction fully completed
  pending, // transaction in progress
  waitingConfirmation, // waiting for confirmation
  expired, // transaction time expired
  unstakingInProgress; // custom status for unstaking request

  PrimaryChip get chipByStatus => switch (this) {
        TonWalletTransactionStatus.completed => PrimaryChip(
            text: LocaleKeys.transactionCompleted.tr(),
            iconData: LucideIcons.circleCheck,
            type: ChipsType.success,
          ),
        TonWalletTransactionStatus.pending => PrimaryChip(
            text: LocaleKeys.inProgress.tr(),
            iconData: LucideIcons.loader,
            type: ChipsType.normal,
          ),
        TonWalletTransactionStatus.waitingConfirmation => PrimaryChip(
            text: LocaleKeys.transactionStatusWaitingConfirmation.tr(),
            iconData: LucideIcons.usersRound,
            type: ChipsType.warning,
          ),
        TonWalletTransactionStatus.expired => PrimaryChip(
            text: LocaleKeys.transactionExpired.tr(),
            iconData: LucideIcons.flame,
            type: ChipsType.error,
          ),
        TonWalletTransactionStatus.unstakingInProgress => PrimaryChip(
            text: LocaleKeys.inProgress.tr(),
            iconData: LucideIcons.loader,
            type: ChipsType.normal,
          ),
      };

  String get title {
    return switch (this) {
      TonWalletTransactionStatus.completed =>
        LocaleKeys.transactionCompleted.tr(),
      TonWalletTransactionStatus.pending => LocaleKeys.inProgress.tr(),
      TonWalletTransactionStatus.waitingConfirmation =>
        LocaleKeys.transactionStatusWaitingConfirmation.tr(),
      TonWalletTransactionStatus.expired => LocaleKeys.transactionExpired.tr(),
      TonWalletTransactionStatus.unstakingInProgress =>
        LocaleKeys.inProgress.tr(),
    };
  }

  ChipsType get chipType => switch (this) {
        TonWalletTransactionStatus.completed => ChipsType.success,
        TonWalletTransactionStatus.pending => ChipsType.normal,
        TonWalletTransactionStatus.waitingConfirmation => ChipsType.warning,
        TonWalletTransactionStatus.expired => ChipsType.error,
        TonWalletTransactionStatus.unstakingInProgress => ChipsType.normal,
      };
}
