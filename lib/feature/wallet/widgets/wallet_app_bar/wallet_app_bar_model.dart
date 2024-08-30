import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:collection/collection.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:rxdart/rxdart.dart';

class WalletAppBarModel extends ElementaryModel {
  WalletAppBarModel(
    ErrorHandler errorHandler,
    this._nekotonRepository,
    this._currentAccountsService,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final NekotonRepository _nekotonRepository;
  final CurrentAccountsService _currentAccountsService;
  final ConnectionsStorageService _storageService;

  Stream<KeyAccount?> get currentAccount =>
      _currentAccountsService.currentActiveAccountStream.map(
        (value) => value?.$2,
      );

  Stream<TonWalletState?> get walletState => CombineLatestStream.combine2(
        _nekotonRepository.walletsStream,
        currentAccount,
        (wallets, account) => wallets.firstWhereOrNull(
          (w) => w.address == account?.address,
        ),
      );

  Stream<ConnectionData?> get connection => CombineLatestStream.combine2(
        _storageService.currentConnectionIdStream,
        _storageService.connectionsStream,
        (id, connections) => connections.firstWhereOrNull(
          (item) => item.id == id,
        ),
      );
}
