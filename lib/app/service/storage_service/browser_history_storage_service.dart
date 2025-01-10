import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _browserHistoryDomain = 'browser_history';
const _browserHistoryKey = 'browser_history_key';

/// Limit of browser history items
const _historyItemCountLimit = 50;

/// This is a wrapper-class above [GetStorage] that provides methods
/// to interact with all browser history - related data.
@singleton
class BrowserHistoryStorageService extends AbstractStorageService {
  BrowserHistoryStorageService(
    @Named(container) this._storage,
  );

  static const container = _browserHistoryDomain;

  final GetStorage _storage;

  /// Subject of browser history items
  final _browserHistorySubject = BehaviorSubject<List<BrowserHistoryItem>>();

  /// Stream of browser history items
  Stream<List<BrowserHistoryItem>> get browserHistoryStream =>
      _browserHistorySubject;

  /// Get last cached browser history items
  List<BrowserHistoryItem> get browserHistory =>
      _browserHistorySubject.valueOrNull ?? [];

  /// Put browser history items to stream
  void _streamedBrowserHistory() =>
      _browserHistorySubject.add(readBrowserHistory());

  /// Read list of browser history items from storage
  List<BrowserHistoryItem> readBrowserHistory() {
    final list = _storage.read<List<dynamic>>(_browserHistoryKey);
    if (list == null) {
      return [];
    }

    return list
        .map(
          (entry) => BrowserHistoryItem.fromJson(entry as Map<String, dynamic>),
        )
        .toList();
  }

  /// Save list of browser history items to storage
  void saveBrowserHistory(List<BrowserHistoryItem> history) {
    final sortedHistory = [...history]
      ..sort((a, b) => b.visitTime.compareTo(a.visitTime));
    final sortedLimitedHistory =
        sortedHistory.take(_historyItemCountLimit).toList();

    _storage.write(
      _browserHistoryKey,
      sortedLimitedHistory.map((e) => e.toJson()).toList(),
    );

    _streamedBrowserHistory();
  }

  /// Clear browser history
  Future<void> clearBrowserHistory() async {
    await _storage.remove(_browserHistoryKey);
    _streamedBrowserHistory();
  }

  /// Add browser history item
  void addBrowserHistoryItem(BrowserHistoryItem item) {
    saveBrowserHistory([...browserHistory, item]);
  }

  /// Remove browser history item by id
  void removeBrowserHistoryItem(String id) {
    final history = [...browserHistory]..removeWhere((item) => item.id == id);
    saveBrowserHistory(history);
  }

  @override
  Future<void> init() async {
    await GetStorage.init(container);
    _streamedBrowserHistory();
  }

  @override
  Future<void> clear() async {
    _browserHistorySubject.add([]);
    try {
      await _storage.erase();
    } catch (_) {}
  }
}
