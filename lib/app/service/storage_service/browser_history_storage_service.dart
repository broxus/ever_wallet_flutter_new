import 'dart:convert';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:encrypted_storage/encrypted_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

const _browserHistoryDomain = 'browser_history';
const _browserHistoryKey = 'browser_history_key';

/// Limit of browser history items
const _historyItemCountLimit = 50;

/// This is a wrapper-class above [EncryptedStorage] that provides methods
/// to interact with all browser history - related data.
@singleton
class BrowserHistoryStorageService extends AbstractStorageService {
  BrowserHistoryStorageService(this._storage);

  /// Storage that is used to store data
  final EncryptedStorage _storage;

  /// Subject of browser history items
  final _browserHistorySubject = BehaviorSubject<List<BrowserHistoryItem>>();

  /// Stream of browser history items
  Stream<List<BrowserHistoryItem>> get browserHistoryStream =>
      _browserHistorySubject;

  /// Get last cached browser history items
  List<BrowserHistoryItem> get browserHistory =>
      _browserHistorySubject.valueOrNull ?? [];

  /// Put browser history items to stream
  Future<void> _streamedBrowserHistory() async =>
      _browserHistorySubject.add(await readBrowserHistory());

  /// Read list of browser history items from storage
  Future<List<BrowserHistoryItem>> readBrowserHistory() async {
    final encoded = await _storage.get(
      _browserHistoryKey,
      domain: _browserHistoryDomain,
    );
    if (encoded == null) {
      return [];
    }
    final list = jsonDecode(encoded) as List<dynamic>;

    return list
        .map(
          (entry) => BrowserHistoryItem.fromJson(entry as Map<String, dynamic>),
        )
        .toList();
  }

  /// Save list of browser history items to storage
  Future<void> saveBrowserHistory(List<BrowserHistoryItem> history) async {
    final limitedHistory = [...history]
      ..sort((a, b) => b.visitTime.compareTo(a.visitTime))
      ..take(_historyItemCountLimit);

    await _storage.set(
      _browserHistoryKey,
      jsonEncode(limitedHistory),
      domain: _browserHistoryDomain,
    );
    await _streamedBrowserHistory();
  }

  /// Clear browser history
  Future<void> clearBrowserHistory() async {
    await _storage.delete(
      _browserHistoryKey,
      domain: _browserHistoryDomain,
    );
    _browserHistorySubject.add([]);

    await _streamedBrowserHistory();
  }

  /// Add browser history item
  Future<void> addBrowserHistoryItem(BrowserHistoryItem item) async {
    await saveBrowserHistory([...browserHistory, item]);
  }

  /// Remove browser history item by id
  Future<void> removeBrowserHistoryItem(String id) async {
    final history = [...browserHistory]..removeWhere((item) => item.id == id);

    await saveBrowserHistory(history);
  }

  @override
  Future<void> init() => Future.wait([
        _streamedBrowserHistory(),
      ]);

  @override
  Future<void> clearSensitiveData() => Future.wait([
        clearBrowserHistory(),
      ]);
}
