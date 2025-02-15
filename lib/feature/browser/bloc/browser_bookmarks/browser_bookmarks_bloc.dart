import 'dart:async';

import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_bookmarks_bloc.freezed.dart';

part 'browser_bookmarks_event.dart';

part 'browser_bookmarks_state.dart';

class BrowserBookmarksBloc
    extends Bloc<BrowserBookmarksEvent, BrowserBookmarksState>
    with BlocBaseMixin {
  BrowserBookmarksBloc(
    this._browserService,
  ) : super(
          BrowserBookmarksState(
            items: _browserService.bM.browserBookmarks,
            isEditing: false,
          ),
        ) {
    _registerHandlers();

    _browserBookmarksSubscription =
        _browserService.bM.browserBookmarksStream.listen(
      (items) {
        add(BrowserBookmarksEvent.set(items: items));
      },
    );
  }

  final BrowserService _browserService;

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

  List<BrowserBookmarkItem> getSortedItems() {
    return [...state.items]..sort(
        (a, b) => (b.sortingOrder - a.sortingOrder).sign.toInt(),
      );
  }

  // ignore: long-method
  void _registerHandlers() {
    on<_SetItem>((event, emit) {
      if (!canBeAdded(event.item.url) &&
          state.items.indexWhere((item) => item.id == event.item.id) < 0) {
        return;
      }

      // We should update it locally to prevent flicker when reordering
      emitSafe(
        state.copyWith(
          items: [
            ...[...state.items]..removeWhere((i) => i.id == event.item.id),
            event.item,
          ],
        ),
      );

      _browserService.bM.setBrowserBookmarkItem(event.item);
    });
    on<_Remove>((event, emit) {
      _browserService.bM.removeBrowserBookmarkItem(event.id);
    });
    on<_Clear>((event, emit) {
      _browserService.bM.clearBookmarks();
    });
    on<_Set>((event, emit) {
      emitSafe(
        state.copyWith(
          items: event.items,
        ),
      );
    });
    on<_SetIsEditing>((event, emit) {
      emitSafe(
        state.copyWith(
          isEditing: event.value,
        ),
      );
    });
  }
}
