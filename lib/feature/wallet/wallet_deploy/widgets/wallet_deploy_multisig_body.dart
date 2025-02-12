// ignore_for_file: lines_longer_than_80_chars

import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_deploy/clipboard_paste_button.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/utils/input_formatters.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

final _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

const publicKeyLength = 64;

/// Minimum quantity of custodians for [WalletDeployType.multisig]
const minConfirmationsCount = 2;

/// Widget that allows prepare data for multisig deploy.
class WalletDeployMultisigBody extends StatefulWidget {
  const WalletDeployMultisigBody({
    required this.custodians,
    required this.requireConfirmations,
    required this.hours,
    required this.walletType,
    super.key,
  });

  /// This data is just initial data and not used during lifecycle.
  final List<PublicKey> custodians;
  final int requireConfirmations;
  final int hours;
  final WalletType walletType;

  @override
  State<WalletDeployMultisigBody> createState() =>
      _WalletDeployMultisigBodyState();
}

class _WalletDeployMultisigBodyState extends State<WalletDeployMultisigBody> {
  final _formKey = GlobalKey<FormState>();

  late List<TextEditingController> custodianControllers = List.generate(
    widget.custodians.isEmpty ? 3 : widget.custodians.length,
    (index) => TextEditingController(
      text: widget.custodians.isEmpty ? '' : widget.custodians[index].publicKey,
    ),
  );
  late List<FocusNode> custodianFocuses = List.generate(
    widget.custodians.isEmpty ? 3 : widget.custodians.length,
    (_) => FocusNode(),
  );

  late FocusNode waitingTimeNode = FocusNode();
  late TextEditingController requireConfirmationController =
      TextEditingController(text: widget.requireConfirmations.toString());

  late TextEditingController waitingTimeController =
      TextEditingController(text: widget.hours.toString());

  /// If true, then some of custodian focuses has focus
  final focusNotifier = ValueNotifier<bool>(false);

  bool get isMultisig2_1 =>
      widget.walletType == const WalletType.multisig(MultisigType.multisig2_1);

  @override
  void initState() {
    super.initState();
    for (final f in custodianFocuses) {
      // ignore: always-remove-listener
      f.addListener(_focusListener);
    }
    waitingTimeController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    for (final c in custodianControllers) {
      c.dispose();
    }
    for (final f in custodianFocuses) {
      f
        ..removeListener(_focusListener)
        ..dispose();
    }
    requireConfirmationController.dispose();
    focusNotifier.dispose();
    waitingTimeController.dispose();
    waitingTimeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = context.themeStyleV2.textStyles;

    return Stack(
      children: [
        Positioned.fill(
          bottom: commonButtonHeight,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(DimensSize.d16),
            child: Form(
              key: _formKey,
              child: SeparatedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: focusNotifier,
                    builder: (context, value, _) {
                      if (value) {
                        return const CommonDivider();
                      }

                      return SeparatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        separatorSize: DimensSize.d12,
                        children: [
                          WalletSelectDeployTypeWidget(
                            type: WalletDeployType.multisig,
                            onChangeAction: (context) =>
                                context.read<WalletDeployBloc>().add(
                                      WalletDeployEvent.updateMultisigData(
                                        _collectValidKeys(),
                                        _collectRequireConfirmations(),
                                        waitingTimeController.text.toInt(),
                                      ),
                                    ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: DimensSizeV2.d8),
                              SeparatedRow(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: PrimaryTextField(
                                      textEditingController:
                                          requireConfirmationController,
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.next,
                                      onSubmit: (_) =>
                                          custodianFocuses.first.requestFocus(),
                                      inputFormatters: [
                                        InputFormatters.noSpacesFormatter,
                                        InputFormatters.onlyDigitsFormatter,
                                      ],
                                      validator: _validateRequireConfirmations,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: DimensSizeV2.d18,
                                    ),
                                    child: Text(
                                      LocaleKeys.outOfNumber.tr(
                                        args: [
                                          custodianControllers.length
                                              .toString(),
                                        ],
                                      ),
                                      style: textStyles.labelSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  if (isMultisig2_1)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: DimensSizeV2.d8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.deployWalletWaitingTime.tr(),
                            style: textStyles.labelSmall,
                          ),
                          const SizedBox(height: DimensSizeV2.d8),
                          PrimaryTextField(
                            focusNode: waitingTimeNode,
                            textEditingController: waitingTimeController,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSubmit: (_) =>
                                custodianFocuses.first.requestFocus(),
                            validator: (value) {
                              if (value == null) {
                                return LocaleKeys.invalidValue.tr();
                              }
                              final number = int.tryParse(value);
                              if (number == null ||
                                  number > 24 ||
                                  number == 0) {
                                return LocaleKeys.invalidValue.tr();
                              }
                              return null;
                            },
                            inputFormatters: [
                              InputFormatters.onlyDigitsFormatter,
                            ],
                            suffixes: [
                              _buildMiniButton(1),
                              _buildMiniButton(2),
                              _buildMiniButton(12),
                              _buildMiniButton(24),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: DimensSizeV2.d12),
                  Text(
                    LocaleKeys.custodiansWord.tr(),
                    style: textStyles.labelSmall,
                  ),
                  ...custodianControllers.mapIndexed(_custodianItem),
                  const SizedBox(height: DimensSizeV2.d8),
                  if (custodianControllers.length < 32)
                    GhostButton(
                      icon: LucideIcons.plus,
                      title: LocaleKeys.addOneMorePublicKey.tr(),
                      onPressed: _addOneCustodian,
                      buttonShape: ButtonShape.pill,
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: DimensSize.d16,
          left: DimensSize.d16,
          right: DimensSize.d16,
          child: Padding(
            padding: const EdgeInsets.only(bottom: DimensSizeV2.d8),
            child: AccentButton(
              buttonShape: ButtonShape.pill,
              title: LocaleKeys.nextWord.tr(),
              onPressed: () => _next(context),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniButton(int hours) {
    return MiniButton(
      currentValue: waitingTimeController.text.toInt(),
      value: hours,
      title: '${hours}h',
      onTap: () {
        setState(() {
          waitingTimeController.text = hours.toString();
        });
      },
    );
  }

  Widget _custodianItem(int index, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DimensSizeV2.d4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: PrimaryTextField(
              key: ValueKey(controller.hashCode),
              textEditingController: controller,
              focusNode: custodianFocuses[index],
              hintText: LocaleKeys.publicKeyOfCustodianNumber
                  .tr(args: [(index + 1).toString()]),
              textInputAction: index == custodianControllers.length - 1
                  ? TextInputAction.done
                  : TextInputAction.next,
              onSubmit: (value) {
                if (index != custodianControllers.length - 1) {
                  custodianFocuses[index + 1].requestFocus();
                } else {
                  _next(context);
                }
              },
              maxLength: publicKeyLength,
              suffixes: [_custodianSuffixIcon(controller, index)],
              inputFormatters: [
                InputFormatters.noSpacesFormatter,
                InputFormatters.publicKeyInputFormatter,
              ],
              validator: _validatePublicKey,
            ),
          ),
          if (index >= minConfirmationsCount)
            Padding(
              padding: const EdgeInsets.only(
                left: DimensSizeV2.d8,
                top: DimensSizeV2.d4,
              ),
              child: DestructiveButton(
                buttonShape: ButtonShape.circle,
                icon: LucideIcons.trash,
                buttonSize: ButtonSize.medium,
                onPressed: () => _removeCustodian(index),
              ),
            ),
        ],
      ),
    );
  }

  Widget _custodianSuffixIcon(
    TextEditingController controller,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: DimensSize.d8),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (context, value, _) {
          return value.text.isNotEmpty
              ? PrimaryButton(
                  buttonShape: ButtonShape.square,
                  icon: LucideIcons.x,
                  buttonSize: ButtonSize.small,
                  onPressed: controller.clear,
                )
              : ClipboardPasteButton(
                  onPressed: () => _pasteCustodian(index),
                );
        },
      ),
    );
  }

  void _next(BuildContext context) {
    FocusScope.of(context).unfocus();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_formKey.currentState?.validate() ?? false) {
        context.read<WalletDeployBloc>().add(
              WalletDeployEvent.deployMultisig(
                _collectValidKeys(),
                _collectRequireConfirmations(),
                waitingTimeController.text.toInt(),
              ),
            );
      }
    });
  }

  /// Get list of valid public keys
  List<PublicKey> _collectValidKeys() => custodianControllers
      .where((v) => _validatePublicKey(v.text) == null)
      .map((v) => PublicKey(publicKey: v.text))
      .toList();

  int _collectRequireConfirmations() {
    if (_validateRequireConfirmations(requireConfirmationController.text) ==
        null) {
      return int.parse(requireConfirmationController.text);
    }

    return defaultRequireConfirmations;
  }

  String? _validatePublicKey(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.invalidValue.tr();
    }

    if (!_alphanumeric.hasMatch(value)) {
      return LocaleKeys.invalidValue.tr();
    }

    if (value.length != publicKeyLength) {
      return LocaleKeys.invalidLengthMustBe
          .tr(args: [publicKeyLength.toString()]);
    }

    return null;
  }

  String? _validateRequireConfirmations(String? value) {
    if (value == null || value.isEmpty) {
      return LocaleKeys.invalidValue.tr();
    }

    final number = int.tryParse(value);

    if (number == null || number < 1 || number > custodianControllers.length) {
      return LocaleKeys.invalidValue.tr();
    }

    return null;
  }

  void _focusListener() =>
      focusNotifier.value = custodianFocuses.any((f) => f.hasFocus);

  void _addOneCustodian() {
    setState(() {
      custodianFocuses.add(FocusNode()..addListener(_focusListener));
      custodianControllers.add(TextEditingController());
    });
  }

  void _removeCustodian(int index) {
    setState(() {
      custodianControllers.removeAt(index).dispose();
      custodianFocuses.removeAt(index)
        ..removeListener(_focusListener)
        ..dispose();
    });
  }

  Future<void> _pasteCustodian(int index) async {
    final text = await getClipBoardText();
    if (text != null) {
      custodianControllers[index].text = text;
    }
  }
}
