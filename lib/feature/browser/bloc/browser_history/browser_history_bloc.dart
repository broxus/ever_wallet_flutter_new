import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:app/data/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_history_event.dart';
part 'browser_history_state.dart';
part 'browser_history_bloc.freezed.dart';

class BrowserHistoryBloc
    extends Bloc<BrowserHistoryEvent, BrowserHistoryState> {
  BrowserHistoryBloc(
    this.browserHistoryStorageService,
  ) : super(
          BrowserHistoryState(
            items: browserHistoryStorageService.browserHistory,
            searchString: '',
            isEditing: false,
          ),
        ) {
    _registerHandlers();

    _browserHistorySubscription =
        browserHistoryStorageService.browserHistoryStream.listen(
      (items) {
        add(BrowserHistoryEvent.set(items: items));
      },
    );
  }

  final BrowserHistoryStorageService browserHistoryStorageService;

  StreamSubscription<List<BrowserHistoryItem>>? _browserHistorySubscription;

  @override
  Future<void> close() {
    _browserHistorySubscription?.cancel();
    _browserHistorySubscription = null;

    return super.close();
  }

  // ignore: long-method
  void _registerHandlers() {
    on<_Add>((event, emit) {
      if (event.item.url.host.isEmpty) {
        return;
      }
      browserHistoryStorageService.addBrowserHistoryItem(event.item);
    });
    on<_Remove>((event, emit) {
      browserHistoryStorageService.removeBrowserHistoryItem(event.id);
    });
    on<_Clear>((event, emit) {
      browserHistoryStorageService.clearBrowserHistory();
    });
    on<_Set>((event, emit) {
      emit(
        state.copyWith(
          items: event.items,
        ),
      );
    });
    on<_SetSearchString>((event, emit) {
      emit(
        state.copyWith(
          searchString: event.value,
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

  List<BrowserHistoryItem> getFilteredItems() {
    final searchString = state.searchString.toLowerCase();

    return state.items.where((item) {
      final title = item.title.toLowerCase();
      final url = item.url.toString().toLowerCase();

      return title.contains(searchString) || url.contains(searchString);
    }).toList();
  }

  bool get isHistoryEmpty {
    return state.items.isEmpty;
  }
}
