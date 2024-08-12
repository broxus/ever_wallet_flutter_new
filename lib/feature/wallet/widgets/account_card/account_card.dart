import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:app/feature/wallet/wallet.dart';
import 'package:app/feature/wallet/widgets/account_card/account_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Card widget that displays information about account.
class AccountCard extends StatelessWidget {
  const AccountCard({
    required this.account,
    required this.height,
    super.key,
  });

  final KeyAccount account;

  /// Height of card, just to sync with 'AddNewAccountCard'
  final double height;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountCardCubit(
        nekotonRepository: inject<NekotonRepository>(),
        account: account,
        balanceService: inject<BalanceService>(),
        currencyConvertService: inject<CurrencyConvertService>(),
        balanceStorage: inject(),
      ),
      child: BlocBuilder<AccountCardCubit, AccountCardState>(
        builder: (context, state) {
          return state.when<Widget>(
            subscribeError: (account, walletName, error, isLoading) => _body(
              walletName: walletName,
              error: error,
              isErrorLoading: isLoading,
            ),
            data: (account, walletName, balance, custodians) => _body(
              walletName: walletName,
              balance: balance,
              custodians: custodians,
            ),
          );
        },
      ),
    );
  }

  Widget _balanceLoader() {
    return SeparatedRow(
      separatorSize: DimensSize.d4,
      mainAxisSize: MainAxisSize.min,
      children: const [
        CommonLoader(
          width: DimensSize.d132,
          height: DimensSize.d48,
        ),
        CommonLoader(
          width: DimensSize.d32,
          height: DimensSize.d20,
        ),
      ],
    );
  }

  Widget _addressTile() {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return CommonListTile(
          height: DimensSize.d64,
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
            vertical: DimensSize.d8,
          ),
          contentColor: colors.blue,
          titleChild: Text(
            LocaleKeys.addressWord.tr(),
            style: StyleRes.addRegular.copyWith(color: colors.blueSecond),
          ),
          subtitleChild: Text(
            account.address.toEllipseString(),
            style: StyleRes.addBold.copyWith(color: colors.blue),
          ),
          trailing: CommonIconWidget.svg(svg: Assets.images.copy.path),
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: account.address.address),
            );
            inject<MessengerService>().show(
              Message.successful(
                message: LocaleKeys.valueCopiedExclamation.tr(
                  args: [account.address.toEllipseString()],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ignore: long-method
  Widget _walletDescriptionTile(String walletName, String? custodians) {
    return Builder(
      builder: (context) {
        final colors = context.themeStyle.colors;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                      horizontal: DimensSize.d16,
                    ) +
                    const EdgeInsets.only(top: DimensSize.d16),
                child: SeparatedColumn(
                  separatorSize: DimensSize.d4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      style:
                          StyleRes.button.copyWith(color: colors.textPrimary),
                    ),
                    SeparatedRow(
                      separatorSize: DimensSize.d4,
                      children: [
                        CommonIconWidget.svg(
                          svg: Assets.images.accountType.path,
                          color: colors.textSecondary,
                        ),
                        Text(
                          walletName,
                          style: StyleRes.addRegular.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                        if (custodians != null) ...[
                          const SizedBox(width: DimensSize.d12),
                          CommonIconWidget.svg(
                            svg: Assets.images.persons.path,
                            color: colors.textSecondary,
                          ),
                          const SizedBox(width: DimensSize.d4),
                          Text(
                            custodians,
                            style: StyleRes.addRegular
                                .copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(DimensSize.d4),
              child: CommonIconButton.svg(
                svg: Assets.images.settings.path,
                buttonType: EverButtonType.ghost,
                color: colors.textSecondary,
                size: CommonIconButtonSize.small,
                onPressed: () => showAccountSettingsSheet(
                  context: context,
                  address: account.address,
                  showHiding: false,
                  seeInExplorer: true,
                  showCopyAddress: true,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _body({
    required String walletName,
    String? custodians,
    Money? balance,
    Object? error,
    bool isErrorLoading = false,
  }) {
    return ShapedContainerColumn(
      squircleRadius: DimensRadius.large,
      height: height,
      width: double.infinity,
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      separator: const CommonDivider(),
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _walletDescriptionTile(walletName, custodians),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimensSize.d16,
                  ),
                  child: Center(
                    child: error != null
                        ? WalletSubscribeErrorWidget(
                            error: error,
                            isLoadingError: isErrorLoading,
                            onRetryPressed: (context) =>
                                context.read<AccountCardCubit>().retry(),
                          )
                        : balance == null
                            ? _balanceLoader()
                            : MoneyWidget(
                                money: balance,
                                style: MoneyWidgetStyle.big,
                              ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _addressTile(),
      ],
    );
  }
}
