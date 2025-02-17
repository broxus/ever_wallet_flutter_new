import 'package:app/feature/browserV2/service/storages/browser_history_storage_service.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:rxdart/rxdart.dart';

class HistoryManager {
  HistoryManager(this._browserHistoryStorageService);

  /// Limit of browser history items
  static const _historyItemCountLimit = 50;

  final BrowserHistoryStorageService _browserHistoryStorageService;

  /// Subject of browser history items
  final _browserHistorySubject = BehaviorSubject<List<BrowserHistoryItem>>();

  /// Stream of browser history items
  Stream<List<BrowserHistoryItem>> get browserHistoryStream =>
      _browserHistorySubject;

  /// Get last cached browser history items
  List<BrowserHistoryItem> get browserHistoryItems =>
      _browserHistorySubject.valueOrNull ?? [];

  void init() {
    _fetchHistoryFromStorage();
  }

  Future<void> clear() {
    return clearHistory();
  }

  void saveBrowserHistory(List<BrowserHistoryItem> history) {
    final sortedHistory = [...history]
      ..sort(
        (a, b) => b.visitTime.compareTo(a.visitTime),
      )
      ..take(_historyItemCountLimit);
    _browserHistoryStorageService.saveBrowserHistory(sortedHistory);

    _browserHistorySubject.add(sortedHistory);
  }

  Future<void> clearHistory() async {
    await _browserHistoryStorageService.clearBrowserHistory();
    _browserHistorySubject.add([]);
  }

  void addHistoryItem(BrowserHistoryItem item) {
    if (item.url.host.isEmpty) {
      return;
    }
    saveBrowserHistory([...browserHistoryItems, item]);
  }

  void addHistoryItems(List<BrowserHistoryItem> items) {
    saveBrowserHistory([...browserHistoryItems, ...items]);
  }

  void removeHistoryItem(String id) {
    saveBrowserHistory(
      [...browserHistoryItems]..removeWhere((item) => item.id == id),
    );
  }

  void _fetchHistoryFromStorage() => _browserHistorySubject.add(
        _browserHistoryStorageService.getBrowserHistory(),
      );
}
