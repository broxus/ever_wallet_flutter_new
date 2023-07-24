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
  BrowserTabsBloc(this.browserStorageService)
      : super(
          BrowserTabsState(
            tabs: browserStorageService.browserTabs,
            currentTabId: browserStorageService.browserActiveTabId,
          ),
        ) {
    on<_Add>((event, emit) {
      final tab = BrowserTab(
        url: event.uri,
        image: null,
        title: null,
        lastScrollPosition: 0,
        // Service will generate unique id for the tab
        id: 0,
      );
      browserStorageService.addBrowserTab(tab);
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
      browserStorageService.addBrowserTab(tab);
    });
    on<_SetUrl>((event, emit) {
      final tab = browserStorageService.browserTabActive?.copyWith(
        url: event.uri,
      );
      if (tab != null) {
        browserStorageService.setBrowserTab(tab);
      } else {
        _log.severe('No active tab');
      }
    });
    on<_Remove>((event, emit) {
      browserStorageService.removeBrowserTab(event.id);
    });
    on<_SetActive>((event, emit) {
      browserStorageService.saveBrowserActiveTabId(event.id);
    });
    on<_CloseAll>((event, emit) {
      browserStorageService.clearBrowserTabs();
    });
    on<_SetTabs>((event, emit) {
      emit(state.copyWith(tabs: event.tabs));
    });
    on<_SetActiveTabId>((event, emit) {
      browserStorageService.saveBrowserActiveTabId(event.id);
      emit(state.copyWith(currentTabId: event.id));
    });

    _browserTabsSubscription = browserStorageService.browserTabsStream.listen(
      (tabs) {
        add(BrowserTabsEvent.setTabs(tabs: tabs));
      },
    );

    _browserActiveTabIdSubscription =
        browserStorageService.browserActiveTabIdStream.listen(
      (id) {
        add(BrowserTabsEvent.setActiveTabId(id: id));
      },
    );
  }
  static final _log = Logger('BrowserTabsBloc');

  final BrowserStorageService browserStorageService;

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
}
