import 'package:app/feature/browser/approvals_listener/actions/send_message/send_message_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class SendMessageWidget extends ElementaryWidget<SendMessageWidgetModel> {
  const SendMessageWidget({
    required this.origin,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.bounce,
    required this.payload,
    required this.knownPayload,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultSendMessageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri origin;
  final Address sender;
  final Address recipient;
  final BigInt amount;
  final bool bounce;
  final FunctionCall? payload;
  final KnownPayload? knownPayload;
  final ScrollController scrollController;

  @override
  Widget build(SendMessageWidgetModel wm) {
    final theme = wm.theme;

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (wm.account != null)
                  StateNotifierBuilder(
                    listenableState: wm.balance,
                    builder: (_, balance) => AccountInfo(
                      account: wm.account!,
                      color: theme.colors.background2,
                      subtitle: balance?.let(
                        (value) => AmountWidget.fromMoney(
                          amount: value,
                          style: theme.textStyles.labelXSmall.copyWith(
                            color: theme.colors.content3,
                          ),
                          useDefaultFormat: false,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: DimensSizeV2.d12),
                WebsiteInfoWidget(uri: origin),
                DoubleSourceBuilder(
                  firstSource: wm.publicKey,
                  secondSource: wm.custodians,
                  builder: (_, publicKey, custodians) => custodians == null ||
                          custodians.length < 2
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(top: DimensSizeV2.d12),
                          child: CommonSelectDropdown<PublicKey>(
                            values: [
                              for (final c in custodians)
                                CommonSheetDropdownItem<PublicKey>(
                                  value: c,
                                  title:
                                      wm.getSeedName(c) ?? c.toEllipseString(),
                                ),
                            ],
                            titleText: LocaleKeys.custodianWord.tr(),
                            currentValue: publicKey,
                            onChanged: wm.onChangedCustodian,
                          ),
                        ),
                ),
                const SizedBox(height: DimensSizeV2.d12),
                TripleSourceBuilder(
                  firstSource: wm.data,
                  secondSource: wm.fee,
                  thirdSource: wm.feeError,
                  builder: (_, data, fee, feeError) =>
                      data?.let(
                        (data) => TokenTransferInfoWidget(
                          color: theme.colors.background2,
                          amount: data.amount,
                          attachedAmount: data.attachedAmount,
                          rootTokenContract: data.rootTokenContract,
                          recipient: recipient,
                          fee: fee,
                          feeError: feeError,
                        ),
                      ) ??
                      const SizedBox.shrink(),
                ),
                if (payload != null)
                  Padding(
                    padding: const EdgeInsets.only(top: DimensSizeV2.d12),
                    child: ExpandableCard(
                      collapsedHeight: DimensSizeV2.d256,
                      child: SeparatedColumn(
                        separatorSize: DimensSizeV2.d16,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            LocaleKeys.metadata.tr(),
                            style: theme.textStyles.labelSmall.copyWith(
                              color: theme.colors.content3,
                            ),
                          ),
                          FunctionCallBody(payload: payload!),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (wm.account != null)
          DoubleSourceBuilder(
            firstSource: wm.isLoading,
            secondSource: wm.txErrors,
            builder: (_, isLoading, txErrors) {
              if (txErrors?.isNotEmpty ?? false) {
                return TxTreeSimulationErrorWidget(txErrors: txErrors!);
              }

              return EnterPasswordWidgetV2(
                isLoading: isLoading,
                publicKey: wm.account!.publicKey,
                title: LocaleKeys.sendWord.tr(),
                onPasswordEntered: wm.onSubmit,
              );
            },
          ),
      ],
    );
  }
}
