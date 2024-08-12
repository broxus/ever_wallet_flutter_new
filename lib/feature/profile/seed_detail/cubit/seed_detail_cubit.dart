import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'seed_detail_cubit.freezed.dart';
part 'seed_detail_state.dart';

/// Cubit for <SeedDetailPage>
class SeedDetailCubit extends Cubit<SeedDetailState> {
  SeedDetailCubit(
    this.publicKey,
    this.currentSeedService,
    this.nekotonRepository,
    this.currentKeyService,
  ) : super(const SeedDetailState.initial());

  final CurrentSeedService currentSeedService;
  final CurrentKeyService currentKeyService;
  final NekotonRepository nekotonRepository;
  final PublicKey publicKey;

  late StreamSubscription<Seed?> _currentSeedSubscription;
  late StreamSubscription<PublicKey?> _currentKeySubscription;
  late StreamSubscription<SeedList> _seedListSubscription;

  void init() {
    // skip 1 to avoid duplicate init
    _seedListSubscription = nekotonRepository.seedListStream.skip(1).listen(
          (_) => _mapState(
            currentSeed: currentSeedService.currentSeed,
            currentKey: currentKeyService.currentKey,
          ),
        );
    _currentSeedSubscription =
        currentSeedService.currentSeedStream.skip(1).listen(
              (seed) => _mapState(
                currentSeed: seed,
                currentKey: currentKeyService.currentKey,
              ),
            );
    _currentKeySubscription = currentKeyService.currentKeyStream.skip(1).listen(
          (key) => _mapState(
            currentSeed: currentSeedService.currentSeed,
            currentKey: key,
          ),
        );

    _mapState(
      currentSeed: currentSeedService.currentSeed,
      currentKey: currentKeyService.currentKey,
    );
  }

  void _mapState({required Seed? currentSeed, required PublicKey? currentKey}) {
    final seed = nekotonRepository.seedList.findSeed(publicKey);

    if (seed == null) {
      emit(const SeedDetailState.empty());

      return;
    }

    emit(
      SeedDetailState.data(
        seed: seed,
        isCurrentSeed: seed.publicKey == currentSeed?.publicKey,
        currentPublicKey: currentKey,
      ),
    );
  }

  @override
  Future<void> close() {
    _seedListSubscription.cancel();
    _currentKeySubscription.cancel();
    _currentSeedSubscription.cancel();

    return super.close();
  }
}
