import 'dart:collection';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer_cubit/wallet_prepare_transfer_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to ask user password and initiator
/// publicKey to make [TonWallet.send] action.
// ignore_for_file: avoid-unused-parameters
Future<(PublicKey, String)?> showSendMessageSheet({
  required BuildContext context,
  required Uri origin,
  required Address sender,
  required Address recipient,
  required BigInt amount,
  required bool bounce,
  required String? comment,
  required KnownPayload? knownPayload,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.sendMessage.tr(),
    useAppBackgroundColor: true,
    body: (_, controller) => SendMessageSheet(
      origin: origin,
      sender: sender,
      recipient: recipient,
      amount: amount,
      bounce: bounce,
      comment: comment,
      knownPayload: knownPayload,
      controller: controller,
    ),
  );
}

/// Sheet that allows to prepare transfer from browser and return password
/// and selected public key.
class SendMessageSheet extends StatelessWidget {
  const SendMessageSheet({
    required this.origin,
    required this.sender,
    required this.recipient,
    required this.amount,
    required this.bounce,
    required this.comment,
    required this.knownPayload,
    required this.controller,
    super.key,
  });

  final Uri origin;
  final Address sender;
  final Address recipient;
  final BigInt amount;
  final bool bounce;
  final String? comment;
  final KnownPayload? knownPayload;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final transport = inject<NekotonRepository>().currentTransport;

    return BlocProvider<WalletPrepareTransferCubit>(
      create: (_) => WalletPrepareTransferCubit(
        address: sender,
        rootTokenContract: transport.nativeTokenAddress,
        tokenSymbol: transport.nativeTokenTicker,
        nekotonRepository: inject(),
        balanceService: inject(),
        assetsService: inject(),
      ),
      child:
          BlocBuilder<WalletPrepareTransferCubit, WalletPrepareTransferState>(
        builder: (context, state) {
          final custodians = state.when(
            subscribeError: (_) => null,
            loading: () => null,
            empty: () => null,
            data: (
              _,
              __,
              selectedCustodian,
              localCustodians,
              ___,
              ____,
            ) =>
                (selectedCustodian, localCustodians),
            goNext: (
              _,
              __,
              selectedCustodian,
              localCustodians,
              ___,
              ____,
              _____,
              ______,
              _______,
            ) =>
                (selectedCustodian, localCustodians),
          );
          final selected = custodians?.$1;
          final possible = custodians?.$2;

          return body(
            selected: selected,
            possible: possible,
          );
        },
      ),
    );
  }

  // ignore: long-method
  Widget body({
    required List<PublicKey>? possible,
    required PublicKey? selected,
  }) {
    final payload = knownPayload?.toRepresentableData();

    final data = LinkedHashMap.fromEntries([
      MapEntry(LocaleKeys.originWord.tr(), origin.host),
      MapEntry(LocaleKeys.addressWord.tr(), sender.address),
      if (possible != null && possible.length == 1)
        MapEntry(LocaleKeys.publicKey.tr(), possible.first.publicKey),
      MapEntry(LocaleKeys.recipientAddress.tr(), recipient.address),
      MapEntry(
        LocaleKeys.bounceWord.tr(),
        bounce ? LocaleKeys.yesWord.tr() : LocaleKeys.noWord.tr(),
      ),
    ]);

    return SingleChildScrollView(
      controller: controller,
      child: SeparatedColumn(
        separatorSize: DimensSize.d16,
        children: [
          ShapedContainerColumn(
            margin: EdgeInsets.zero,
            children: [
              if (possible != null && possible.length > 1)
                Builder(
                  builder: (context) {
                    return CommonSelectDropdown<PublicKey>(
                      values: possible
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
                      currentValue: selected,
                      onChanged: (custodian) => context
                          .read<WalletPrepareTransferCubit>()
                          .changeCustodian(custodian),
                    );
                  },
                ),

              // Pure data
              ...data.entries.map(
                (entry) => _itemBody(title: entry.key, subtitle: entry.value),
              ),
              _itemBody(
                title: LocaleKeys.amountWord.tr(),
                subtitleChild: MoneyWidget(
                  style: MoneyWidgetStyle.primary,
                  money: Money.fromBigIntWithCurrency(
                    amount,
                    Currencies()[inject<NekotonRepository>()
                        .currentTransport
                        .nativeTokenTicker]!,
                  ),
                ),
              ),

              // fee
              if (selected != null)
                BlocProvider<TonWalletSendBloc>(
                  key: ValueKey(selected),
                  create: (_) => TonWalletSendBloc(
                    destination: recipient,
                    amount: amount,
                    address: sender,
                    comment: comment,
                    publicKey: selected,
                    nekotonRepository: inject(),
                    currenciesService: inject(),
                    messengerService: inject(),
                    needRepack: false,
                    resultMessage: LocaleKeys.transactionSentSuccessfully.tr(),
                  )
                    ..repackedDestination = recipient
                    ..add(const TonWalletSendEvent.prepare()),
                  child: BlocBuilder<TonWalletSendBloc, TonWalletSendState>(
                    builder: (context, state) {
                      final (BigInt? fee, String? error) = state.maybeWhen(
                        calculatingError: (error, fee) => (fee, error),
                        readyToSend: (fee) => (fee, null),
                        orElse: () => (null, null),
                      );
                      final colors = context.themeStyle.colors;

                      return SeparatedColumn(
                        children: [
                          if (fee != null)
                            _itemBody(
                              title: LocaleKeys.feesWord.tr(),
                              subtitleChild: MoneyWidget(
                                style: MoneyWidgetStyle.primary,
                                money: Money.fromBigIntWithCurrency(
                                  fee,
                                  Currencies()[inject<NekotonRepository>()
                                      .currentTransport
                                      .nativeTokenTicker]!,
                                ),
                              ),
                            ),
                          if (error != null)
                            _itemBody(
                              title: LocaleKeys.feesWord.tr(),
                              subtitleChild: Text(
                                error,
                                style: StyleRes.addRegular
                                    .copyWith(color: colors.alert),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),

              // payload
              if (payload != null)
                SeparatedColumn(
                  children: [
                    _itemBody(
                      title: LocaleKeys.typeWord.tr(),
                      subtitle: payload.$1,
                    ),
                    ...payload.$2.map(
                      (v) => _itemBody(
                        title: v.title,
                        subtitle: v.content,
                        subtitleChild: v.contentChild,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Builder(
            builder: (context) {
              return SeparatedRow(
                children: [
                  Expanded(
                    child: CommonButton.ghost(
                      fillWidth: true,
                      text: LocaleKeys.rejectWord.tr(),
                      onPressed: Navigator.of(context).pop,
                    ),
                  ),
                  Expanded(
                    child: CommonButton.primary(
                      fillWidth: true,
                      text: LocaleKeys.submitWord.tr(),
                      onPressed: selected == null
                          ? null
                          : () => onSubmitPressed(context, selected),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> onSubmitPressed(
    BuildContext context,
    PublicKey publicKey,
  ) async {
    final password = await showCommonBottomSheet<String?>(
      context: context,
      title: LocaleKeys.enterPasswordTo.tr(args: [LocaleKeys.sendMessage.tr()]),
      useAppBackgroundColor: true,
      body: (_, __) => Builder(
        builder: (c) {
          return EnterPasswordWidget(
            onPasswordEntered: Navigator.of(c).pop,
            publicKey: publicKey,
          );
        },
      ),
    );
    if (password != null && context.mounted) {
      Navigator.of(context).pop((publicKey, password));
    }
  }

  Widget _itemBody({
    required String title,
    String? subtitle,
    Widget? subtitleChild,
  }) {
    return CommonListTile(
      height: null,
      subtitleMaxLines: null,
      invertTitleSubtitleStyles: true,
      titleText: title,
      subtitleText: subtitle,
      subtitleChild: subtitleChild,
      onPressed: subtitle == null
          ? null
          // ignore: prefer-extracting-callbacks
          : () {
              Clipboard.setData(ClipboardData(text: subtitle));
              inject<MessengerService>().show(
                Message.successful(
                  message: LocaleKeys.copiedExclamation.tr(),
                ),
              );
            },
    );
  }
}
