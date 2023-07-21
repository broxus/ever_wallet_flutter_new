import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_tabs_bloc_event.dart';
part 'browser_tabs_bloc_state.dart';
part 'browser_tabs_bloc.freezed.dart';

class BrowserTabsBloc extends Bloc<BrowserTabsBlocEvent, BrowserTabsBlocState> {
  BrowserTabsBloc(this.browserStorageService)
      : super(
          BrowserTabsBlocState(
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
    on<_Remove>((event, emit) {
      browserStorageService.removeBrowserTab(event.id);
    });
    on<_SetActive>((event, emit) {
      browserStorageService.saveBrowserActiveTabId(event.id);
    });
    on<_CloseAll>((event, emit) {
      browserStorageService.clearBrowserTabs();
    });

    _browserTabsSubscription = browserStorageService.browserTabsStream.listen(
      (tabs) {
        add(BrowserTabsBlocEvent.setTabs(tabs: tabs));
      },
    );

    _browserActiveTabIdSubscription =
        browserStorageService.browserActiveTabIdStream.listen(
      (id) {
        add(BrowserTabsBlocEvent.setActiveTabId(id: id));
      },
    );
  }

  final BrowserStorageService browserStorageService;

  StreamSubscription<List<BrowserTab>>? _browserTabsSubscription;
  StreamSubscription<int>? _browserActiveTabIdSubscription;

  @override
  Future<void> close() {
    _browserTabsSubscription?.cancel();
    _browserTabsSubscription = null;
    _browserActiveTabIdSubscription?.cancel();
    _browserActiveTabIdSubscription = null;

    return super.close();
  }
}
