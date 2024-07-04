import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/app/router/routs/wallet/wallet.dart';
import 'package:app/app/service/currency_convert_service.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/token_contract_asset.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/qr_scanner/qr_scanner.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_balance_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_data.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page.dart';
import 'package:app/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/wallet_prepare_transfer_page_model.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Factory method for creating [WalletPrepareTransferPageWidgetModel]
WalletPrepareTransferPageWidgetModel
    defaultWalletPrepareTransferPageWidgetModelFactory(
  BuildContext context,
  Address address,
  Address? rootTokenContract,
) {
  return WalletPrepareTransferPageWidgetModel(
    WalletPrepareTransferPageModel(
      createPrimaryErrorHandler(context),
      address,
      rootTokenContract,
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

  late final _tokenSymbol = widget.tokenSymbol;

  final _assets = <(Address, String), WalletPrepareTransferAsset>{};

  WalletPrepareTransferAsset? _prevSelectedAsset;

  WalletPrepareTransferData? get _data => screenState.value.data;

  WalletPrepareTransferAsset? get _selectedAsset => _data?.selectedAsset;

  PublicKey? get _selectedCustodian => _data?.selectedCustodian;

  @protected
  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
    receiverController.addListener(
      () => receiverState.accept(receiverController.text),
    );

    screenState.addListener(() {
      if (_prevSelectedAsset?.rootTokenContract !=
          _selectedAsset?.rootTokenContract) {
        amountController.clear();
      }
      _prevSelectedAsset = _selectedAsset;
    });

    model.balanceDataStream.listen(_onUpdateBalanceData);
  }

  String? getSeedName(PublicKey custodian) => model.getSeedName(custodian);

  void onChangeAsset(WalletPrepareTransferAsset newAsset) {
    final asset = _assets[(newAsset.rootTokenContract, newAsset.tokenSymbol)];
    if (_selectedAsset?.rootTokenContract == newAsset.rootTokenContract &&
            _selectedAsset?.tokenSymbol == newAsset.tokenSymbol ||
        asset == null) {
      return;
    }

    _updateState(selectedAsset: asset);

    model.startListeningBalance(
      _assets[(widget.rootTokenContract, widget.tokenSymbol)],
    );
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

    if (!await validateAddress(addr)) {
      model.showError(LocaleKeys.addressIsWrong.tr());

      return;
    }

    final amnt = Fixed.parse(
      amountController.text.trim(),
      scale: _selectedAsset?.balance.scale,
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
          LocaleKeys.sendingNotEnoughBalanceToSend.tr(
            args: [
              comission.formatImproved(),
              comission.currency.code,
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
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      final addr = data.text!.trim();
      if (await validateAddress(Address(address: addr))) {
        receiverController.text = addr;
        receiverFocus.unfocus();
      } else {
        model.showError(LocaleKeys.addressIsWrong.tr());
      }
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

  void _goNext(Address receiveAddress, Fixed amount) {
    final selectedAsset = _selectedAsset;

    if (selectedAsset == null) {
      return;
    }

    final accountAddress = widget.address.address;
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

    context.goFurther(path);
  }

  Future<void> _init() async {
    final acc = model.findAccountByAddress(widget.address);
    if (acc == null) {
      screenState.content(null);
      return;
    }

    // If default contract not specified, then native is default and load
    // all existed assets
    final root = widget.rootTokenContract;

    if (root == null) {
      _createNativeContract();
      model.findExistedContracts(_onUpdateContractsForAccount);
    } else {
      final transport = model.currentTransport;
      // if default contract is specified, then lock it
      if (root == transport.nativeTokenAddress &&
          _tokenSymbol == transport.nativeTokenTicker) {
        _createNativeContract();
      } else {
        await _findSpecifiedContract(root);
      }
    }

    _updateState(
      walletName: model.getWalletName(acc),
      account: acc,
      selectedCustodian: acc.publicKey,
      localCustodians: await model.getLocalCustodiansAsync(
        widget.address,
      ),
      assets: _assets.values.toList(),
    );
  }

  void _createNativeContract() {
    final transport = model.currentTransport;
    final root = transport.nativeTokenAddress;
    final symbol = transport.nativeTokenTicker;

    final selectedAsset = WalletPrepareTransferAsset(
      rootTokenContract: root,
      isNative: true,
      balance: _zeroBalance(transport.nativeTokenTicker),
      tokenSymbol: transport.nativeTokenTicker,
      logoURI: transport.nativeTokenIcon,
      title: transport.nativeTokenTicker,
    );
    _assets[(root, symbol)] = selectedAsset;
    _updateState(selectedAsset: selectedAsset);

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
    _assets[(root, contract.symbol)] = selectedAsset;
    _updateState();

    model.startListeningBalance(selectedAsset);
  }

  void _updateState({
    String? walletName,
    KeyAccount? account,
    PublicKey? selectedCustodian,
    List<PublicKey>? localCustodians,
    WalletPrepareTransferAsset? selectedAsset,
    List<WalletPrepareTransferAsset>? assets,
  }) {
    screenState.content(
      _data?.copyWith(
        walletName: walletName,
        account: account,
        selectedCustodian: selectedCustodian,
        localCustodians: localCustodians,
        selectedAsset: selectedAsset,
        assets: assets,
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
        Money.fromBigIntWithCurrency(
          balance,
          Currencies()[symbol]!,
        ),
      );
    } else if (value is WalletPrepareTokenBalanceData) {
      root = value.root;
      symbol = value.symbol;
      final money = value.money;

      updated = _assets[(root, symbol)]?.copyWith(money);
    }

    if (updated == null || root == null || symbol == null) {
      return;
    }

    _assets[(root, symbol)] = updated;
    if (_selectedAsset?.rootTokenContract == root &&
        _selectedAsset?.tokenSymbol == symbol) {
      _updateState(selectedAsset: updated);
    }
  }

  void _onUpdateContractsForAccount(List<TokenContractAsset> contracts) {
    _assets.addEntries(
      contracts.map(
        (e) => MapEntry(
          (e.address, e.symbol),
          WalletPrepareTransferAsset(
            rootTokenContract: e.address,
            isNative: false,
            balance: _zeroBalance(e.symbol),
            tokenSymbol: e.symbol,
            logoURI: e.logoURI,
            title: e.name,
            version: e.version,
          ),
        ),
      ),
    );
    _updateState();
  }

  Money _zeroBalance(String symbol) {
    return Money.fromBigIntWithCurrency(
      BigInt.zero,
      Currencies()[symbol] ??
          Currency.create(
            symbol,
            0,
            pattern: moneyPattern(0),
          ),
    );
  }
}
