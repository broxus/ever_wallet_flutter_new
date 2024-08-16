import 'dart:async';

import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class AccountListItemModel extends ElementaryModel {
  AccountListItemModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;

  Stream<Money> getBalanceStream(Address address) => _nekotonRepository
      .walletsStream
      .map((wallets) => wallets.firstWhereOrNull((w) => w.address == address))
      .mapNotNull((wallet) => wallet?.wallet?.contractState.balance)
      .map(
        (value) => Money.fromBigIntWithCurrency(
          value,
          Currencies()[_nekotonRepository.currentTransport.nativeTokenTicker]!,
        ),
      );
}
