import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that allows user to enter address of root token contract to add
/// it to account.
class SelectNewAssetCustomEnter extends StatefulWidget {
  const SelectNewAssetCustomEnter({super.key});

  @override
  State<SelectNewAssetCustomEnter> createState() =>
      _SelectNewAssetCustomEnterState();
}

class _SelectNewAssetCustomEnterState extends State<SelectNewAssetCustomEnter> {
  final addressController = TextEditingController();
  final focus = FocusNode();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Column(
      children: [
        CommonInput(
          controller: addressController,
          onSubmitted: (_) => _enable(context),
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
          ],
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: addressController,
            builder: (context, value, _) {
              if (value.text.isEmpty) {
                return CommonIconButton.svg(
                  buttonType: EverButtonType.ghost,
                  svg: Assets.images.paste.path,
                  onPressed: _paste,
                  color: colors.blue,
                );
              }

              return CommonIconButton.icon(
                buttonType: EverButtonType.ghost,
                icon: Icons.clear_rounded,
                onPressed: () {
                  focus.unfocus();
                  addressController.clear();
                },
                color: colors.textSecondary,
              );
            },
          ),
        ),
        const Spacer(),
        CommonButton.primary(
          fillWidth: true,
          text: LocaleKeys.proceedWord.tr(),
          onPressed: () => _enable(context),
        ),
      ],
    );
  }

  void _enable(BuildContext context) {
    focus.unfocus();

    context
        .read<SelectNewAssetCubit>()
        .enableAsset(Address(address: addressController.text.trim()));
  }

  Future<void> _paste() async {
    final clipboard = await Clipboard.getData(Clipboard.kTextPlain);
    final text = clipboard?.text;
    if (text == null) return;

    final isValid = await validateAddress(Address(address: text));
    if (isValid) {
      addressController.text = text;
    } else {
      inject<MessengerService>().show(
        Message.error(message: LocaleKeys.invalidRootTokenContract.tr()),
      );
    }
  }
}
