import 'dart:async';
import 'dart:ui';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'browser_tabs_event.dart';
part 'browser_tabs_state.dart';
part 'browser_tabs_bloc.freezed.dart';

final _emptyUri = Uri.parse('');

class BrowserTabsBloc extends Bloc<BrowserTabsEvent, BrowserTabsState> {
  BrowserTabsBloc(
    this.browserTabsStorageService,
    this.onBrowserHistoryItemAdd,
  ) : super(
          BrowserTabsState(
            tabs: browserTabsStorageService.browserTabs,
            currentTabId: browserTabsStorageService.browserActiveTabId,
            tabsState: {},
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

  final void Function(BrowserHistoryItem) onBrowserHistoryItemAdd;

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

      if (oldTab.url.host != newTab.url.host &&
          oldTab.url.toString().trim().isNotEmpty) {
        final state = browserTabStateById(oldTab.id);
        // Host was changed, add old url to history
        onBrowserHistoryItemAdd(
          BrowserHistoryItem.create(
            url: oldTab.url.toString(),
            title: state?.title ?? '',
            faviconUrl: state?.faviconUrl,
          ),
        );
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
        faviconUrl: event.faviconUrl ?? oldTabState.faviconUrl,
        canGoBack: event.canGoBack ?? oldTabState.canGoBack,
        canGoForward: event.canGoForward ?? oldTabState.canGoForward,
        goBack: event.goBack ?? oldTabState.goBack,
        goForward: event.goForward ?? oldTabState.goForward,
        refresh: event.refresh ?? oldTabState.refresh,
      );

      emit(state.copyWith(tabsState: _replaceTabState(event.id, newTabState)));
    });
    on<_Remove>((event, emit) {
      final tab = browserTabById(event.id);
      if (tab != null) {
        final state = browserTabStateById(tab.id);
        // Tab is closing, add url to history
        onBrowserHistoryItemAdd(
          BrowserHistoryItem.create(
            url: tab.url.toString(),
            title: state?.title ?? '',
            faviconUrl: state?.faviconUrl,
          ),
        );
      }
      browserTabsStorageService.removeBrowserTab(event.id);
    });
    on<_SetActive>((event, emit) {
      browserTabsStorageService.saveBrowserActiveTabId(event.id);
    });
    on<_CloseAll>((event, emit) {
      // All tabs are closing, add urls to history
      for (final tab in state.tabs) {
        final state = browserTabStateById(tab.id);
        onBrowserHistoryItemAdd(
          BrowserHistoryItem.create(
            url: tab.url.toString(),
            title: state?.title ?? '',
            faviconUrl: state?.faviconUrl,
          ),
        );
      }
      browserTabsStorageService.clearBrowserTabs();
    });
    on<_SetTabs>((event, emit) {
      emit(
        state.copyWith(
          tabs: event.tabs,
          tabsState: _clearTabStates(),
        ),
      );
    });
    on<_SetActiveTabId>((event, emit) {
      browserTabsStorageService.saveBrowserActiveTabId(event.id);
      emit(state.copyWith(currentTabId: event.id));
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
}
