import 'package:app/app/service/service.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class AccountSettingsModel extends ElementaryModel {
  AccountSettingsModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._messengerService,
    this._currentAccountsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final MessengerService _messengerService;
  final CurrentAccountsService _currentAccountsService;

  Stream<List<KeyAccount>> get displayAccounts =>
      _currentAccountsService.currentAccountsStream.map(
        (list) => list?.displayAccounts ?? [],
      );

  String getAccountExplorerLink(Address address) =>
      _nekotonRepository.currentTransport.accountExplorerLink(address);

  void copyAddress(BuildContext context, Address address) {
    Clipboard.setData(
      ClipboardData(text: address.address),
    );

    _messengerService.show(
      Message.successful(
        context: context,
        message: LocaleKeys.valueCopiedExclamation.tr(
          args: [address.toEllipseString()],
        ),
      ),
    );
  }

  void hideAccount(Address address) {
    final account = _nekotonRepository.seedList.findAccountByAddress(address);
    final nextAccount = _currentAccountsService.currentAccounts?.displayAccounts
        .firstWhereOrNull((item) => item.address != address);

    if (account != null && nextAccount != null) {
      account.hide();
      _currentAccountsService.updateCurrentActiveAccount(nextAccount.address);
    }
  }
}
