import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:app/data/models/browser_tab.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';

class TabsManager {
  TabsManager(this._browserTabsStorageService);

  final BrowserTabsStorageService _browserTabsStorageService;

  /// Subject of active browser tab id
  final _activeTabIdSubject = BehaviorSubject<String?>();

  /// Subject of browser tabs
  final _tabsSubject = BehaviorSubject<List<BrowserTab>>();

  /// Stream of active browser tab id
  Stream<String?> get activeTabIdStream => _activeTabIdSubject;

  /// Get last cached of active browser tab id
  String? get activeTabId => _activeTabIdSubject.valueOrNull;

  /// Stream of browser tabs
  Stream<List<BrowserTab>> get tabsStream => _tabsSubject;

  /// Get last cached browser tabs
  List<BrowserTab> get browserTabs => _tabsSubject.valueOrNull ?? [];

  void init() {
    _fetchActiveTabIdFromStorage();
    _fetchBrowserTabs();
  }

  Future<void> clear() {
    return clearTabs();
  }

  /// Clear all browser tabs
  Future<void> clearTabs() async {
    _tabsSubject.add([]);
    _activeTabIdSubject.add(null);

    await _browserTabsStorageService.clearBrowserTabs();
  }

  void saveActiveTabId(String? id) {
    if (id == activeTabId) {
      return;
    }

    final verifiedId = _getBrowserTabById(id) != null
        ? id
        : browserTabs.firstOrNull?.id ?? '-1';

    _browserTabsStorageService.saveBrowserActiveTabId(verifiedId);

    _activeTabIdSubject.add(verifiedId);
  }

  void saveTabs(List<BrowserTab> tabs) {
    _browserTabsStorageService.saveBrowserTabs(tabs);

    _fetchBrowserTabs();
  }

  /// Set browser tab
  void setBrowserTab(BrowserTab tab) {
    final id = tab.id;
    final index = browserTabs.indexWhere((tab) => tab.id == id);
    final tabs = [...browserTabs];

    if (index == -1) {
      tabs.add(tab);
    } else {
      tabs[index] = tab;
    }

    saveTabs(tabs);
  }

  /// Remove browser tab by id
  Future<void> removeBrowserTab(String id) async {
    final tabs = [...browserTabs]..removeWhere((tab) => tab.id == id);

    saveTabs(tabs);

    await _browserTabsStorageService.removeBrowserTab(id);
  }

  /// Add browser tab
  void addBrowserTab(BrowserTab tab) {
    /// Provide unique id for tab
    final newId = tab.id;
    saveTabs([...browserTabs, tab]);
    saveActiveTabId(newId);
  }

  BrowserTab? _getBrowserTabById(String? id) => id != null
      ? browserTabs.firstWhereOrNull(
          (tab) => tab.id == id,
        )
      : null;

  void _fetchActiveTabIdFromStorage() => _activeTabIdSubject.add(
        _browserTabsStorageService.getActiveTabId(),
      );

  /// Put browser tabs to stream
  void _fetchBrowserTabs() => _tabsSubject.add(
        _browserTabsStorageService.getTabs(),
      );
}
