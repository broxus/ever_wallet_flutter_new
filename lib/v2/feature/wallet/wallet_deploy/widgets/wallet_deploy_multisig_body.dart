import 'package:app/v2/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

final _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');

const publicKeyLength = 64;

/// Minimum quantity of custodians for [WalletDeployType.multisig]
const minConfirmationsCount = 2;

/// Widget that allows prepare data for multisig deploy.
class WalletDeployMultisigBody extends StatefulWidget {
  const WalletDeployMultisigBody({
    required this.custodians,
    required this.requireConfirmations,
    super.key,
  });

  /// This data is just initial data and not used during lifecycle.
  final List<PublicKey> custodians;
  final int requireConfirmations;

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
  late TextEditingController requireConfirmationController =
      TextEditingController(text: widget.requireConfirmations.toString());

  /// If true, then some of custodian focuses has focus
  final focusNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    for (final f in custodianFocuses) {
      // ignore: always-remove-listener
      f.addListener(_focusListener);
    }
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
    super.dispose();
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
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data?.text != null) {
      custodianControllers[index].text = data!.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

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
                separatorSize: DimensSize.d16,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: focusNotifier,
                    builder: (context, value, _) {
                      if (value) {
                        return const CommonDivider();
                      }

                      return SeparatedColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        separatorSize: DimensSize.d16,
                        children: [
                          WalletSelectDeployTypeWidget(
                            type: WalletDeployType.multisig,
                            onChangeAction: (context) =>
                                context.read<WalletDeployBloc>().add(
                                      WalletDeployEvent.updateMultisigData(
                                        _collectValidKeys(),
                                        _collectRequireConfirmations(),
                                      ),
                                    ),
                          ),
                          CommonInput(
                            controller: requireConfirmationController,
                            titleText: LocaleKeys.evaluationConfirmation.tr(),
                            subtitleText: LocaleKeys.outOfNumber.tr(
                              args: [custodianControllers.length.toString()],
                            ),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSubmitted: (_) =>
                                custodianFocuses.first.requestFocus(),
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            validator: _validateRequireConfirmations,
                          ),
                        ],
                      );
                    },
                  ),
                  Text(
                    LocaleKeys.custodiansWord.tr(),
                    style: StyleRes.h2.copyWith(color: colors.textPrimary),
                  ),
                  ...custodianControllers.mapIndexed(_custodianItem),
                  CommonButton(
                    buttonType: EverButtonType.ghost,
                    leading: CommonButtonIconWidget.svg(
                      svg: Assets.images.plus.path,
                    ),
                    text: LocaleKeys.addOneMorePublicKey.tr(),
                    onPressed: _addOneCustodian,
                    textAlign: TextAlign.center,
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
          child: CommonButton.primary(
            fillWidth: true,
            text: LocaleKeys.nextWord.tr(),
            onPressed: () => _next(context),
          ),
        ),
      ],
    );
  }

  Widget _custodianItem(int index, TextEditingController controller) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonInput(
          key: ValueKey(controller.hashCode),
          controller: controller,
          focusNode: custodianFocuses[index],
          titleText: LocaleKeys.publicKeyOfCustodianNumber
              .tr(args: [(index + 1).toString()]),
          textInputAction: index == custodianControllers.length - 1
              ? TextInputAction.done
              : TextInputAction.next,
          onSubmitted: (value) {
            if (index != custodianControllers.length - 1) {
              custodianFocuses[index + 1].requestFocus();
            } else {
              _next(context);
            }
          },
          maxLength: publicKeyLength,
          suffixIcon: _custodianSuffixIcon(controller, index),
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'\s')),
            FilteringTextInputFormatter.allow(RegExp('[a-fA-F0-9]')),
          ],
          validator: _validatePublicKey,
          outerActions: [
            if (index >= minConfirmationsCount)
              CommonIconButton.svg(
                svg: Assets.images.trash.path,
                buttonType: EverButtonType.secondary,
                color: colors.alert,
                onPressed: () => _removeCustodian(index),
                size: CommonIconButtonSize.small,
              ),
          ],
        );
      },
    );
  }

  Widget _custodianSuffixIcon(
    TextEditingController controller,
    int index,
  ) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final colors = context.themeStyle.colors;

        return value.text.isNotEmpty
            ? CommonIconButton.icon(
                buttonType: EverButtonType.ghost,
                icon: Icons.clear_rounded,
                size: CommonIconButtonSize.medium,
                onPressed: controller.clear,
                color: colors.textSecondary,
              )
            : CommonIconButton.svg(
                buttonType: EverButtonType.ghost,
                svg: Assets.images.paste.path,
                size: CommonIconButtonSize.medium,
                onPressed: () => _pasteCustodian(index),
                color: colors.blue,
              );
      },
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
}
