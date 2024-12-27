import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'token_wallet_details_cubit.freezed.dart';

part 'token_wallet_details_state.dart';

/// Cubit that allows loading balance for the [TokenWallet] (history loads
/// separately) in widget.
class TokenWalletDetailsCubit extends Cubit<TokenWalletDetailsState>
    with BlocBaseMixin {
  // ignore: long-method
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
      emitSafe(const TokenWalletDetailsState.empty());

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
      final walletState = wallets.firstWhereOrNull(
        (w) => w.owner == owner && w.rootTokenContract == rootTokenContract,
      );
      if (walletState != null) {
        _walletsSubscription?.cancel();

        if (walletState.hasError) {
          emitSafe(
            TokenWalletDetailsState.subscribeError(
              contractName: contractName,
              error: walletState.error!,
              isLoading: false,
            ),
          );
        } else {
          final wallet = walletState.wallet!;

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

          _checkLocalCustodians();
        }
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

  Future<void> retry() async {
    final st = state;
    if (st is _SubscribeError) {
      emitSafe(st.copyWith(isLoading: true));
      await nekotonRepository.retryTokenSubscription(owner, rootTokenContract);
      emitSafe(st.copyWith(isLoading: false));
    }
  }

  void _updateState() {
    if (isClosed) {
      return;
    }
    emitSafe(
      TokenWalletDetailsState.data(
        contractName: contractName,
        fiatBalance: _cachedFiatBalance,
        tokenBalance: _cachedTokenBalance,
        canSend: _canSend,
      ),
    );
  }

  Future<void> _checkLocalCustodians() async {
    try {
      final local = await nekotonRepository.getLocalCustodians(owner);
      _canSend = local != null && local.isNotEmpty;
    } finally {
      _updateState();
    }
  }
}
