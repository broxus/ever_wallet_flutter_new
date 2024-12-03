import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/widgets/chips/chips.dart';

/// Widget that displays information about custodians for multisig transactions
/// for TonWallet.
class TonWalletTransactionCustodiansDetails extends StatelessWidget {
  const TonWalletTransactionCustodiansDetails({
    required this.custodians,
    required this.confirmations,
    required this.initiator,
    this.requiredConfirmations,
    super.key,
  });

  /// List of custodians of wallet
  final List<PublicKey> custodians;

  /// List of custodians that had been already confirmed this transaction
  final List<PublicKey> confirmations;

  /// Custodian that created transaction
  final PublicKey initiator;

  /// How many confirmations required to complete transaction.
  /// This field is absent for completed transactions.
  final int? requiredConfirmations;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return ShapedContainerColumn(
      color: theme.colors.background1,
      titleText: LocaleKeys.signaturesWord.tr(),
      subtitleText: requiredConfirmations == null
          ? null
          : LocaleKeys.signaturesCollected.tr(
              args: [
                confirmations.length.toString(),
                requiredConfirmations!.toString(),
              ],
            ),
      mainAxisSize: MainAxisSize.min,
      separator: const Padding(
        padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
        child: CommonDivider(),
      ),
      children: custodians.mapIndexed(_custodianItem).toList(),
    );
  }

  Widget _custodianItem(int index, PublicKey custodian) {
    final key = inject<NekotonRepository>().seedList.findSeedKey(custodian);

    return TonWalletTransactionDetailsItem(
      title: LocaleKeys.custodianNumber.tr(args: [(index + 1).toString()]),
      content: custodian.publicKey,
      titleTrailingChild: _custodianInfo(custodian),
      copyValue: custodian.publicKey,
      copyMessage: LocaleKeys.valueCopiedExclamation.tr(
        args: [custodian.toEllipseString()],
      ),
    );
  }

  Widget _custodianInfo(PublicKey custodian) {
    final isSign = confirmations.contains(custodian);
    final signInfo = PrimaryChip(
      text: isSign ? LocaleKeys.signedWord.tr() : LocaleKeys.notSignedWord.tr(),
      iconData: isSign ? LucideIcons.circleCheck : LucideIcons.circleX,
      type: isSign ? ChipsType.success : ChipsType.normal,
    );

    return Wrap(
      spacing: DimensSize.d8,
      alignment: WrapAlignment.end,
      runSpacing: DimensSize.d4,
      children: [
        if (custodian == initiator)
          PrimaryChip(
            text: LocaleKeys.initiatorWord.tr(),
            iconData: LucideIcons.user,
            type: ChipsType.warning,
          ),
        signInfo,
      ],
    );
  }
}
