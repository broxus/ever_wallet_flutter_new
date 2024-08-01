import 'package:app/di/di.dart';
import 'package:app/v1/feature/wallet/ton_confirm_transaction/ton_confirm_transaction.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows select local custodians to confirm multisig transaction
class TonWalletConfirmTransactionPrepare extends StatefulWidget {
  const TonWalletConfirmTransactionPrepare({
    required this.localCustodians,
    super.key,
  });

  final List<PublicKey> localCustodians;

  @override
  State<TonWalletConfirmTransactionPrepare> createState() =>
      _TonWalletConfirmTransactionPrepareState();
}

class _TonWalletConfirmTransactionPrepareState
    extends State<TonWalletConfirmTransactionPrepare> {
  late final custodianNotifier =
      ValueNotifier<PublicKey>(widget.localCustodians.first);

  @override
  void dispose() {
    custodianNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d16),
      child: SeparatedColumn(
        children: [
          ValueListenableBuilder<PublicKey>(
            valueListenable: custodianNotifier,
            builder: (context, value, _) {
              return CommonSelectDropdown<PublicKey>(
                values: widget.localCustodians
                    .map(
                      (c) => CommonSheetDropdownItem<PublicKey>(
                        value: c,
                        title: inject<NekotonRepository>()
                                .seedList
                                .findSeedKey(c)
                                ?.name ??
                            c.toEllipseString(),
                      ),
                    )
                    .toList(),
                titleText: LocaleKeys.custodianWord.tr(),
                currentValue: value,
                onChanged: (custodian) => custodianNotifier.value = custodian,
              );
            },
          ),
          const Spacer(),
          CommonButton.primary(
            fillWidth: true,
            text: LocaleKeys.nextWord.tr(),
            onPressed: () => context.read<TonConfirmTransactionBloc>().add(
                  TonConfirmTransactionEvent.prepare(custodianNotifier.value),
                ),
          ),
        ],
      ),
    );
  }
}
