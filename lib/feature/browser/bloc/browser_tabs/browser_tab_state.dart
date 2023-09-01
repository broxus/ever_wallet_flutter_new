import 'dart:ui';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'browser_tab_state.freezed.dart';

enum BrowserTabStateType {
  initial,
  loading,
  loaded,
  error,
}

@Freezed(fromJson: false, toJson: false)
class BrowserBasicAuthCreds with _$BrowserBasicAuthCreds {
  const factory BrowserBasicAuthCreds({
    required String username,
    required String password,
  }) = _BrowserBasicAuthCreds;
}

@Freezed(fromJson: false, toJson: false)
class BrowserTabState with _$BrowserTabState {
  const factory BrowserTabState({
    @Default(BrowserTabStateType.initial) final BrowserTabStateType state,
    @Default(0) final int progress,
    @Default(null) final String? errorMessage,
    @Default(null) final String? title,
    @Default(null) final String? faviconUrl,
    @Default(false) final bool canGoBack,
    @Default(false) final bool canGoForward,
    @Default(null) final VoidCallback? goBack,
    @Default(null) final VoidCallback? goForward,
    @Default(null) final VoidCallback? refresh,
    @Default({}) final Map<String, BrowserBasicAuthCreds> basicAuthCreds,
  }) = _BrowserTabState;

  const BrowserTabState._();

  String _basicAuthCredsKey(URLAuthenticationChallenge challenge) =>
      '${challenge.protectionSpace.protocol}//${challenge.protectionSpace.host}:${challenge.protectionSpace.port}:${challenge.protectionSpace.realm}';

  BrowserBasicAuthCreds? getBasicAuthCreds(
    URLAuthenticationChallenge challenge,
  ) {
    return basicAuthCreds[_basicAuthCredsKey(challenge)];
  }

  Map<String, BrowserBasicAuthCreds> setBasicAuthCreds(
    URLAuthenticationChallenge challenge,
    BrowserBasicAuthCreds creds,
  ) {
    return {
      ...basicAuthCreds,
      _basicAuthCredsKey(challenge): creds,
    };
  }
}
