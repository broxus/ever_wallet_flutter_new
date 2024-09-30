// ignore_for_file: cascade_invocations
import 'dart:async';

import 'package:app/app/service/secure_storage_service.dart';
import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'manage_seeds_accounts_cubit.freezed.dart';

part 'manage_seeds_accounts_state.dart';

/// This is a bloc that displays list of user's seeds.
///
/// This displays list of available seeds and current seed.
class ManageSeedsAccountsCubit extends Cubit<ManageSeedsAccountsState> {
  ManageSeedsAccountsCubit(
    this.nekotonRepository,
    this.currentSeedService,
    this.storageService,
    this.currentAccountsService,
  ) : super(
          ManageSeedsAccountsState.data(
            currentSeed: currentSeedService.currentSeed,
            seeds: _mapSeedList(nekotonRepository.seedList),
          ),
        );

  final NekotonRepository nekotonRepository;
  final CurrentSeedService currentSeedService;
  final SecureStorageService storageService;
  final CurrentAccountsService currentAccountsService;

  late StreamSubscription<SeedList> _seedListSubscription;
  late StreamSubscription<Seed?> _currentSeedSubscription;

  @override
  Future<void> close() {
    _seedListSubscription.cancel();
    _currentSeedSubscription.cancel();

    return super.close();
  }

  void init() {
    // skip 1 to avoid duplicate init from constructor
    _currentSeedSubscription =
        currentSeedService.currentSeedStream.skip(1).listen(
      (currentSeed) {
        emit(
          ManageSeedsAccountsState.data(
            currentSeed: currentSeed,
            seeds: _mapSeedList(nekotonRepository.seedList),
          ),
        );
      },
    );
    _seedListSubscription = nekotonRepository.seedListStream.skip(1).listen(
      (seeds) {
        final list = seeds.seeds;
        list.sort((a, b) => a.addedAt.compareTo(b.addedAt));
        if (list.first.addedAt != 0) {
          if (list.last.masterKey.accountList.allAccounts.isNotEmpty) {
            list.last.masterKey.accountList.allAccounts.forEach((account) {
              storageService.addValue(
                account.address.address +
                    StorageConstants.showingManualBackupBadge,
                list.last.addType == SeedAddType.create,
              );
            });
          }
          emit(
            ManageSeedsAccountsState.data(
              currentSeed: currentSeedService.currentSeed,
              seeds: _mapSeedList(seeds),
            ),
          );
        }
      },
    );
  }

  static List<Seed> _mapSeedList(SeedList list) {
    return List.from(list.seeds)..sort((a, b) => a.name.compareTo(b.name));
  }
}
