import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'browser_tabs_event.dart';
part 'browser_tabs_state.dart';
part 'browser_tabs_bloc.freezed.dart';

final _emptyUri = Uri.parse('');

class BrowserTabsBloc extends Bloc<BrowserTabsEvent, BrowserTabsState> {
  BrowserTabsBloc(this.browserTabsStorageService)
      : super(
          BrowserTabsState(
            tabs: browserTabsStorageService.browserTabs,
            currentTabId: browserTabsStorageService.browserActiveTabId,
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

  StreamSubscription<List<BrowserTab>>? _browserTabsSubscription;
  StreamSubscription<int>? _browserActiveTabIdSubscription;

  BrowserTab? get activeTab => state.tabs.firstWhereOrNull(
        (tab) => tab.id == state.currentTabId,
      );

  @override
  Future<void> close() {
    _browserTabsSubscription?.cancel();
    _browserTabsSubscription = null;
    _browserActiveTabIdSubscription?.cancel();
    _browserActiveTabIdSubscription = null;

    return super.close();
  }

  void _registerHandlers() {
    on<_Add>((event, emit) {
      final tab = BrowserTab(
        url: event.uri,
        image: null,
        title: null,
        lastScrollPosition: 0,
        // Service will generate unique id for the tab
        id: 0,
      );
      browserTabsStorageService.addBrowserTab(tab);
    });
    on<_AddEmpty>((event, emit) {
      final tab = BrowserTab(
        url: _emptyUri,
        image: null,
        title: null,
        lastScrollPosition: 0,
        // Service will generate unique id for the tab
        id: 0,
      );
      browserTabsStorageService.addBrowserTab(tab);
    });
    on<_SetUrl>((event, emit) {
      final tab = browserTabsStorageService.browserTabActive?.copyWith(
        url: event.uri,
      );
      if (tab != null) {
        browserTabsStorageService.setBrowserTab(tab);
      } else {
        _log.severe('No active tab');
      }
    });
    on<_Remove>((event, emit) {
      browserTabsStorageService.removeBrowserTab(event.id);
    });
    on<_SetActive>((event, emit) {
      browserTabsStorageService.saveBrowserActiveTabId(event.id);
    });
    on<_CloseAll>((event, emit) {
      browserTabsStorageService.clearBrowserTabs();
    });
    on<_SetTabs>((event, emit) {
      emit(state.copyWith(tabs: event.tabs));
    });
    on<_SetActiveTabId>((event, emit) {
      browserTabsStorageService.saveBrowserActiveTabId(event.id);
      emit(state.copyWith(currentTabId: event.id));
    });
  }
}
