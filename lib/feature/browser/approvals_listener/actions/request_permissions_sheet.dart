import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:app/v2/feature/wallet/widgets/account_card/account_card_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function that allows show sheet to request permissions for browser
/// tab to interact with accounts.
Future<Permissions?> showRequestPermissionsSheet({
  required BuildContext context,
  required Uri origin,
  required List<Permission> permissions,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.selectAccount.tr(),
    body: (_, scrollController) => RequestPermissionsSheet(
      origin: origin,
      permissions: permissions,
      scrollController: scrollController,
      previousSelectedAccount: null,
    ),
  );
}

/// Helper function that allows show sheet to change account for browser.
/// This is same as [showRequestPermissionsSheet] but with different title.
Future<Permissions?> showChangeAccountSheet({
  required BuildContext context,
  required Uri origin,
  required List<Permission> permissions,
  required Address? previousSelectedAccount,
}) {
  return showCommonBottomSheet(
    context: context,
    title: LocaleKeys.changeAccount.tr(),
    body: (_, scrollController) => RequestPermissionsSheet(
      origin: origin,
      permissions: permissions,
      scrollController: scrollController,
      previousSelectedAccount: previousSelectedAccount,
    ),
  );
}

/// Sheet that allows choose account that should be used for browser tab with
/// url=[origin].
/// This sheet firstly asks to choose account and then opens
/// [GrantPermissionsSheet] to allow permissions for this account.
class RequestPermissionsSheet extends StatefulWidget {
  const RequestPermissionsSheet({
    required this.origin,
    required this.permissions,
    required this.scrollController,
    required this.previousSelectedAccount,
    super.key,
  });

  final Uri origin;
  final List<Permission> permissions;
  final ScrollController scrollController;
  final Address? previousSelectedAccount;

  @override
  State<RequestPermissionsSheet> createState() =>
      _RequestPermissionsSheetState();
}

class _RequestPermissionsSheetState extends State<RequestPermissionsSheet> {
  late List<KeyAccount> possibleAccounts =
      inject<CurrentAccountsService>().currentAccounts?.allAccounts ?? [];

  // theoretically, there could be empty list if they were not created for key
  late final selectedAccount = ValueNotifier<KeyAccount?>(
    possibleAccounts.firstWhereOrNull(
          (a) => a.address == widget.previousSelectedAccount,
        ) ??
        possibleAccounts.firstOrNull,
  );

  @override
  void dispose() {
    selectedAccount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<KeyAccount?>(
      valueListenable: selectedAccount,
      builder: (context, v, __) {
        return SeparatedColumn(
          separatorSize: DimensSize.d16,
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: SeparatedColumn(
                  children: possibleAccounts.map(_accountItem).toList(),
                ),
              ),
            ),
            CommonButton.primary(
              fillWidth: true,
              text: LocaleKeys.selectWord.tr(),
              onPressed: v == null
                  ? null
                  : () async {
                      final permissions = await showGrantPermissionsSheet(
                        context: context,
                        origin: widget.origin,
                        permissions: widget.permissions,
                        account: v,
                      );
                      if (permissions != null && context.mounted) {
                        Navigator.of(context).pop(permissions);
                      }
                    },
            ),
          ],
        );
      },
    );
  }

  Widget _accountItem(KeyAccount account) {
    return BlocProvider(
      create: (_) => AccountCardCubit(
        balanceStorage: inject(),
        account: account,
        currencyConvertService: inject(),
        nekotonRepository: inject(),
        balanceService: inject(),
      ),
      child: BlocBuilder<AccountCardCubit, AccountCardState>(
        builder: (context, state) {
          final balance = state.when(
            data: (_, __, balance, ___) => balance,
            subscribeError: (_, __, ___, ____) => null,
          );

          return CommonListTile(
            onPressed: () => selectedAccount.value = account,
            titleText: state.walletName,
            leading: CommonBackgroundedIconWidget.svg(
              svg: Assets.images.person.path,
            ),
            trailing: account == selectedAccount.value
                ? CommonIconWidget.svg(
                    svg: Assets.images.check.path,
                    color: context.themeStyle.colors.textPrimary,
                  )
                : null,
            subtitleText: LocaleKeys.accountAddressWithData.tr(
              args: [
                account.address.toEllipseString(),
                balance?.formatImproved(
                      pattern: moneyPatternWithSymbol(balance.scale),
                    ) ??
                    '',
              ],
            ),
          );
        },
      ),
    );
  }
}
