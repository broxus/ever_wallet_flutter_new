import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'derive_keys_cubit.freezed.dart';

part 'derive_keys_state.dart';

/// How many keys should be displayed on one page
const _keysPerPage = 5;

/// Number of pages that we be able to select.
const derivePageCount = 20;

/// Cubit that contains logic to derive keys from seed.
/// UI displays keys by pages, every page contains up to [_keysPerPage] keys.
class DeriveKeysCubit extends Cubit<DeriveKeysState> with BlocBaseMixin {
  DeriveKeysCubit(
    this.nekotonRepository,
    this.publicKey,
    this.password,
  ) : super(const DeriveKeysState.initial());

  final NekotonRepository nekotonRepository;
  final PublicKey publicKey;
  final String password;

  /// Keys that were added before this deriving
  List<PublicKey> addedKeys = [];

  /// Key - public key, value - name of key
  Map<PublicKey, String> addedKeysNames = {};

  /// Index of page that should contains paginated keys from
  /// [derivePossibleKeys], page can be up to [derivePageCount].
  int _currentPageIndex = 0;

  /// List of keys that should be displayed in UI like all possible keys.
  List<PublicKey> derivePossibleKeys = [];

  /// Keys that were added during this deriving and this keys should be derived
  Set<PublicKey> newKeysToAdd = {};

  /// Keys that were added before this deriving and must be removed
  Set<PublicKey> keysToRemove = {};

  /// Keys that should contains check mark in UI (like they are added)
  Set<PublicKey> checkedKeys = {};

  Future<void> init() async {
    final seed = nekotonRepository.seedList.findSeed(publicKey);
    if (seed == null) return;

    for (final key in seed.allKeys) {
      addedKeys.add(key.publicKey);
      addedKeysNames[key.publicKey] = key.name;
    }
    checkedKeys.addAll(addedKeys);

    final keys = await seed.getKeysToDerive(password);
    derivePossibleKeys.addAll(keys);

    _emitDataState();
  }

  /// Set check mark to key.
  /// Add new key to [newKeysToAdd] if it was not added before or do nothing if
  /// it is in [addedKeys].
  void checkKey(PublicKey publicKey) {
    if (!addedKeys.contains(publicKey)) {
      newKeysToAdd.add(publicKey);
    } else {
      keysToRemove.remove(publicKey);
    }

    checkedKeys.add(publicKey);
    _emitDataState();
  }

  /// Remove check mark from key.
  /// Add key to [keysToRemove] if it is in [addedKeys] or do nothing if it is
  /// in [newKeysToAdd].
  void uncheckKey(PublicKey publicKey) {
    if (addedKeys.contains(publicKey)) {
      keysToRemove.add(publicKey);
    } else {
      newKeysToAdd.remove(publicKey);
    }
    checkedKeys.remove(publicKey);
    _emitDataState();
  }

  bool _canPrevPage() => _currentPageIndex > 0;

  bool _canSelectPage(int page) => page >= 0 && page <= derivePageCount - 1;

  bool _canNextPage() => _currentPageIndex < derivePageCount - 1;

  void prevPage() {
    if (_canPrevPage()) {
      _currentPageIndex--;
    }
    _emitDataState();
  }

  void nextPage() {
    if (_canNextPage()) {
      _currentPageIndex++;
    }
    _emitDataState();
  }

  void selectPage(int pageIndex) {
    if (_canSelectPage(pageIndex)) {
      _currentPageIndex = pageIndex;
    }

    _emitDataState();
  }

  void _emitDataState() {
    emitSafe(
      DeriveKeysState.data(
        canNextPage: _canNextPage(),
        canPrevPage: _canPrevPage(),
        currentPageIndex: _currentPageIndex,
        pageCount: derivePageCount,
        keyNames: addedKeysNames,
        displayDerivedKeys: derivePossibleKeys
            .skip(_currentPageIndex * _keysPerPage)
            .take(_keysPerPage)
            .toList(),
        selectedKeys: checkedKeys.toList(),
        isLoading: false,
        isCompleted: false,
      ),
    );
  }

  Future<void> select() async {
    final seed = nekotonRepository.seedList.findSeed(publicKey);
    if (seed == null) return;

    emitSafe(
      DeriveKeysState.data(
        canNextPage: false,
        canPrevPage: false,
        currentPageIndex: _currentPageIndex,
        pageCount: derivePageCount,
        keyNames: addedKeysNames,
        displayDerivedKeys: derivePossibleKeys
            .skip(_currentPageIndex * _keysPerPage)
            .take(_keysPerPage)
            .toList(),
        selectedKeys: checkedKeys.toList(),
        isLoading: true,
        isCompleted: false,
      ),
    );

    if (keysToRemove.isNotEmpty) {
      final toRemove = seed.subKeys
          .where((key) => keysToRemove.contains(key.publicKey))
          .toList();

      await nekotonRepository.removeKeys(toRemove);
    }

    if (newKeysToAdd.isNotEmpty) {
      final accountIds =
          newKeysToAdd.map((key) => derivePossibleKeys.indexOf(key)).toList();
      await seed.deriveKeys(
        accountIds: accountIds,
        password: password,
      );
    }

    emitSafe(
      DeriveKeysState.data(
        canNextPage: false,
        canPrevPage: false,
        currentPageIndex: _currentPageIndex,
        pageCount: derivePageCount,
        keyNames: addedKeysNames,
        displayDerivedKeys: derivePossibleKeys
            .skip(_currentPageIndex * _keysPerPage)
            .take(_keysPerPage)
            .toList(),
        selectedKeys: checkedKeys.toList(),
        isLoading: false,
        isCompleted: true,
      ),
    );
  }
}
