import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_transactions_tab/detail/details_item.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

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
    return ShapedContainerColumn(
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
      title: key?.name ??
          LocaleKeys.custodianNumber.tr(args: [(index + 1).toString()]),
      content: custodian.publicKey,
      titleTrailingChild: _custodianInfo(custodian),
    );
  }

  Widget _custodianInfo(PublicKey custodian) {
    final isSign = confirmations.contains(custodian);
    final signInfo = CommonChips(
      title:
          isSign ? LocaleKeys.signedWord.tr() : LocaleKeys.notSignedWord.tr(),
      leading: CommonIconWidget.svg(
        size: DimensSize.d16,
        svg:
            isSign ? Assets.images.checkRounded.path : Assets.images.close.path,
      ),
      type: isSign ? CommonChipsType.success : CommonChipsType.secondary,
    );

    return Wrap(
      spacing: DimensSize.d8,
      alignment: WrapAlignment.end,
      runSpacing: DimensSize.d4,
      children: [
        if (custodian == initiator)
          CommonChips(
            title: LocaleKeys.initiatorWord.tr(),
            leading: CommonIconWidget.svg(
              size: DimensSize.d16,
              svg: Assets.images.persons.path,
            ),
            type: CommonChipsType.warning,
          ),
        signInfo,
      ],
    );
  }
}
