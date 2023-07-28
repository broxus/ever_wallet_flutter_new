import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

part 'select_new_asset_state.dart';

part 'select_new_asset_cubit.freezed.dart';

enum SelectNewAssetTabs { select, custom }

/// Cubit that allows user select new assets(contracts) for account with
/// [address].
class SelectNewAssetCubit extends Cubit<SelectNewAssetState> {
  SelectNewAssetCubit({
    required this.address,
    required this.assetsService,
    required this.nekotonRepository,
  }) : super(const SelectNewAssetState.data(tab: SelectNewAssetTabs.select)) {
    _seedSubscription = nekotonRepository.seedListStream.listen((list) {
      _cachedAccount = list.findAccountByAddress(address);
      _updateState();
    });
    _contractsSubscription = assetsService
        .allAvailableContractsForAccount(address)
        .listen((allContracts) {
      _cachedContracts = allContracts;
      _updateState();
    });
  }

  final Address address;
  final AssetsService assetsService;
  final NekotonRepository nekotonRepository;

  late StreamSubscription<dynamic> _seedSubscription;
  late StreamSubscription<dynamic> _contractsSubscription;

  KeyAccount? _cachedAccount;

  /// Left - available to create, right - created
  (List<TokenContractAsset>, List<TokenContractAsset>)? _cachedContracts;

  void changeTab(SelectNewAssetTabs tab) {
    if (tab == state.tab) return;

    emit(state.copyWith(tab: tab));
  }

  Future<void> enableAsset(Address address) async {
    final isValid = await validateAddress(address);
    if (isValid) {
      await _cachedAccount?.addTokenWallet(address);
    } else {
      inject<MessengerService>().show(
        Message.error(message: LocaleKeys.invalidRootTokenContract.tr()),
      );
    }
  }

  void disableAsset(Address address) {
    _cachedAccount?.removeTokenWallet(address);
  }

  void _updateState() {
    emit(
      state.copyWith(
        account: _cachedAccount,
        contracts: _cachedContracts,
        tab: SelectNewAssetTabs.select,
      ),
    );
  }

  @override
  Future<void> close() {
    _seedSubscription.cancel();
    _contractsSubscription.cancel();

    return super.close();
  }
}
