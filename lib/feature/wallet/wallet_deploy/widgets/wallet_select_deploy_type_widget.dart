import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

extension on WalletDeployType {
  String get title {
    return switch (this) {
      WalletDeployType.standard => LocaleKeys.standardWallet.tr(),
      WalletDeployType.multisig => LocaleKeys.multisigWallet.tr(),
    };
  }
}

/// Widget that displays input that allows change deploy type for wallet.
class WalletSelectDeployTypeWidget extends StatelessWidget {
  const WalletSelectDeployTypeWidget({
    required this.currenyType,
    this.onChangeAction,
    super.key,
  });

  /// Additional action that will be called before changing type.
  /// This can be helpful to update multisig data
  final ValueChanged<BuildContext>? onChangeAction;

  final WalletDeployType currenyType;

  @override
  Widget build(BuildContext context) {
    return CommonSelectDropdown<WalletDeployType>(
      titleText: LocaleKeys.typeWord.tr(),
      sheetTitle: LocaleKeys.selectWalletType.tr(),
      values: WalletDeployType.values
          .map(
            (e) => CommonSheetDropdownItem<WalletDeployType>(
              value: e,
              title: e.title,
            ),
          )
          .toList(),
      currentValue: currenyType,
      onChanged: (t) {
        onChangeAction?.call(context);
        context.read<WalletDeployBloc>().add(WalletDeployEvent.changeType(t));
      },
    );
  }
}
