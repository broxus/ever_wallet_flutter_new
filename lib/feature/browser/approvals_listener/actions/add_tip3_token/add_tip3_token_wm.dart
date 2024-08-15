import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_tip3_token/add_tip3_token_model.dart';
import 'package:app/feature/browser/approvals_listener/actions/add_tip3_token/add_tip3_token_widget.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

enum TokenStatus {
  trusted,
  untrasted,
  explicit,
  sameSymbol,
  suggestion,
}

AddTip3TokenWidgetModel defaultAddTip3TokenWidgetModelFactory(
  BuildContext context,
) =>
    AddTip3TokenWidgetModel(
      AddTip3TokenModel(
        createPrimaryErrorHandler(context),
        inject(),
        inject(),
      ),
    );

class AddTip3TokenWidgetModel
    extends CustomWidgetModel<AddTip3TokenWidget, AddTip3TokenModel> {
  AddTip3TokenWidgetModel(super.model);

  late final account = model.getAccount(widget.account);

  late final _balance = createNotifier<Money>();
  late final _asset = createNotifier<TokenContractAsset>();
  late final _status = createNotifier<TokenStatus>();
  StreamSubscription<dynamic>? _subscription;

  ListenableState<Money> get balance => _balance;

  ListenableState<TokenContractAsset> get asset => _asset;

  ListenableState<TokenStatus> get status => _status;

  ThemeStyleV2 get theme => context.themeStyleV2;

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _subscription =
        model.allAvailableContractsForAccount(widget.account).listen(_onData);

    _getBalance();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void onConfirm() => Navigator.of(context).pop(true);

  Future<void> _getBalance() async {
    final wallet = await model.getTokenWallet(
      owner: widget.account,
      rootTokenContract: widget.details.address,
    );

    _balance.accept(wallet?.wallet?.moneyBalance);
  }

  void _onData((List<TokenContractAsset>, List<TokenContractAsset>) value) {
    final (notAdded, added) = value;
    final assets = [...notAdded, ...added];
    final address = widget.details.address;
    final symbol = widget.details.symbol;
    final asset = assets.firstWhereOrNull((e) => e.address == address);

    _asset.accept(asset);

    if (asset?.isCustom == false) {
      // found trusted asset
      final hasCustom = added.any((e) => e.symbol == symbol && e.isCustom);

      if (hasCustom) {
        // has asset with the same symbol but it's custom
        _status.accept(TokenStatus.suggestion);
      } else {
        _status.accept(TokenStatus.trusted);
      }

      return;
    }

    final explicit = assets.any(
      (e) => e.symbol == symbol && !e.isCustom && e.address != address,
    );
    if (explicit) {
      // has trusted asset with the same symbol but different address
      _status.accept(TokenStatus.explicit);
      return;
    }

    final sameSymbol = added.any(
      (e) => e.symbol == symbol && e.address != address,
    );
    if (sameSymbol) {
      // has untrusted asset with the same symbol but different address
      _status.accept(TokenStatus.sameSymbol);
      return;
    }

    _status.accept(TokenStatus.untrasted);
  }
}
