import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_tip3_token/add_tip3_token_wm.dart';
import 'package:app/feature/browser/approvals_listener/actions/widgets/widgets.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddTip3TokenWidget extends ElementaryWidget<AddTip3TokenWidgetModel> {
  const AddTip3TokenWidget({
    required this.origin,
    required this.account,
    required this.details,
    required this.scrollController,
    Key? key,
    WidgetModelFactory wmFactory = defaultAddTip3TokenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final Uri origin;
  final Address account;
  final TokenContractAsset details;
  final ScrollController scrollController;

  @override
  Widget build(AddTip3TokenWidgetModel wm) {
    final theme = wm.theme;
    final labelStyle = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content3,
    );
    final textStyle = theme.textStyles.labelSmall.copyWith(
      color: theme.colors.content0,
    );
    final zeroBalance = Money.fromIntWithCurrency(
      0,
      Currency.create(details.symbol, 0),
    );

    return SeparatedColumn(
      separatorSize: DimensSizeV2.d12,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: SeparatedColumn(
              separatorSize: DimensSizeV2.d12,
              children: [
                if (wm.account != null)
                  AccountInfo(
                    account: wm.account!,
                    color: theme.colors.background2,
                  ),
                WebsiteInfoWidget(uri: origin),
                PrimaryCard(
                  color: theme.colors.background2,
                  borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
                  padding: const EdgeInsets.symmetric(
                    vertical: DimensSizeV2.d24,
                    horizontal: DimensSizeV2.d16,
                  ),
                  child: SeparatedColumn(
                    separatorSize: DimensSizeV2.d16,
                    children: [
                      _InfoRow(
                        hint: StateNotifierBuilder(
                          listenableState: wm.status,
                          builder: (_, v) => _StatusText(status: v),
                        ),
                        children: [
                          SeparatedRow(
                            separatorSize: DimensSizeV2.d4,
                            children: [
                              StateNotifierBuilder(
                                listenableState: wm.status,
                                builder: (_, v) => _StatusIcon(status: v),
                              ),
                              Text(LocaleKeys.nameWord.tr(), style: labelStyle),
                            ],
                          ),
                          Flexible(
                            child: SeparatedRow(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StateNotifierBuilder(
                                  listenableState: wm.asset,
                                  builder: (_, value) => value?.logoURI == null
                                      ? const SizedBox.shrink()
                                      : TonWalletIconWidget(
                                          path: value!.logoURI!,
                                          size: DimensSize.d20,
                                        ),
                                ),
                                Flexible(
                                  child: Text(
                                    details.name,
                                    style: textStyle,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      _InfoRow(
                        children: [
                          Text(LocaleKeys.symbolWord.tr(), style: labelStyle),
                          Flexible(
                            child: Text(
                              details.symbol,
                              style: textStyle,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      _InfoRow(
                        children: [
                          Text(LocaleKeys.decimalsWord.tr(), style: labelStyle),
                          Flexible(
                            child: Text(
                              details.decimals.toString(),
                              style: textStyle,
                            ),
                          ),
                        ],
                      ),
                      _InfoRow(
                        children: [
                          Text(
                            LocaleKeys.currentBalanceLabel.tr(),
                            style: labelStyle,
                          ),
                          Flexible(
                            child: StateNotifierBuilder(
                              listenableState: wm.balance,
                              builder: (_, value) => AmountWidget.fromMoney(
                                amount: value ?? zeroBalance,
                                style: textStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SeparatedColumn(
                        separatorSize: DimensSizeV2.d2,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(LocaleKeys.symbolWord.tr(), style: labelStyle),
                          Text(details.address.address, style: textStyle),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        AccentButton(
          buttonShape: ButtonShape.pill,
          title: LocaleKeys.addWord.tr(),
          onPressed: wm.onConfirm,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.children,
    this.hint,
  });

  final List<Widget> children;
  final Widget? hint;

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: DimensSize.d40),
        child: hint == null
            ? SeparatedRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              )
            : SeparatedColumn(
                separatorSize: DimensSizeV2.d12,
                children: [
                  SeparatedRow(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: children,
                  ),
                  hint!,
                ],
              ),
      );
}

class _StatusIcon extends StatelessWidget {
  const _StatusIcon({
    required this.status,
  });

  final TokenStatus? status;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyleV2.colors;

    return switch (status) {
      TokenStatus.trusted => Icon(
          LucideIcons.shieldCheck,
          size: DimensSize.d20,
          color: colors.contentPositive,
        ),
      TokenStatus.untrasted || TokenStatus.suggestion => Icon(
          LucideIcons.shieldOff,
          size: DimensSize.d20,
          color: colors.contentWarning,
        ),
      TokenStatus.explicit || TokenStatus.sameSymbol => Icon(
          LucideIcons.shieldAlert,
          size: DimensSize.d20,
          color: colors.contentNegative,
        ),
      null => const SizedBox.shrink(),
    };
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({
    required this.status,
  });

  final TokenStatus? status;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return switch (status) {
      TokenStatus.untrasted => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundWarning,
          child: Text(
            LocaleKeys.untrastedTokenWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentWarning,
            ),
          ),
        ),
      TokenStatus.suggestion => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundWarning,
          child: Text(
            LocaleKeys.phishingSuggestionWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentWarning,
            ),
          ),
        ),
      TokenStatus.explicit => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundNegative,
          child: Text(
            LocaleKeys.phishingExplicitWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentNegative,
            ),
          ),
        ),
      TokenStatus.sameSymbol => PrimaryCard(
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          borderRadius: BorderRadius.circular(DimensRadiusV2.radius12),
          color: theme.colors.backgroundNegative,
          child: Text(
            LocaleKeys.phishingSameSymbolWarning.tr(),
            style: theme.textStyles.labelSmall.copyWith(
              color: theme.colors.contentNegative,
            ),
          ),
        ),
      TokenStatus.trusted || null => const SizedBox.shrink(),
    };
  }
}
