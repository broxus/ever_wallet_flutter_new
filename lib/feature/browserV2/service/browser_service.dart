import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/feature/browserV2/managers/bookmarks_manager.dart';
import 'package:app/feature/browserV2/managers/favicon_manager.dart';
import 'package:app/feature/browserV2/managers/history_manager.dart';
import 'package:app/feature/browserV2/managers/permissions_manager.dart';
import 'package:app/feature/browserV2/managers/tabs_manager.dart';
import 'package:app/feature/browserV2/service/storages/browser_bookmarks_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_favicon_url_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_history_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_permissions_storage_service.dart';
import 'package:app/feature/browserV2/service/storages/browser_tabs_storage_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class BrowserService {
  BrowserService(
    this._bookmarksStorageService,
    this._browserFaviconURLStorageService,
    this._browserHistoryStorageService,
    this._browserTabsStorageService,
    this._browserPermissionsStorageService,
    this._messengerService,
  );

  final BrowserBookmarksStorageService _bookmarksStorageService;
  final BrowserFaviconURLStorageService _browserFaviconURLStorageService;
  final BrowserHistoryStorageService _browserHistoryStorageService;
  final BrowserTabsStorageService _browserTabsStorageService;
  final BrowserPermissionsStorageService _browserPermissionsStorageService;

  final MessengerService _messengerService;

  late final bookmarks = BookmarksManager(
    _bookmarksStorageService,
    _messengerService,
  );
  late final favicon = FaviconManager(_browserFaviconURLStorageService);
  late final history = HistoryManager(_browserHistoryStorageService);
  late final tabs = TabsManager(_browserTabsStorageService);
  late final permissions = PermissionsManager(
    _browserPermissionsStorageService,
  );

  BookmarksManager get bM => bookmarks;

  FaviconManager get fM => favicon;

  HistoryManager get hM => history;

  TabsManager get tM => tabs;

  PermissionsManager get pM => permissions;

  void init() {
    bookmarks.init();
    history.init();
    tabs.init();
    permissions.init();
  }

  Future<void> clear() async {
    await bookmarks.clear();
    await history.clear();
    await tabs.clear();
    await permissions.clear();
  }

  void openNewTab() {
    // TODO
  }
}
