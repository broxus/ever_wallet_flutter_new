import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'derive_keys_state.dart';

part 'derive_keys_cubit.freezed.dart';

/// How many keys should be displayed on one page
const _keysPerPage = 5;

/// Number of pages that we be able to select.
const _pageCount = 20;

/// Cubit that contains logic to derive keys from seed.
/// UI displays keys by pages, every page contains up to [_keysPerPage] keys.
class DeriveKeysCubit extends Cubit<DeriveKeysState> {
  DeriveKeysCubit(
    this.nekotonRepository,
    this.publicKey,
    this.password,
  ) : super(const DeriveKeysState.initial());

  final NekotonRepository nekotonRepository;
  final String publicKey;
  final String password;

  /// Keys that were added before this deriving
  List<String> addedKeys = [];

  /// Index of page that should contains paginated keys from
  /// [derivePossibleKeys], page can be up to [_pageCount].
  int _currentPageIndex = 0;

  /// List of keys that should be displayed in UI like all possible keys.
  List<String> derivePossibleKeys = [];

  /// Keys that were added during this deriving and this keys should be derived
  Set<String> newKeysToAdd = {};

  /// Keys that were added before this deriving and must be removed
  Set<String> keysToRemove = {};

  /// Keys that should contains check mark in UI (like they are added)
  Set<String> checkedKeys = {};

  Future<void> init() async {
    final seed = nekotonRepository.seedList.findSeed(publicKey);
    if (seed == null) return;

    addedKeys.addAll(seed.allKeys.map((e) => e.publicKey));
    checkedKeys.addAll(addedKeys);

    final keys = await seed.getKeysToDerive(password);
    derivePossibleKeys.addAll(keys);

    _emitDataState();
  }

  /// Set check mark to key.
  /// Add new key to [newKeysToAdd] if it was not added before or do nothing if
  /// it is in [addedKeys].
  void checkKey(String publicKey) {
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
  void uncheckKey(String publicKey) {
    if (addedKeys.contains(publicKey)) {
      keysToRemove.add(publicKey);
    } else {
      newKeysToAdd.remove(publicKey);
    }
    checkedKeys.remove(publicKey);
    _emitDataState();
  }

  bool _canPrevPage() => _currentPageIndex > 0;

  bool _canNextPage() => _currentPageIndex < _pageCount - 1;

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

  void _emitDataState() {
    emit(
      DeriveKeysState.data(
        canNextPage: _canNextPage(),
        canPrevPage: _canPrevPage(),
        currentPageIndex: _currentPageIndex,
        pageCount: _pageCount,
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

    emit(
      DeriveKeysState.data(
        canNextPage: false,
        canPrevPage: false,
        currentPageIndex: _currentPageIndex,
        pageCount: _pageCount,
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

    emit(
      DeriveKeysState.data(
        canNextPage: false,
        canPrevPage: false,
        currentPageIndex: _currentPageIndex,
        pageCount: _pageCount,
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
