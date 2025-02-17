import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'browser_tabs_bloc.freezed.dart';

part 'browser_tabs_event.dart';

part 'browser_tabs_state.dart';

final _emptyUri = Uri.parse('');

class BrowserTabsBloc extends Bloc<BrowserTabsEvent, BrowserTabsState>
    with BlocBaseMixin {
  BrowserTabsBloc(
    this.browserTabsStorageService,
    this.onBrowserHistoryItemAdd,
    this.onBrowserMultipleHistoryItemAdd,
  ) : super(
          BrowserTabsState(
            tabs: browserTabsStorageService.browserTabs,
            currentTabId: browserTabsStorageService.browserActiveTabId,
            tabsState: {},
            clearCacheOnNextTab: false,
            searchText: '',
          ),
        ) {
    _registerHandlers();

    _browserTabsSubscription =
        browserTabsStorageService.browserTabsStream.listen(
      (tabs) {
        add(BrowserTabsEvent.setTabs(tabs: tabs));
      },
    );

    _browserActiveTabIdSubscription =
        browserTabsStorageService.browserActiveTabIdStream.listen(
      (id) {
        add(BrowserTabsEvent.setActiveTabId(id: id));
      },
    );
  }

  static final _log = Logger('BrowserTabsBloc');

  final BrowserTabsStorageService browserTabsStorageService;

  final ValueChanged<BrowserHistoryItem> onBrowserHistoryItemAdd;
  final ValueChanged<List<BrowserHistoryItem>> onBrowserMultipleHistoryItemAdd;

  StreamSubscription<List<BrowserTab>>? _browserTabsSubscription;
  StreamSubscription<String?>? _browserActiveTabIdSubscription;

  BrowserTab? get activeTab => state.currentTabId != null
      ? browserTabById(state.currentTabId ?? '')
      : null;

  BrowserTabState? get activeTabState => state.currentTabId != null
      ? browserTabStateById(state.currentTabId ?? '')
      : null;

  @override
  Future<void> close() {
    _browserTabsSubscription?.cancel();
    _browserTabsSubscription = null;
    _browserActiveTabIdSubscription?.cancel();
    _browserActiveTabIdSubscription = null;

    return super.close();
  }

  // ignore: long-method
  void _registerHandlers() {
    on<_Add>((event, emit) {
      final tab = BrowserTab.create(
        url: event.uri,
      );
      browserTabsStorageService.addBrowserTab(tab);
    });
    on<_AddEmpty>((event, emit) {
      final tab = BrowserTab.create(
        url: _emptyUri,
      );
      browserTabsStorageService.addBrowserTab(tab);
    });
    on<_SetUrl>((event, emit) {
      final oldTab = browserTabById(event.id);
      if (oldTab == null) {
        _log.severe('_SetUrl: no active tab');

        return;
      }
      final newTab = oldTab.copyWith(
        url: event.uri,
      );
      if (oldTab.url != newTab.url) {
        browserTabsStorageService.setBrowserTab(newTab);
      }

      if (oldTab.url.host != newTab.url.host) {
        final state = browserTabStateById(oldTab.id);
        // Host was changed, add old url to history
        _addHistoryItem(oldTab, state);
      }
    });
    on<_SetScreenshot>((event, emit) {
      final oldTab = browserTabById(event.id);
      if (oldTab == null) {
        _log.severe('_SetScreenshot: no active tab');

        return;
      }
      final newTab = oldTab.copyWith(
        imageId: event.imageId,
      );
      browserTabsStorageService.setBrowserTab(newTab);
    });
    on<_SetState>((event, emit) {
      var oldTabState = browserTabStateById(event.id);
      oldTabState ??= const BrowserTabState();

      final newTabState = oldTabState.copyWith(
        state: event.state ?? oldTabState.state,
        progress: event.progress ?? oldTabState.progress,
        errorMessage: event.errorMessage ?? oldTabState.errorMessage,
        title: event.title ?? oldTabState.title,
        canGoBack: event.canGoBack ?? oldTabState.canGoBack,
        canGoForward: event.canGoForward ?? oldTabState.canGoForward,
        goBack: event.goBack ?? oldTabState.goBack,
        goForward: event.goForward ?? oldTabState.goForward,
        refresh: event.refresh ?? oldTabState.refresh,
        basicAuthCreds: event.basicAuthCreds ?? oldTabState.basicAuthCreds,
      );

      emitSafe(
        state.copyWith(
          tabsState: _replaceTabState(event.id, newTabState),
        ),
      );
    });
    on<_Remove>((event, emit) {
      final tab = browserTabById(event.id);
      if (tab != null) {
        final state = browserTabStateById(tab.id);
        // Tab is closing, add url to history
        _addHistoryItem(tab, state);
      }
      browserTabsStorageService.removeBrowserTab(event.id);
      if (state.currentTabId == event.id) {
        final tabs = state.tabs;
        final newActiveTabId = tabs.firstOrNull?.id;
        browserTabsStorageService.saveBrowserActiveTabId(newActiveTabId);
      }
    });
    on<_SetActive>((event, emit) {
      browserTabsStorageService.saveBrowserActiveTabId(event.id);
    });
    on<_CloseAll>((event, emit) {
      // All tabs are closing, add urls to history
      _addHistoryMultipleItem(state);
      browserTabsStorageService.clearBrowserTabs();
    });
    on<_SetTabs>((event, emit) {
      emitSafe(
        state.copyWith(
          tabs: event.tabs,
          tabsState: _clearTabStates(),
        ),
      );
    });
    on<_SetActiveTabId>((event, emit) {
      browserTabsStorageService.saveBrowserActiveTabId(event.id);
      emitSafe(state.copyWith(currentTabId: event.id));
    });
    on<_ClearCache>((event, emit) {
      emitSafe(state.copyWith(clearCacheOnNextTab: true));
    });
    on<_CacheCleared>((event, emit) {
      emitSafe(state.copyWith(clearCacheOnNextTab: true));
    });
    on<_SetSearchText>((event, emit) {
      emitSafe(state.copyWith(searchText: event.text));
    });
  }

  Map<String, BrowserTabState> _replaceTabState(
    String id,
    BrowserTabState newTabState,
  ) {
    return {
      ...({...state.tabsState}..removeWhere((key, value) => key == id)),
      ...{id: newTabState},
    };
  }

  Map<String, BrowserTabState> _clearTabStates() {
    return {
      ...({...state.tabsState}..removeWhere(
          (key, value) => browserTabById(key) == null,
        )),
    };
  }

  BrowserTab? browserTabById(String id) {
    return state.tabs.firstWhereOrNull((tab) => tab.id == id);
  }

  BrowserTabState? browserTabStateById(String id) {
    return state.tabsState[id];
  }

  void _addHistoryItem(BrowserTab tab, BrowserTabState? state) {
    onBrowserHistoryItemAdd(
      _createHistoryItem(tab, state),
    );
  }

  void _addHistoryMultipleItem(BrowserTabsState? state) {
    if (state == null) {
      return;
    }
    onBrowserMultipleHistoryItemAdd(
      [
        for (final tab in state.tabs)
          _createHistoryItem(
            tab,
            browserTabStateById(tab.id),
          ),
      ],
    );
  }

  BrowserHistoryItem _createHistoryItem(
    BrowserTab tab,
    BrowserTabState? state,
  ) {
    return BrowserHistoryItem.create(
      url: tab.url,
      title: state?.title ?? '',
    );
  }
}
