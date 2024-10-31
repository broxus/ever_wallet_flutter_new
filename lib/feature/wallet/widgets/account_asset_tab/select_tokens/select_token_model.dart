import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class SelectTokenModel extends ElementaryModel {
  SelectTokenModel(
    ErrorHandler errorHandler,
    this.nekotonRepository,
    this.tokenWalletsService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository nekotonRepository;
  final TokenWalletsService tokenWalletsService;

  KeyAccount? getAccount(Address address) =>
      nekotonRepository.seedList.findAccountByAddress(address);

  Stream<SearchStreamValue> getAssets(Address address) =>
      tokenWalletsService.searchTokenWalletsForAddress(address);
}
