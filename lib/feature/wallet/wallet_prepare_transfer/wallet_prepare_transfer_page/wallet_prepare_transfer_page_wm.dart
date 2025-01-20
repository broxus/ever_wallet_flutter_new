// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/wallet/wallet.dart';
import 'package:app/app/service/currency_convert_service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract/token_contract_asset.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_balance_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page_model.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [WalletPrepareTransferPageWidgetModel]
WalletPrepareTransferPageWidgetModel
    defaultWalletPrepareTransferPageWidgetModelFactory(
  BuildContext context,
  Address address,
  Address? rootTokenContract,
  String? tokenSymbol,
) {
  return WalletPrepareTransferPageWidgetModel(
    WalletPrepareTransferPageModel(
      createPrimaryErrorHandler(context),
      address,
      rootTokenContract,
      tokenSymbol,
      inject(),
      inject(),
      inject(),
      inject(),
    ),
  );
}

/// [WidgetModel] для [WalletPrepareTransferPage]
class WalletPrepareTransferPageWidgetModel extends CustomWidgetModel<
    WalletPrepareTransferPage, WalletPrepareTransferPageModel> {
  WalletPrepareTransferPageWidgetModel(
    super.model,
  );

  late final screenState = createEntityNotifier<WalletPrepareTransferData?>()
    ..loading(
      WalletPrepareTransferData(),
    );

  late final receiverState = createNotifier<String?>();
  late final commentTextState = createNotifier<String?>();
  late final commentState = createNotifier(false);

  final formKey = GlobalKey<FormState>();

  late final receiverController = createTextEditingController();
  late final receiverFocus = createFocusNode();

  late final amountController = createTextEditingController();
  late final amountFocus = createFocusNode();

  late final commentController = createTextEditingController();
  late final commentFocus = createFocusNode();

  final addressFilterFormatter = FilteringTextInputFormatter.deny(
    RegExp(r'\s'),
  );

  final _assets = <(Address, String), WalletPrepareTransferAsset>{};
  late final _assetsList = createValueNotifier(_assets.values.toList());

  StreamSubscription<dynamic>? _currencySubscription;

  WalletPrepareTransferData? get _data => screenState.value.data;

  WalletPrepareTransferAsset? get _selectedAsset => _data?.selectedAsset;

  PublicKey? get _selectedCustodian => _data?.selectedCustodian;

  ValueListenable<List<WalletPrepareTransferAsset>> get assets => _assetsList;

  Address get address => model.address;

  @protected
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
    _initListeners();
  }

  @override
  void dispose() {
    _currencySubscription?.cancel();
    super.dispose();
  }

  String? getSeedName(PublicKey custodian) => model.getSeedName(custodian);

  void onChangeAsset(AmountInputAsset newAsset) {
    final asset = _assets[newAsset.key];
    if (_selectedAsset?.rootTokenContract == newAsset.rootTokenContract &&
            _selectedAsset?.tokenSymbol == newAsset.tokenSymbol ||
        asset == null) {
      return;
    }

    _updateState(selectedAsset: asset);
    unawaited(_updateAsset(asset));

    model.startListeningBalance(_assets[asset.key]);
  }

  void onChangedCustodian(PublicKey custodian) {
    if (_data?.selectedCustodian == custodian) {
      return;
    }

    _updateState(selectedCustodian: custodian);
  }

  Future<void> onPressedNext() async {
    final isValidate = formKey.currentState?.validate() ?? false;

    if (!isValidate) {
      return;
    }

    final addr = Address(
      address: receiverController.text.trim(),
    );

    if (!validateAddress(addr)) {
      model.showError(context, LocaleKeys.addressIsWrong.tr());

      return;
    }

    final amnt = Fixed.parse(
      amountController.text.trim().replaceAll(',', '.'),
      scale: _selectedAsset?.balance.decimalDigits,
    );

    _goNext(addr, amnt);
  }

  void setMaxBalance() {
    final asset = _selectedAsset;
    var available = asset?.balance;

    if (asset == null || available == null) {
      return;
    }

    if (asset.isNative) {
      // subtract approximate comission
      final comission = Money.fromFixedWithCurrency(
        Fixed.fromNum(0.1),
        available.currency,
      );
      final amountMinusComission = available - comission;
      if (amountMinusComission.amount < Fixed.zero) {
        model.showError(
          context,
          LocaleKeys.sendingNotEnoughBalanceToSend.tr(
            args: [
              comission.formatImproved(),
              comission.currency.isoCode,
            ],
          ),
        );
        return;
      } else {
        available = amountMinusComission;
      }
    }

    amountController.text = available.formatImproved();
  }

  void onPressedReceiverClear() => receiverController.clear();

  Future<void> onPressedPastAddress() async {
    final text = await getClipBoardText();
    if (text?.isEmpty ?? true) {
      model.showError(context, LocaleKeys.addressIsWrong.tr());
      return;
    }

    if (validateAddress(Address(address: text!))) {
      receiverController.text = text;
      receiverFocus.unfocus();
    } else {
      model.showError(context, LocaleKeys.addressIsWrong.tr());
    }
  }

  Future<void> onPressedScan() async {
    final address = await showQrScanner(context, QrScanType.address);
    if (address != null) {
      receiverController.text = address;
    }
  }

  void onSubmittedReceiverAddress(_) => amountFocus.requestFocus();

  void onSubmittedAmountWord(_) => commentFocus.requestFocus();

  String? validateAddressField(String? value) {
    if (value?.isEmpty ?? true) {
      return LocaleKeys.addressIsEmpty.tr();
    }
    if (_selectedAsset?.isNative != true && model.address.address == value) {
      return LocaleKeys.invalidReceiverAddress.tr();
    }
    return null;
  }

  void onPressedCleanComment() {
    commentController.clear();
  }

  Future<void> _init() async {
    final acc = model.findAccountByAddress(model.address);
    if (acc == null) {
      screenState.content(null);
      return;
    }

    _updateState(
      walletName: model.getWalletName(acc),
      account: acc,
    );

    // If default contract not specified, then native is default and load
    // all existed assets
    final root = model.rootTokenContract;

    _createNativeContract();
    model.findExistedContracts(_onUpdateContractsForAccount);

    if (root != null && model.tokenSymbol != _selectedAsset?.tokenSymbol) {
      unawaited(_findSpecifiedContract(root));
    }

    _updateState(
      walletName: model.getWalletName(acc),
      account: acc,
      selectedCustodian: acc.publicKey,
      localCustodians: await model.getLocalCustodiansAsync(model.address),
    );
  }

  void _initListeners() {
    receiverController.addListener(
      () => receiverState.accept(receiverController.text),
    );
    commentController.addListener(
      () => commentTextState.accept(commentController.text),
    );

    WalletPrepareTransferAsset? prevSelectedAsset;

    screenState.addListener(() {
      if (prevSelectedAsset?.rootTokenContract !=
          _selectedAsset?.rootTokenContract) {
        amountController.clear();
      }
      prevSelectedAsset = _selectedAsset;
    });

    model.balanceDataStream.listen(_onUpdateBalanceData);
  }

  void _goNext(Address receiveAddress, Fixed amount) {
    final selectedAsset = _selectedAsset;

    if (selectedAsset == null) {
      return;
    }

    final accountAddress = model.address.address;
    final publicKey = _selectedCustodian?.publicKey;

    final comment = commentController.text.trim();

    String? path;

    if (selectedAsset.isNative) {
      path = AppRoute.tonWalletSend.pathWithData(
        queryParameters: {
          tonWalletSendAddressQueryParam: accountAddress,
          if (publicKey != null) tonWalletSendPublicKeyQueryParam: publicKey,
          if (comment.isNotEmpty) tonWalletSendCommentQueryParam: comment,
          tonWalletSendDestinationQueryParam: receiveAddress.address,
          tonWalletSendAmountQueryParam: amount.minorUnits.toString(),
        },
      );
    } else {
      path = AppRoute.tokenWalletSend.pathWithData(
        queryParameters: {
          tokenWalletSendOwnerQueryParam: accountAddress,
          tokenWalletSendContractQueryParam:
              selectedAsset.rootTokenContract.address,
          if (publicKey != null) tokenWalletSendPublicKeyQueryParam: publicKey,
          if (comment.isNotEmpty) tokenWalletSendCommentQueryParam: comment,
          tokenWalletSendDestinationQueryParam: receiveAddress.address,
          tokenWalletSendAmountQueryParam: amount.minorUnits.toString(),
        },
      );
    }

    contextSafe?.goFurther(path);
  }

  Future<void> _updateAsset(WalletPrepareTransferAsset asset) async {
    final currency = asset.currency ??
        await model.getCurrencyForContract(
          asset.rootTokenContract,
        );
    final balance =
        await model.getBalance(asset) ?? _zeroBalance(asset.tokenSymbol);

    final updatedAsset = asset.copyWith(
      currency: currency,
      balance: balance,
    );

    _updateAssets((assets) => assets[updatedAsset.key] = updatedAsset);

    if (updatedAsset.key == _selectedAsset?.key) {
      _updateState(selectedAsset: updatedAsset);
    }
  }

  void _createNativeContract() {
    final transport = model.currentTransport;
    final root = transport.nativeTokenAddress;

    final selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: root,
      isNative: true,
      balance: _zeroBalance(transport.nativeTokenTicker),
      tokenSymbol: transport.nativeTokenTicker,
      logoURI: transport.nativeTokenIcon,
      title: transport.nativeTokenTicker,
    );

    _updateAssets((assets) => assets[selectedAsset.key] = selectedAsset);
    _updateState(selectedAsset: selectedAsset);
    unawaited(_updateAsset(selectedAsset));
    model.startListeningBalance(selectedAsset);
  }

  Future<void> _findSpecifiedContract(Address root) async {
    final contract = await model.getTokenContractAsset(root);

    if (contract == null) {
      screenState.content(null);

      return;
    }

    final selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: contract.address,
      isNative: false,
      balance: _zeroBalance(contract.symbol),
      logoURI: contract.logoURI,
      tokenSymbol: contract.symbol,
      title: contract.name,
      version: contract.version,
    );

    _updateAssets((assets) => assets[selectedAsset.key] = selectedAsset);
    _updateState(selectedAsset: selectedAsset);
    unawaited(_updateAsset(selectedAsset));
    model.startListeningBalance(selectedAsset);
  }

  void _updateState({
    String? walletName,
    KeyAccount? account,
    PublicKey? selectedCustodian,
    List<PublicKey>? localCustodians,
    WalletPrepareTransferAsset? selectedAsset,
  }) {
    screenState.content(
      _data?.copyWith(
        walletName: walletName,
        account: account,
        selectedCustodian: selectedCustodian,
        localCustodians: localCustodians,
        selectedAsset: selectedAsset,
      ),
    );
  }

  void _onUpdateBalanceData(WalletPrepareBalanceData value) {
    if (value is WalletPrepareErrorBalanceData) {
      screenState.error(value.error);
      return;
    }

    WalletPrepareTransferAsset? updated;
    Address? root;
    String? symbol;

    if (value is WalletPrepareNativeBalanceData) {
      root = value.root;
      symbol = value.symbol;
      final balance = value.balance;

      updated = _assets[(root, symbol)]?.copyWith(
        balance: Money.fromBigIntWithCurrency(
          balance,
          Currencies()[symbol]!,
        ),
      );
    } else if (value is WalletPrepareTokenBalanceData) {
      root = value.root;
      symbol = value.symbol;
      final money = value.money;

      updated = _assets[(root, symbol)]?.copyWith(balance: money);
    }

    if (updated == null || root == null || symbol == null) {
      return;
    }

    _updateAssets((assets) => assets[(root!, symbol!)] = updated!);

    if (_selectedAsset?.rootTokenContract == root &&
        _selectedAsset?.tokenSymbol == symbol) {
      _updateState(selectedAsset: updated);
    }
  }

  void _onUpdateContractsForAccount(List<TokenContractAsset> contracts) {
    final assets = contracts.map(
      (e) => WalletPrepareTransferAsset(
        rootTokenContract: e.address,
        isNative: false,
        balance: _zeroBalance(e.symbol),
        tokenSymbol: e.symbol,
        logoURI: e.logoURI,
        title: e.name,
        version: e.version,
      ),
    );
    final entries = assets.map((asset) => MapEntry(asset.key, asset));

    _updateAssets((assets) => assets.addEntries(entries));

    for (final asset in assets) {
      _updateAsset(asset);
    }

    _updateState();
  }

  void _updateAssets(
    void Function(Map<(Address, String), WalletPrepareTransferAsset> aseets)
        updater,
  ) {
    updater(_assets);
    _assetsList.value = _assets.values.toList();
  }

  Money _zeroBalance(String symbol) {
    return Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[symbol] ??
          Currency.create(
            symbol,
            0,
            symbol: symbol,
            pattern: moneyPattern(0),
          ),
    );
  }
}
