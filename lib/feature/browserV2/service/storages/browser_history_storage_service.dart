import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _browserHistoryDomain = 'browser_history';
const _browserHistoryKey = 'browser_history_key';

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser history - related data.
@singleton
class BrowserHistoryStorageService extends AbstractStorageService {
  BrowserHistoryStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserHistoryDomain;

  final GetStorage _storage;

  /// Read list of browser history items from storage
  List<BrowserHistoryItem> getBrowserHistory() {
    final list = _storage.read<List<dynamic>>(_browserHistoryKey);
    if (list == null) {
      return [];
    }

    return [
      for (final entry in list)
        BrowserHistoryItem.fromJson(
          entry as Map<String, dynamic>,
        ),
    ];
  }

  /// Save list of browser history items to storage
  void saveBrowserHistory(Iterable<BrowserHistoryItem> history) {
    _storage.write(
      _browserHistoryKey,
      history.map((e) => e.toJson()).toList(),
    );
  }

  /// Clear browser history
  Future<void> clearBrowserHistory() async {
    await _storage.remove(_browserHistoryKey);
  }

  @override
  Future<void> init() async {
    await GetStorage.init(container);
  }

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearBrowserHistory(),
      ]);
}
