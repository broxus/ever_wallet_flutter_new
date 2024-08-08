import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'token_wallet_send_bloc.freezed.dart';
part 'token_wallet_send_event.dart';
part 'token_wallet_send_state.dart';

/// Bloc that allows to prepare not native token from [TokenWallet] for
/// confirmation and sending transaction.
class TokenWalletSendBloc
    extends Bloc<TokenWalletSendEvent, TokenWalletSendState> {
  TokenWalletSendBloc({
    required this.nekotonRepository,
    required this.currenciesService,
    required this.messengerService,
    required this.assetsService,
    required this.owner,
    required this.rootTokenContract,
    required this.publicKey,
    required this.destination,
    required this.tokenAmount,
    required this.attachedAmount,
    required this.comment,
    required this.resultMessage,
  }) : super(const TokenWalletSendState.init()) {
    _registerHandlers();
  }

  final _logger = Logger('TokenWalletSendBloc');
  final NekotonRepository nekotonRepository;
  final CurrenciesService currenciesService;
  final MessengerService messengerService;
  final AssetsService assetsService;

  /// Address of account for token.
  final Address owner;

  /// Address of contract for token
  final Address rootTokenContract;

  /// Local custodian of account, that will be initiator of transaction (for not
  /// multisig this is main key).
  final PublicKey publicKey;

  /// Address where tokens must be sent
  final Address destination;
  late Address repackedDestination;

  /// How many tokens must be sent, to convert Fixed to BigInt, use
  /// [Fixed.minorUnits].
  final BigInt tokenAmount;
  late BigInt sendAmount;

  /// Attached amount in native tokens, that should be added to transaction.
  final BigInt? attachedAmount;

  /// Comment for transaction
  final String? comment;

  /// Message that will be shown when transaction completed
  final String resultMessage;

  /// Fee for transaction after calculating it in [_handlePrepare]
  BigInt? fees;

  late Currency tokenCurrency;
  TokenContractAsset? tokenAsset;

  KeyAccount? account;
  CustomCurrency? nativeCurrency;
  CustomCurrency? tokenCustomCurrency;

  late UnsignedMessage unsignedMessage;
  UnsignedMessage? _unsignedMessage;

  TransportStrategy get transport => nekotonRepository.currentTransport;

  Currency get currency => Currencies()[transport.nativeTokenTicker]!;

  void _registerHandlers() {
    on<_Prepare>((event, emit) => _handlePrepare(emit));
    on<_Send>((event, emit) => _handleSend(emit, event.password));
    on<_CompleteSend>(
      (event, emit) => emit(
        TokenWalletSendState.sent(fees!, event.transaction),
      ),
    );
    on<_AllowCloseSend>(
      (event, emit) => emit(const TokenWalletSendState.sending(canClose: true)),
    );
  }

  // ignore: long-method
  Future<void> _handlePrepare(Emitter<TokenWalletSendState> emit) async {
    try {
      account = nekotonRepository.seedList.findAccountByAddress(owner);
      nativeCurrency = currenciesService
          .currencies(transport.networkType)
          .firstWhereOrNull(
            (c) => c.address == transport.nativeTokenAddress,
      ) ?? await currenciesService.getCurrencyForNativeToken(transport);
      tokenCustomCurrency = currenciesService
          .currencies(transport.networkType)
          .firstWhereOrNull((c) => c.address == rootTokenContract)
          ?? await currenciesService.getCurrencyForContract(
            transport,
            rootTokenContract,
          );

      tokenAsset = await assetsService.getTokenContractAsset(
        rootTokenContract,
        transport,
      );

      final tokenWalletState = await nekotonRepository.tokenWalletsStream
          .expand((e) => e)
          .firstWhere(
            (wallet) =>
                wallet.owner == owner &&
                wallet.rootTokenContract == rootTokenContract,
          );

      if (tokenWalletState.hasError) {
        emit(TokenWalletSendState.subscribeError(tokenWalletState.error!));

        return;
      }

      final tokenWallet = tokenWalletState.wallet!;

      tokenCurrency = tokenWallet.currency;
      emit(const TokenWalletSendState.loading());

      final internalMessage = await nekotonRepository.prepareTokenTransfer(
        owner: owner,
        rootTokenContract: rootTokenContract,
        destination: await repackAddress(destination),
        amount: tokenAmount,
        payload: comment,
        attachedAmount: attachedAmount,
        notifyReceiver: true,
      );

      repackedDestination = internalMessage.destination;
      sendAmount = internalMessage.amount;
      unsignedMessage = await nekotonRepository.prepareTransfer(
        address: owner,
        publicKey: publicKey,
        destination: repackedDestination,
        amount: sendAmount,
        body: internalMessage.body,
        bounce: defaultMessageBounce,
        expiration: defaultSendTimeout,
      );
      _unsignedMessage = unsignedMessage;
      fees = await nekotonRepository.estimateFees(
        address: owner,
        message: unsignedMessage,
      );

      final walletState = await nekotonRepository.walletsStream
          .expand((e) => e)
          .firstWhere((wallets) => wallets.address == owner);

      if (walletState.hasError) {
        emit(TokenWalletSendState.subscribeError(tokenWalletState.error!));

        return;
      }

      final wallet = walletState.wallet!;
      final balance = wallet.contractState.balance;
      final isPossibleToSendMessage =
          balance > (fees! + internalMessage.amount);

      if (!isPossibleToSendMessage) {
        emit(
          TokenWalletSendState.calculatingError(
            LocaleKeys.insufficientFunds.tr(),
            fees,
          ),
        );

        return;
      }

      emit(TokenWalletSendState.readyToSend(fees!, sendAmount));
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TokenWalletSendState.calculatingError(e.message));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      emit(TokenWalletSendState.calculatingError(e.toString()));
    }
  }

  Future<void> _handleSend(
    Emitter<TokenWalletSendState> emit,
    String password,
  ) async {
    try {
      emit(const TokenWalletSendState.sending(canClose: false));
      await unsignedMessage.refreshTimeout();

      final hash = unsignedMessage.hash;
      final transport = nekotonRepository.currentTransport.transport;

      final signature = await nekotonRepository.seedList.sign(
        data: hash,
        publicKey: publicKey,
        password: password,
        signatureId: await transport.getSignatureId(),
      );

      final signedMessage = await unsignedMessage.sign(signature: signature);

      emit(const TokenWalletSendState.sending(canClose: true));

      final transaction = await nekotonRepository.send(
        address: owner,
        signedMessage: signedMessage,
        amount: sendAmount,
        destination: repackedDestination,
      );

      messengerService.show(Message.successful(message: resultMessage));
      if (!isClosed) {
        add(TokenWalletSendEvent.completeSend(transaction));
      }
    } on FfiException catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService.show(Message.error(message: e.message));
      emit(TokenWalletSendState.readyToSend(fees!, sendAmount));
    } on Exception catch (e, t) {
      _logger.severe('_handleSend', e, t);
      messengerService.show(Message.error(message: e.toString()));
      emit(TokenWalletSendState.readyToSend(fees!, sendAmount));
    }
  }

  @override
  Future<void> close() {
    _unsignedMessage?.dispose();

    return super.close();
  }
}
