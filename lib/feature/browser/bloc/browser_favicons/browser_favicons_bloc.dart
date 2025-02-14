import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/feature/browserV2/browser_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'browser_favicons_bloc.freezed.dart';

part 'browser_favicons_event.dart';

part 'browser_favicons_state.dart';

class BrowserFaviconsBloc
    extends Bloc<BrowserFaviconsEvent, BrowserFaviconsState>
    with BlocBaseMixin {
  BrowserFaviconsBloc(
    this._browserManager,
  ) : super(
          const BrowserFaviconsState(
            items: {},
          ),
        ) {
    _registerHandlers();
  }

  final BrowserManager _browserManager;

  /// Returns the favicon URL for the given [uri].
  String? getFaviconUrl(Uri uri) {
    final url = state.items[uri];
    if (url == null) {
      _fetchForUri(uri);
    }

    return url;
  }

  void _registerHandlers() {
    on<_SetItem>((event, emit) {
      emitSafe(
        state.copyWith(
          items: {...state.items, event.uri: event.faviconURL},
        ),
      );
    });

    on<_FetchItems>((event, emit) {
      event.uris.forEach(_fetchForUri);
    });
  }

  Future<void> _fetchForUri(Uri uri) async {
    final faviconUrl = await _browserManager.favicon.getFaviconURL(uri);

    if (faviconUrl != null) {
      add(
        BrowserFaviconsEvent.setItem(
          uri: uri,
          faviconURL: faviconUrl,
        ),
      );
    }
  }
}
