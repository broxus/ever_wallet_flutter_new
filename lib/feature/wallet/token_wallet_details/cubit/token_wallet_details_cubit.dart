import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_wallet_details_state.dart';

part 'token_wallet_details_cubit.freezed.dart';

/// Cubit that allows loading balance for the [TokenWallet] (history loads
/// separately) in widget.
class TokenWalletDetailsCubit extends Cubit<TokenWalletDetailsState> {
  TokenWalletDetailsCubit({
    required this.nekotonRepository,
    required this.rootTokenContract,
    required this.owner,
    required this.currencyConvertService,
    required this.balanceService,
    required this.assetsService,
  }) : super(const TokenWalletDetailsState.initial()) {
    final acc = nekotonRepository.seedList.findAccountByAddress(owner);
    if (acc == null) {
      emit(const TokenWalletDetailsState.empty());

      return;
    }

    account = acc;
    _cachedFiatBalance = currencyConvertService.convert(Fixed.zero);

    final contract = assetsService.maybeGetTokenContract(
      rootTokenContract,
      nekotonRepository.currentTransport,
    );
    _cachedTokenBalance = Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currency.create(contract?.symbol ?? '?', 0),
    );
    contractName = contract?.name ?? '';

    _updateState();

    _walletsSubscription =
        nekotonRepository.tokenWalletsStream.listen((wallets) {
      final wallet = wallets.firstWhereOrNull(
        (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
      );
      if (wallet != null) {
        final local = nekotonRepository.localCustodians(owner);
        _canSend = local != null && local.isNotEmpty;

        _walletsSubscription?.cancel();

        _thisWalletSubscription = wallet.fieldUpdatesStream.listen((_) {
          _cachedTokenBalance = wallet.moneyBalance;

          _updateState();
        });
        _balanceSubscription = balanceService
            .tokenWalletBalanceStream(
          owner: owner,
          rootTokenContract: rootTokenContract,
        )
            .listen((balance) {
          _cachedFiatBalance = currencyConvertService.convert(balance);

          _updateState();
        });
      }
    });
  }

  final Address rootTokenContract;
  final Address owner;
  final AssetsService assetsService;
  final CurrencyConvertService currencyConvertService;
  final BalanceService balanceService;
  final NekotonRepository nekotonRepository;
  late KeyAccount account;

  StreamSubscription<dynamic>? _walletsSubscription;
  StreamSubscription<dynamic>? _thisWalletSubscription;
  StreamSubscription<dynamic>? _balanceSubscription;

  late Money _cachedFiatBalance;
  late Money _cachedTokenBalance;
  String contractName = '';
  bool _canSend = false;

  @override
  Future<void> close() {
    _walletsSubscription?.cancel();
    _thisWalletSubscription?.cancel();
    _balanceSubscription?.cancel();

    return super.close();
  }

  void _updateState() {
    emit(
      TokenWalletDetailsState.data(
        contractName: contractName,
        account: account,
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
        canSend: _canSend,
      ),
    );
  }
}