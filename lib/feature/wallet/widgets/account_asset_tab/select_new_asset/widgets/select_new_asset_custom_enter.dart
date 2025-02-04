// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/select_new_asset/select_new_asset.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/utils/input_formatters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Widget that allows user to enter address of root token contract to add
/// it to account.
class SelectNewAssetCustomEnter extends StatefulWidget {
  const SelectNewAssetCustomEnter({
    required this.focus,
    required this.contracts,
    super.key,
  });

  final FocusNode focus;
  final List<(TokenContractAsset, bool)> contracts;

  @override
  State<SelectNewAssetCustomEnter> createState() =>
      _SelectNewAssetCustomEnterState();
}

class _SelectNewAssetCustomEnterState extends State<SelectNewAssetCustomEnter> {
  final addressController = TextEditingController();

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d16,
              children: [
                PrimaryTextField(
                  hintText: LocaleKeys.rootTokenContract.tr(),
                  textEditingController: addressController,
                  onSubmit: (_) => _enable(context),
                  inputFormatters: [
                    InputFormatters.noSpacesFormatter,
                  ],
                  suffixes: [
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: addressController,
                      builder: (context, value, _) {
                        if (value.text.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              right: DimensSizeV2.d8,
                            ),
                            child: FloatButton(
                              buttonShape: ButtonShape.square,
                              buttonSize: ButtonSize.small,
                              icon: LucideIcons.arrowDownToDot,
                              onPressed: () => _paste(context),
                            ),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                            right: DimensSizeV2.d8,
                          ),
                          child: FloatButton(
                            buttonShape: ButtonShape.square,
                            buttonSize: ButtonSize.small,
                            icon: LucideIcons.x,
                            onPressed: () {
                              widget.focus.unfocus();
                              addressController.clear();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SeparatedColumn(
                  separatorSize: DimensSizeV2.d12,
                  children: [
                    ...widget.contracts.map(
                      (pair) => SelectNewAssetItem(
                        asset: pair.$1,
                        isSelected: pair.$2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: addressController,
          builder: (_, value, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: DimensSizeV2.d12),
            child: Padding(
              padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
              child: AccentButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.proceedWord.tr(),
                onPressed:
                    value.text.isNotEmpty ? () => _enable(context) : null,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _enable(BuildContext context) {
    widget.focus.unfocus();

    context
        .read<SelectNewAssetCubit>()
        .addCustom(context, Address(address: addressController.text.trim()));
  }

  Future<void> _paste(BuildContext context) async {
    final text = await getClipBoardText();
    if (text?.isEmpty ?? true) return;

    final isValid = validateAddress(Address(address: text!));
    if (isValid) {
      addressController.text = text;
    } else {
      inject<MessengerService>().show(
        Message.error(
          context: context,
          message: LocaleKeys.invalidRootTokenContract.tr(),
        ),
      );
    }
  }
}
