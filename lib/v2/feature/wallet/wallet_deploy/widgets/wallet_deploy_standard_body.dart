import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows deploy wallet with standard type
class WalletDeployStandardBody extends StatelessWidget {
  const WalletDeployStandardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DimensSize.d16),
      child: SeparatedColumn(
        children: [
          const WalletSelectDeployTypeWidget(
            type: WalletDeployType.standard,
          ),
          const Spacer(),
          CommonButton.primary(
            fillWidth: true,
            text: LocaleKeys.nextWord.tr(),
            onPressed: () => context
                .read<WalletDeployBloc>()
                .add(const WalletDeployEvent.deployStandard()),
          ),
        ],
      ),
    );
  }
}
