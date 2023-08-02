import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'browser_tab_state.freezed.dart';

enum BrowserTabStateType {
  initial,
  loading,
  loaded,
  error,
}

@Freezed(fromJson: false, toJson: false)
class BrowserTabState with _$BrowserTabState {
  const factory BrowserTabState({
    @Default(BrowserTabStateType.initial) final BrowserTabStateType state,
    @Default(0) final int progress,
    @Default(null) final String? errorMessage,
    @Default(false) final bool canGoBack,
    @Default(false) final bool canGoForward,
    @Default(null) final VoidCallback? goBack,
    @Default(null) final VoidCallback? goForward,
    @Default(null) final VoidCallback? refresh,
  }) = _BrowserTabState;
}
