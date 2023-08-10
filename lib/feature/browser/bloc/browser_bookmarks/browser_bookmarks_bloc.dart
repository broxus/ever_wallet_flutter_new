import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_bookmarks_event.dart';
part 'browser_bookmarks_state.dart';
part 'browser_bookmarks_bloc.freezed.dart';

class BrowserBookmarksBloc
    extends Bloc<BrowserBookmarksEvent, BrowserBookmarksState> {
  BrowserBookmarksBloc(
    this.browserBookmarksStorageService,
  ) : super(
          BrowserBookmarksState(
            items: browserBookmarksStorageService.browserBookmarks,
            isEditing: false,
          ),
        ) {
    _registerHandlers();

    _browserBookmarksSubscription =
        browserBookmarksStorageService.browserBookmarksStream.listen(
      (items) {
        add(BrowserBookmarksEvent.set(items: items));
      },
    );
  }

  final BrowserBookmarksStorageService browserBookmarksStorageService;

  StreamSubscription<List<BrowserBookmarkItem>>? _browserBookmarksSubscription;

  @override
  Future<void> close() {
    _browserBookmarksSubscription?.cancel();
    _browserBookmarksSubscription = null;

    return super.close();
  }

  bool canBeAdded(Uri? url) {
    return (url?.host.isNotEmpty ?? false) &&
        state.items.indexWhere((item) => item.url == url) < 0;
  }

  // ignore: long-method
  void _registerHandlers() {
    on<_Add>((event, emit) {
      if (!canBeAdded(event.item.url)) {
        return;
      }

      browserBookmarksStorageService.addBrowserBookmarkItem(event.item);
    });
    on<_Remove>((event, emit) {
      browserBookmarksStorageService.removeBrowserBookmarkItem(event.id);
    });
    on<_Clear>((event, emit) {
      browserBookmarksStorageService.clearBrowserBookmarks();
    });
    on<_Set>((event, emit) {
      emit(
        state.copyWith(
          items: event.items,
        ),
      );
    });
    on<_SetIsEditing>((event, emit) {
      emit(
        state.copyWith(
          isEditing: event.value,
        ),
      );
    });
  }
}
