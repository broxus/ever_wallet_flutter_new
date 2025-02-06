// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'select_new_asset_cubit.freezed.dart';

part 'select_new_asset_state.dart';

enum SelectNewAssetTabs { select, custom }

/// Cubit that allows user select new assets(contracts) for account with
/// [address].
class SelectNewAssetCubit extends Cubit<SelectNewAssetState>
    with BlocBaseMixin {
  SelectNewAssetCubit({
    required this.address,
    required this.assetsService,
    required this.nekotonRepository,
  }) : super(
          const SelectNewAssetState.data(
            tab: SelectNewAssetTabs.select,
            isLoading: false,
            showButton: false,
          ),
        ) {
    _seedSubscription = nekotonRepository.seedListStream.listen((list) {
      _cachedAccount = list.findAccountByAddress(address);

      // ignore if we are in progress
      final st = state;
      if (st is _Data && !st.isLoading) _updateState();
    });
    _contractsSubscription = assetsService
        .allAvailableContractsForAccount(address)
        .listen((allContracts) {
      final manifestAssets =
          inject<AssetsService>().currentSystemTokenContractAssets;
      final mappedAssets = Map.fromEntries(
        manifestAssets.mapIndexed(
          (index, contract) => MapEntry(contract.address, index),
        ),
      );
      _originalContracts = [
        ...allContracts.$2.map((e) => (e, true)),
        ...allContracts.$1.map((e) => (e, false)),
      ]..sort((a, b) {
          final aIndex = mappedAssets[a.$1.address];
          final bIndex = mappedAssets[b.$1.address];

          // if index is null (asset is custom), move to the end
          if (aIndex == null) return 1;
          if (bIndex == null) return -1;

          // sort according to manifest list
          return aIndex.compareTo(bIndex);
        });

      // ignore if we are in progress
      final st = state;
      if (st is _Data && !st.isLoading) _updateState();
    });
  }

  final Address address;
  final AssetsService assetsService;
  final NekotonRepository nekotonRepository;

  late StreamSubscription<dynamic> _seedSubscription;
  late StreamSubscription<dynamic> _contractsSubscription;

  KeyAccount? _cachedAccount;

  /// Left - contract, right - if it is already enabled
  List<(TokenContractAsset, bool)> _originalContracts = [];

  /// List of contracts from [_originalContracts] that should be enabled or
  /// disabled when user decides to save changes
  final _contractsToDisable = <Address>[];
  final _contractsToEnable = <Address>[];

  void changeTab(SelectNewAssetTabs tab) {
    final st = state;
    if (st is _Data) {
      if (tab == st.tab) return;

      emitSafe(st.copyWith(tab: tab));
    }
  }

  Future<void> enableAsset(Address address) async {
    if (_originalEnabled(address)) {
      // original is enabled, so we came from toRemove state
      _contractsToDisable.remove(address);
    } else {
      // original is disabled, so we want add it
      _contractsToEnable.add(address);
    }
    _updateState();
  }

  Future<void> addCustom(BuildContext context, Address address) async {
    final isValid = validateAddress(address);
    final isToken = await assetsService.getTokenContractAsset(
      repackAddress(address),
      nekotonRepository.currentTransport,
    );
    if (isValid && isToken != null) {
      await _cachedAccount?.addTokenWallet(
        repackAddress(address),
      );
    } else {
      inject<MessengerService>().show(
        Message.error(
          context: context,
          message: LocaleKeys.invalidRootTokenContract.tr(),
        ),
      );
    }
  }

  /// Returns true, if contract was enabled in original, null if there is no
  /// such contract.
  bool _originalEnabled(Address address) =>
      _originalContracts.firstWhereOrNull((c) => c.$1.address == address)?.$2 ??
      false;

  /// Returns true, if contract was disabled in original, null if there is no
  /// such contract.
  bool _originalDisabled(Address address) => !(_originalContracts
          .firstWhereOrNull((c) => c.$1.address == address)
          ?.$2 ??
      true);

  void disableAsset(Address address) {
    if (_originalDisabled(address)) {
      // original is disabled, so we came from toAdd state
      _contractsToEnable.remove(address);
    } else {
      // original is enabled, so we want remove it
      _contractsToDisable.add(address);
    }
    _updateState();
  }

  Future<void> saveChanges() async {
    _updateState(true);
    if (_contractsToEnable.isNotEmpty) {
      await _cachedAccount?.addTokenWallets(_contractsToEnable);
    }
    if (_contractsToDisable.isNotEmpty) {
      await _cachedAccount?.removeTokenWallets(_contractsToDisable);
    }

    emitSafe(const SelectNewAssetState.completed());
  }

  void _updateState([bool isLoading = false]) {
    final st = state;
    if (st is _Data) {
      emitSafe(
        st.copyWith(
          isLoading: isLoading,
          account: _cachedAccount,
          contracts:
              _originalContracts.map((e) => (e.$1, _contractState(e))).toList(),
          showButton:
              _contractsToEnable.isNotEmpty || _contractsToDisable.isNotEmpty,
          tab: SelectNewAssetTabs.select,
        ),
      );
    }
  }

  bool _contractState((TokenContractAsset, bool) pair) {
    // original is enabled and we want disable it
    if (pair.$2 && _contractsToDisable.contains(pair.$1.address)) {
      return false;
    }
    // original is disabled and we want enable it
    if (!pair.$2 && _contractsToEnable.contains(pair.$1.address)) {
      return true;
    }

    // state didnt change locally, return original
    return pair.$2;
  }

  @override
  Future<void> close() {
    _seedSubscription.cancel();
    _contractsSubscription.cancel();

    return super.close();
  }
}
