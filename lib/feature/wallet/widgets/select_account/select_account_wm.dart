import 'package:app/app/router/router.dart';
import 'package:app/app/service/service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_data.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_model.dart';
import 'package:app/feature/wallet/widgets/select_account/select_account_widget.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

SelectAccountWidgetModel defaultSelectAccountWidgetModelFactory(
  BuildContext context,
) =>
    SelectAccountWidgetModel(
      SelectAccountModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
        inject(),
      ),
    );

class SelectAccountWidgetModel
    extends CustomWidgetModel<SelectAccountWidget, SelectAccountModel> {
  SelectAccountWidgetModel(super.model);

  late final searchController = createTextEditingController();
  late final _accounts = createNotifierFromStream(model.seedWithAccounts);
  late final _currentAccount = createNotifierFromStream(model.currentAccount);
  late final _list = createNotifier(_accounts.value);
  late final _zeroBalance = Money.fromBigIntWithCurrency(
    BigInt.zero,
    Currencies()[model.symbol] ??
        Currency.create(model.symbol, 0, pattern: moneyPattern(0)),
  );
  final _balances = <Address, ListenableState<Money>>{};

  ListenableState<List<SelectAccountData>> get list => _list;

  ListenableState<KeyAccount?> get currentAccount => _currentAccount;

  @override
  void initWidgetModel() {
    _accounts.addListener(onSearch);

    super.initWidgetModel();
  }

  void onSearch() {
    final value = searchController.value.text.trim().toLowerCase();

    if (value.isEmpty) {
      _list.accept(_accounts.value);
    } else {
      _list.accept(
        _accounts.value
            ?.map((selectAccountData) {
              final filteredPrivateKeys = selectAccountData.privateKeys
                  .map((keyInfo) {
                    final filteredAccounts = keyInfo.accounts.where(
                      (account) {
                        return account.name.toLowerCase().contains(value) ||
                            account.address.address
                                .toLowerCase()
                                .contains(value);
                      },
                    ).toList();

                    return SeedWithInfo(
                      keyName: keyInfo.keyName,
                      key: keyInfo.key,
                      accounts: filteredAccounts,
                    );
                  })
                  .where(
                    (keyInfo) => keyInfo.accounts.isNotEmpty,
                  )
                  .toList();
              return SelectAccountData(
                name: selectAccountData.name,
                privateKeys: filteredPrivateKeys,
              );
            })
            .where(
              (selectAccountData) => selectAccountData.privateKeys.isNotEmpty,
            )
            .toList(),
      );
    }
  }

  void onSelect(KeyAccount account) {
    model.changeCurrentAccount(account);
    Navigator.of(context).pop(account);
  }

  void onAddAccount() {
    Navigator.of(context).pop();
    contextSafe!.goFurther(
      AppRoute.walletAddAccount.path,
    );
  }

  void onManageSeedsAndAccounts() {
    Navigator.of(context).pop();
    context.goNamed(AppRoute.manageSeedsAccounts.name);
  }

  ListenableState<Money> getBalanceEntity(KeyAccount account) {
    var entity = _balances[account.address];

    if (entity == null) {
      final notifier = createNotifier<Money>();
      entity = _balances[account.address] = notifier;

      model.getBalance(account).then((value) {
        if (isMounted) {
          notifier.accept(value ?? _zeroBalance);
        }
      });
    }

    return entity;
  }
}
