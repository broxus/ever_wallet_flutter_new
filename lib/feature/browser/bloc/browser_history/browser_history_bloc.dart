import 'dart:async';

import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_history_bloc.freezed.dart';

part 'browser_history_event.dart';

part 'browser_history_state.dart';

class BrowserHistoryBloc extends Bloc<BrowserHistoryEvent, BrowserHistoryState>
    with BlocBaseMixin {
  BrowserHistoryBloc(
    this._browserService,
  ) : super(
          BrowserHistoryState(
            items: _browserService.hM.browserHistory,
            searchString: '',
            isEditing: false,
          ),
        ) {
    _registerHandlers();

    _browserHistorySubscription =
        _browserService.hM.browserHistoryStream.listen(
      (items) {
        add(BrowserHistoryEvent.set(items: items));
      },
    );
  }

  final BrowserService _browserService;

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
      _browserService.hM.addHistoryItem(event.item);
    });
    on<_AddMultiple>((event, emit) {
      for (final item in event.items) {
        if (item.url.host.isEmpty) {
          continue;
        }
        _browserService.hM.addHistoryItem(item);
      }
    });
    on<_Remove>((event, emit) {
      _browserService.hM.removeHistoryItem(event.id);
    });
    on<_Clear>((event, emit) {
      _browserService.hM.clearHistory();
    });
    on<_Set>((event, emit) {
      emitSafe(
        state.copyWith(
          items: event.items,
        ),
      );
    });
    on<_SetSearchString>((event, emit) {
      emitSafe(
        state.copyWith(
          searchString: event.value,
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
