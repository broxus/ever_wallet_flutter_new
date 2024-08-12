import 'dart:async';

import 'package:app/feature/profile/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'key_detail_cubit.freezed.dart';
part 'key_detail_state.dart';

/// Cubit of detail key page, displays different pages of accounts, depends on
/// [KeyDetailAccountsTab].
class KeyDetailCubit extends Cubit<KeyDetailState> {
  KeyDetailCubit(
    this.nekotonRepository,
    this.publicKey,
  ) : super(const KeyDetailState.initial());

  final NekotonRepository nekotonRepository;
  final PublicKey publicKey;

  KeyDetailAccountsTab _accountsTab = KeyDetailAccountsTab.local;
  late String _ownerSeedName;
  late SeedKey key;

  late StreamSubscription<SeedList> _seedSubscription;

  void init() {
    _seedSubscription = nekotonRepository.seedListStream
        .listen((list) => _mapSeed(list.findSeedByAnyPublicKey(publicKey)));
  }

  void _mapSeed(Seed? seed) {
    final key = seed?.findKeyByPublicKey(publicKey);
    if (key != null && seed != null) {
      this.key = key;
      _ownerSeedName = seed.name;
      _emitDataState();
    } else {
      emit(const KeyDetailState.empty());
    }
  }

  void changeTab(KeyDetailAccountsTab tab) {
    if (_accountsTab != tab) {
      _accountsTab = tab;
      _emitDataState();
    }
  }

  void _emitDataState() {
    emit(KeyDetailState.data(key, _ownerSeedName, _accountsTab));
  }

  @override
  Future<void> close() {
    _seedSubscription.cancel();

    return super.close();
  }
}
