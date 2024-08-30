// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tabs_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserTabsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabsEventCopyWith<$Res> {
  factory $BrowserTabsEventCopyWith(
          BrowserTabsEvent value, $Res Function(BrowserTabsEvent) then) =
      _$BrowserTabsEventCopyWithImpl<$Res, BrowserTabsEvent>;
}

/// @nodoc
class _$BrowserTabsEventCopyWithImpl<$Res, $Val extends BrowserTabsEvent>
    implements $BrowserTabsEventCopyWith<$Res> {
  _$BrowserTabsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AddImplCopyWith<$Res> {
  factory _$$AddImplCopyWith(_$AddImpl value, $Res Function(_$AddImpl) then) =
      __$$AddImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uri uri});
}

/// @nodoc
class __$$AddImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$AddImpl>
    implements _$$AddImplCopyWith<$Res> {
  __$$AddImplCopyWithImpl(_$AddImpl _value, $Res Function(_$AddImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uri = null,
  }) {
    return _then(_$AddImpl(
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class _$AddImpl with DiagnosticableTreeMixin implements _Add {
  const _$AddImpl({required this.uri});

  @override
  final Uri uri;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.add(uri: $uri)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.add'))
      ..add(DiagnosticsProperty('uri', uri));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddImpl &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uri);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddImplCopyWith<_$AddImpl> get copyWith =>
      __$$AddImplCopyWithImpl<_$AddImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return add(uri);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return add?.call(uri);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(uri);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class _Add implements BrowserTabsEvent {
  const factory _Add({required final Uri uri}) = _$AddImpl;

  Uri get uri;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddImplCopyWith<_$AddImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddEmptyImplCopyWith<$Res> {
  factory _$$AddEmptyImplCopyWith(
          _$AddEmptyImpl value, $Res Function(_$AddEmptyImpl) then) =
      __$$AddEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AddEmptyImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$AddEmptyImpl>
    implements _$$AddEmptyImplCopyWith<$Res> {
  __$$AddEmptyImplCopyWithImpl(
      _$AddEmptyImpl _value, $Res Function(_$AddEmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AddEmptyImpl with DiagnosticableTreeMixin implements _AddEmpty {
  const _$AddEmptyImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.addEmpty()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BrowserTabsEvent.addEmpty'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AddEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return addEmpty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return addEmpty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (addEmpty != null) {
      return addEmpty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return addEmpty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return addEmpty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (addEmpty != null) {
      return addEmpty(this);
    }
    return orElse();
  }
}

abstract class _AddEmpty implements BrowserTabsEvent {
  const factory _AddEmpty() = _$AddEmptyImpl;
}

/// @nodoc
abstract class _$$SetUrlImplCopyWith<$Res> {
  factory _$$SetUrlImplCopyWith(
          _$SetUrlImpl value, $Res Function(_$SetUrlImpl) then) =
      __$$SetUrlImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, Uri uri});
}

/// @nodoc
class __$$SetUrlImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetUrlImpl>
    implements _$$SetUrlImplCopyWith<$Res> {
  __$$SetUrlImplCopyWithImpl(
      _$SetUrlImpl _value, $Res Function(_$SetUrlImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uri = null,
  }) {
    return _then(_$SetUrlImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
    ));
  }
}

/// @nodoc

class _$SetUrlImpl with DiagnosticableTreeMixin implements _SetUrl {
  const _$SetUrlImpl({required this.id, required this.uri});

  @override
  final String id;
  @override
  final Uri uri;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setUrl(id: $id, uri: $uri)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setUrl'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('uri', uri));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetUrlImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, uri);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetUrlImplCopyWith<_$SetUrlImpl> get copyWith =>
      __$$SetUrlImplCopyWithImpl<_$SetUrlImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setUrl(id, uri);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setUrl?.call(id, uri);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setUrl != null) {
      return setUrl(id, uri);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setUrl(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setUrl?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setUrl != null) {
      return setUrl(this);
    }
    return orElse();
  }
}

abstract class _SetUrl implements BrowserTabsEvent {
  const factory _SetUrl({required final String id, required final Uri uri}) =
      _$SetUrlImpl;

  String get id;
  Uri get uri;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetUrlImplCopyWith<_$SetUrlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetScreenshotImplCopyWith<$Res> {
  factory _$$SetScreenshotImplCopyWith(
          _$SetScreenshotImpl value, $Res Function(_$SetScreenshotImpl) then) =
      __$$SetScreenshotImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String imageId});
}

/// @nodoc
class __$$SetScreenshotImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetScreenshotImpl>
    implements _$$SetScreenshotImplCopyWith<$Res> {
  __$$SetScreenshotImplCopyWithImpl(
      _$SetScreenshotImpl _value, $Res Function(_$SetScreenshotImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageId = null,
  }) {
    return _then(_$SetScreenshotImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageId: null == imageId
          ? _value.imageId
          : imageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetScreenshotImpl
    with DiagnosticableTreeMixin
    implements _SetScreenshot {
  const _$SetScreenshotImpl({required this.id, required this.imageId});

  @override
  final String id;
  @override
  final String imageId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setScreenshot(id: $id, imageId: $imageId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setScreenshot'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('imageId', imageId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetScreenshotImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageId, imageId) || other.imageId == imageId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, imageId);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetScreenshotImplCopyWith<_$SetScreenshotImpl> get copyWith =>
      __$$SetScreenshotImplCopyWithImpl<_$SetScreenshotImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setScreenshot(id, imageId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setScreenshot?.call(id, imageId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setScreenshot != null) {
      return setScreenshot(id, imageId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setScreenshot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setScreenshot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setScreenshot != null) {
      return setScreenshot(this);
    }
    return orElse();
  }
}

abstract class _SetScreenshot implements BrowserTabsEvent {
  const factory _SetScreenshot(
      {required final String id,
      required final String imageId}) = _$SetScreenshotImpl;

  String get id;
  String get imageId;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetScreenshotImplCopyWith<_$SetScreenshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetStateImplCopyWith<$Res> {
  factory _$$SetStateImplCopyWith(
          _$SetStateImpl value, $Res Function(_$SetStateImpl) then) =
      __$$SetStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String id,
      BrowserTabStateType? state,
      int? progress,
      String? errorMessage,
      String? title,
      bool? canGoBack,
      bool? canGoForward,
      VoidCallback? goBack,
      VoidCallback? goForward,
      VoidCallback? refresh,
      Map<String, BrowserBasicAuthCreds>? basicAuthCreds});
}

/// @nodoc
class __$$SetStateImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetStateImpl>
    implements _$$SetStateImplCopyWith<$Res> {
  __$$SetStateImplCopyWithImpl(
      _$SetStateImpl _value, $Res Function(_$SetStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? state = freezed,
    Object? progress = freezed,
    Object? errorMessage = freezed,
    Object? title = freezed,
    Object? canGoBack = freezed,
    Object? canGoForward = freezed,
    Object? goBack = freezed,
    Object? goForward = freezed,
    Object? refresh = freezed,
    Object? basicAuthCreds = freezed,
  }) {
    return _then(_$SetStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as BrowserTabStateType?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      canGoBack: freezed == canGoBack
          ? _value.canGoBack
          : canGoBack // ignore: cast_nullable_to_non_nullable
              as bool?,
      canGoForward: freezed == canGoForward
          ? _value.canGoForward
          : canGoForward // ignore: cast_nullable_to_non_nullable
              as bool?,
      goBack: freezed == goBack
          ? _value.goBack
          : goBack // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      goForward: freezed == goForward
          ? _value.goForward
          : goForward // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      refresh: freezed == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      basicAuthCreds: freezed == basicAuthCreds
          ? _value._basicAuthCreds
          : basicAuthCreds // ignore: cast_nullable_to_non_nullable
              as Map<String, BrowserBasicAuthCreds>?,
    ));
  }
}

/// @nodoc

class _$SetStateImpl with DiagnosticableTreeMixin implements _SetState {
  const _$SetStateImpl(
      {required this.id,
      this.state,
      this.progress,
      this.errorMessage,
      this.title,
      this.canGoBack,
      this.canGoForward,
      this.goBack,
      this.goForward,
      this.refresh,
      final Map<String, BrowserBasicAuthCreds>? basicAuthCreds})
      : _basicAuthCreds = basicAuthCreds;

  @override
  final String id;
  @override
  final BrowserTabStateType? state;
  @override
  final int? progress;
  @override
  final String? errorMessage;
  @override
  final String? title;
  @override
  final bool? canGoBack;
  @override
  final bool? canGoForward;
  @override
  final VoidCallback? goBack;
  @override
  final VoidCallback? goForward;
  @override
  final VoidCallback? refresh;
  final Map<String, BrowserBasicAuthCreds>? _basicAuthCreds;
  @override
  Map<String, BrowserBasicAuthCreds>? get basicAuthCreds {
    final value = _basicAuthCreds;
    if (value == null) return null;
    if (_basicAuthCreds is EqualUnmodifiableMapView) return _basicAuthCreds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setState(id: $id, state: $state, progress: $progress, errorMessage: $errorMessage, title: $title, canGoBack: $canGoBack, canGoForward: $canGoForward, goBack: $goBack, goForward: $goForward, refresh: $refresh, basicAuthCreds: $basicAuthCreds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setState'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('state', state))
      ..add(DiagnosticsProperty('progress', progress))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('canGoBack', canGoBack))
      ..add(DiagnosticsProperty('canGoForward', canGoForward))
      ..add(DiagnosticsProperty('goBack', goBack))
      ..add(DiagnosticsProperty('goForward', goForward))
      ..add(DiagnosticsProperty('refresh', refresh))
      ..add(DiagnosticsProperty('basicAuthCreds', basicAuthCreds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.canGoBack, canGoBack) ||
                other.canGoBack == canGoBack) &&
            (identical(other.canGoForward, canGoForward) ||
                other.canGoForward == canGoForward) &&
            (identical(other.goBack, goBack) || other.goBack == goBack) &&
            (identical(other.goForward, goForward) ||
                other.goForward == goForward) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            const DeepCollectionEquality()
                .equals(other._basicAuthCreds, _basicAuthCreds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      state,
      progress,
      errorMessage,
      title,
      canGoBack,
      canGoForward,
      goBack,
      goForward,
      refresh,
      const DeepCollectionEquality().hash(_basicAuthCreds));

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetStateImplCopyWith<_$SetStateImpl> get copyWith =>
      __$$SetStateImplCopyWithImpl<_$SetStateImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setState(id, state, progress, errorMessage, title, canGoBack,
        canGoForward, goBack, goForward, refresh, basicAuthCreds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setState?.call(id, state, progress, errorMessage, title, canGoBack,
        canGoForward, goBack, goForward, refresh, basicAuthCreds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setState != null) {
      return setState(id, state, progress, errorMessage, title, canGoBack,
          canGoForward, goBack, goForward, refresh, basicAuthCreds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setState(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setState?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setState != null) {
      return setState(this);
    }
    return orElse();
  }
}

abstract class _SetState implements BrowserTabsEvent {
  const factory _SetState(
          {required final String id,
          final BrowserTabStateType? state,
          final int? progress,
          final String? errorMessage,
          final String? title,
          final bool? canGoBack,
          final bool? canGoForward,
          final VoidCallback? goBack,
          final VoidCallback? goForward,
          final VoidCallback? refresh,
          final Map<String, BrowserBasicAuthCreds>? basicAuthCreds}) =
      _$SetStateImpl;

  String get id;
  BrowserTabStateType? get state;
  int? get progress;
  String? get errorMessage;
  String? get title;
  bool? get canGoBack;
  bool? get canGoForward;
  VoidCallback? get goBack;
  VoidCallback? get goForward;
  VoidCallback? get refresh;
  Map<String, BrowserBasicAuthCreds>? get basicAuthCreds;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetStateImplCopyWith<_$SetStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveImplCopyWith<$Res> {
  factory _$$RemoveImplCopyWith(
          _$RemoveImpl value, $Res Function(_$RemoveImpl) then) =
      __$$RemoveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RemoveImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$RemoveImpl>
    implements _$$RemoveImplCopyWith<$Res> {
  __$$RemoveImplCopyWithImpl(
      _$RemoveImpl _value, $Res Function(_$RemoveImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RemoveImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveImpl with DiagnosticableTreeMixin implements _Remove {
  const _$RemoveImpl({required this.id});

  @override
  final String id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.remove(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.remove'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveImplCopyWith<_$RemoveImpl> get copyWith =>
      __$$RemoveImplCopyWithImpl<_$RemoveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return remove(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return remove?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return remove?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(this);
    }
    return orElse();
  }
}

abstract class _Remove implements BrowserTabsEvent {
  const factory _Remove({required final String id}) = _$RemoveImpl;

  String get id;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveImplCopyWith<_$RemoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetActiveImplCopyWith<$Res> {
  factory _$$SetActiveImplCopyWith(
          _$SetActiveImpl value, $Res Function(_$SetActiveImpl) then) =
      __$$SetActiveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$SetActiveImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetActiveImpl>
    implements _$$SetActiveImplCopyWith<$Res> {
  __$$SetActiveImplCopyWithImpl(
      _$SetActiveImpl _value, $Res Function(_$SetActiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$SetActiveImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetActiveImpl with DiagnosticableTreeMixin implements _SetActive {
  const _$SetActiveImpl({required this.id});

  @override
  final String id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setActive(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setActive'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetActiveImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetActiveImplCopyWith<_$SetActiveImpl> get copyWith =>
      __$$SetActiveImplCopyWithImpl<_$SetActiveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setActive(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setActive?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setActive != null) {
      return setActive(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setActive(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setActive?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setActive != null) {
      return setActive(this);
    }
    return orElse();
  }
}

abstract class _SetActive implements BrowserTabsEvent {
  const factory _SetActive({required final String id}) = _$SetActiveImpl;

  String get id;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetActiveImplCopyWith<_$SetActiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CloseAllImplCopyWith<$Res> {
  factory _$$CloseAllImplCopyWith(
          _$CloseAllImpl value, $Res Function(_$CloseAllImpl) then) =
      __$$CloseAllImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CloseAllImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$CloseAllImpl>
    implements _$$CloseAllImplCopyWith<$Res> {
  __$$CloseAllImplCopyWithImpl(
      _$CloseAllImpl _value, $Res Function(_$CloseAllImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CloseAllImpl with DiagnosticableTreeMixin implements _CloseAll {
  const _$CloseAllImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.closeAll()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BrowserTabsEvent.closeAll'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CloseAllImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return closeAll();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return closeAll?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (closeAll != null) {
      return closeAll();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return closeAll(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return closeAll?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (closeAll != null) {
      return closeAll(this);
    }
    return orElse();
  }
}

abstract class _CloseAll implements BrowserTabsEvent {
  const factory _CloseAll() = _$CloseAllImpl;
}

/// @nodoc
abstract class _$$SetTabsImplCopyWith<$Res> {
  factory _$$SetTabsImplCopyWith(
          _$SetTabsImpl value, $Res Function(_$SetTabsImpl) then) =
      __$$SetTabsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BrowserTab> tabs});
}

/// @nodoc
class __$$SetTabsImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetTabsImpl>
    implements _$$SetTabsImplCopyWith<$Res> {
  __$$SetTabsImplCopyWithImpl(
      _$SetTabsImpl _value, $Res Function(_$SetTabsImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabs = null,
  }) {
    return _then(_$SetTabsImpl(
      tabs: null == tabs
          ? _value._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTab>,
    ));
  }
}

/// @nodoc

class _$SetTabsImpl with DiagnosticableTreeMixin implements _SetTabs {
  const _$SetTabsImpl({required final List<BrowserTab> tabs}) : _tabs = tabs;

  final List<BrowserTab> _tabs;
  @override
  List<BrowserTab> get tabs {
    if (_tabs is EqualUnmodifiableListView) return _tabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setTabs(tabs: $tabs)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setTabs'))
      ..add(DiagnosticsProperty('tabs', tabs));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetTabsImpl &&
            const DeepCollectionEquality().equals(other._tabs, _tabs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tabs));

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetTabsImplCopyWith<_$SetTabsImpl> get copyWith =>
      __$$SetTabsImplCopyWithImpl<_$SetTabsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setTabs(tabs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setTabs?.call(tabs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setTabs != null) {
      return setTabs(tabs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setTabs(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setTabs?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setTabs != null) {
      return setTabs(this);
    }
    return orElse();
  }
}

abstract class _SetTabs implements BrowserTabsEvent {
  const factory _SetTabs({required final List<BrowserTab> tabs}) =
      _$SetTabsImpl;

  List<BrowserTab> get tabs;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetTabsImplCopyWith<_$SetTabsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetActiveTabIdImplCopyWith<$Res> {
  factory _$$SetActiveTabIdImplCopyWith(_$SetActiveTabIdImpl value,
          $Res Function(_$SetActiveTabIdImpl) then) =
      __$$SetActiveTabIdImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? id});
}

/// @nodoc
class __$$SetActiveTabIdImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetActiveTabIdImpl>
    implements _$$SetActiveTabIdImplCopyWith<$Res> {
  __$$SetActiveTabIdImplCopyWithImpl(
      _$SetActiveTabIdImpl _value, $Res Function(_$SetActiveTabIdImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$SetActiveTabIdImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SetActiveTabIdImpl
    with DiagnosticableTreeMixin
    implements _SetActiveTabId {
  const _$SetActiveTabIdImpl({required this.id});

  @override
  final String? id;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setActiveTabId(id: $id)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setActiveTabId'))
      ..add(DiagnosticsProperty('id', id));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetActiveTabIdImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetActiveTabIdImplCopyWith<_$SetActiveTabIdImpl> get copyWith =>
      __$$SetActiveTabIdImplCopyWithImpl<_$SetActiveTabIdImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setActiveTabId(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setActiveTabId?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setActiveTabId != null) {
      return setActiveTabId(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setActiveTabId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setActiveTabId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setActiveTabId != null) {
      return setActiveTabId(this);
    }
    return orElse();
  }
}

abstract class _SetActiveTabId implements BrowserTabsEvent {
  const factory _SetActiveTabId({required final String? id}) =
      _$SetActiveTabIdImpl;

  String? get id;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetActiveTabIdImplCopyWith<_$SetActiveTabIdImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearCacheImplCopyWith<$Res> {
  factory _$$ClearCacheImplCopyWith(
          _$ClearCacheImpl value, $Res Function(_$ClearCacheImpl) then) =
      __$$ClearCacheImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearCacheImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$ClearCacheImpl>
    implements _$$ClearCacheImplCopyWith<$Res> {
  __$$ClearCacheImplCopyWithImpl(
      _$ClearCacheImpl _value, $Res Function(_$ClearCacheImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClearCacheImpl with DiagnosticableTreeMixin implements _ClearCache {
  const _$ClearCacheImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.clearCache()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'BrowserTabsEvent.clearCache'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearCacheImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return clearCache();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return clearCache?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (clearCache != null) {
      return clearCache();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return clearCache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return clearCache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (clearCache != null) {
      return clearCache(this);
    }
    return orElse();
  }
}

abstract class _ClearCache implements BrowserTabsEvent {
  const factory _ClearCache() = _$ClearCacheImpl;
}

/// @nodoc
abstract class _$$CacheClearedImplCopyWith<$Res> {
  factory _$$CacheClearedImplCopyWith(
          _$CacheClearedImpl value, $Res Function(_$CacheClearedImpl) then) =
      __$$CacheClearedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CacheClearedImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$CacheClearedImpl>
    implements _$$CacheClearedImplCopyWith<$Res> {
  __$$CacheClearedImplCopyWithImpl(
      _$CacheClearedImpl _value, $Res Function(_$CacheClearedImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CacheClearedImpl with DiagnosticableTreeMixin implements _CacheCleared {
  const _$CacheClearedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.cacheCleared()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', 'BrowserTabsEvent.cacheCleared'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CacheClearedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return cacheCleared();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return cacheCleared?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (cacheCleared != null) {
      return cacheCleared();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return cacheCleared(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return cacheCleared?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (cacheCleared != null) {
      return cacheCleared(this);
    }
    return orElse();
  }
}

abstract class _CacheCleared implements BrowserTabsEvent {
  const factory _CacheCleared() = _$CacheClearedImpl;
}

/// @nodoc
abstract class _$$SetSearchTextImplCopyWith<$Res> {
  factory _$$SetSearchTextImplCopyWith(
          _$SetSearchTextImpl value, $Res Function(_$SetSearchTextImpl) then) =
      __$$SetSearchTextImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$$SetSearchTextImplCopyWithImpl<$Res>
    extends _$BrowserTabsEventCopyWithImpl<$Res, _$SetSearchTextImpl>
    implements _$$SetSearchTextImplCopyWith<$Res> {
  __$$SetSearchTextImplCopyWithImpl(
      _$SetSearchTextImpl _value, $Res Function(_$SetSearchTextImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_$SetSearchTextImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetSearchTextImpl
    with DiagnosticableTreeMixin
    implements _SetSearchText {
  const _$SetSearchTextImpl({required this.text});

  @override
  final String text;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsEvent.setSearchText(text: $text)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsEvent.setSearchText'))
      ..add(DiagnosticsProperty('text', text));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetSearchTextImpl &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetSearchTextImplCopyWith<_$SetSearchTextImpl> get copyWith =>
      __$$SetSearchTextImplCopyWithImpl<_$SetSearchTextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri uri) add,
    required TResult Function() addEmpty,
    required TResult Function(String id, Uri uri) setUrl,
    required TResult Function(String id, String imageId) setScreenshot,
    required TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)
        setState,
    required TResult Function(String id) remove,
    required TResult Function(String id) setActive,
    required TResult Function() closeAll,
    required TResult Function(List<BrowserTab> tabs) setTabs,
    required TResult Function(String? id) setActiveTabId,
    required TResult Function() clearCache,
    required TResult Function() cacheCleared,
    required TResult Function(String text) setSearchText,
  }) {
    return setSearchText(text);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri uri)? add,
    TResult? Function()? addEmpty,
    TResult? Function(String id, Uri uri)? setUrl,
    TResult? Function(String id, String imageId)? setScreenshot,
    TResult? Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult? Function(String id)? remove,
    TResult? Function(String id)? setActive,
    TResult? Function()? closeAll,
    TResult? Function(List<BrowserTab> tabs)? setTabs,
    TResult? Function(String? id)? setActiveTabId,
    TResult? Function()? clearCache,
    TResult? Function()? cacheCleared,
    TResult? Function(String text)? setSearchText,
  }) {
    return setSearchText?.call(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri uri)? add,
    TResult Function()? addEmpty,
    TResult Function(String id, Uri uri)? setUrl,
    TResult Function(String id, String imageId)? setScreenshot,
    TResult Function(
            String id,
            BrowserTabStateType? state,
            int? progress,
            String? errorMessage,
            String? title,
            bool? canGoBack,
            bool? canGoForward,
            VoidCallback? goBack,
            VoidCallback? goForward,
            VoidCallback? refresh,
            Map<String, BrowserBasicAuthCreds>? basicAuthCreds)?
        setState,
    TResult Function(String id)? remove,
    TResult Function(String id)? setActive,
    TResult Function()? closeAll,
    TResult Function(List<BrowserTab> tabs)? setTabs,
    TResult Function(String? id)? setActiveTabId,
    TResult Function()? clearCache,
    TResult Function()? cacheCleared,
    TResult Function(String text)? setSearchText,
    required TResult orElse(),
  }) {
    if (setSearchText != null) {
      return setSearchText(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_AddEmpty value) addEmpty,
    required TResult Function(_SetUrl value) setUrl,
    required TResult Function(_SetScreenshot value) setScreenshot,
    required TResult Function(_SetState value) setState,
    required TResult Function(_Remove value) remove,
    required TResult Function(_SetActive value) setActive,
    required TResult Function(_CloseAll value) closeAll,
    required TResult Function(_SetTabs value) setTabs,
    required TResult Function(_SetActiveTabId value) setActiveTabId,
    required TResult Function(_ClearCache value) clearCache,
    required TResult Function(_CacheCleared value) cacheCleared,
    required TResult Function(_SetSearchText value) setSearchText,
  }) {
    return setSearchText(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_AddEmpty value)? addEmpty,
    TResult? Function(_SetUrl value)? setUrl,
    TResult? Function(_SetScreenshot value)? setScreenshot,
    TResult? Function(_SetState value)? setState,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_SetActive value)? setActive,
    TResult? Function(_CloseAll value)? closeAll,
    TResult? Function(_SetTabs value)? setTabs,
    TResult? Function(_SetActiveTabId value)? setActiveTabId,
    TResult? Function(_ClearCache value)? clearCache,
    TResult? Function(_CacheCleared value)? cacheCleared,
    TResult? Function(_SetSearchText value)? setSearchText,
  }) {
    return setSearchText?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_AddEmpty value)? addEmpty,
    TResult Function(_SetUrl value)? setUrl,
    TResult Function(_SetScreenshot value)? setScreenshot,
    TResult Function(_SetState value)? setState,
    TResult Function(_Remove value)? remove,
    TResult Function(_SetActive value)? setActive,
    TResult Function(_CloseAll value)? closeAll,
    TResult Function(_SetTabs value)? setTabs,
    TResult Function(_SetActiveTabId value)? setActiveTabId,
    TResult Function(_ClearCache value)? clearCache,
    TResult Function(_CacheCleared value)? cacheCleared,
    TResult Function(_SetSearchText value)? setSearchText,
    required TResult orElse(),
  }) {
    if (setSearchText != null) {
      return setSearchText(this);
    }
    return orElse();
  }
}

abstract class _SetSearchText implements BrowserTabsEvent {
  const factory _SetSearchText({required final String text}) =
      _$SetSearchTextImpl;

  String get text;

  /// Create a copy of BrowserTabsEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetSearchTextImplCopyWith<_$SetSearchTextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrowserTabsState {
  List<BrowserTab> get tabs => throw _privateConstructorUsedError;
  String? get currentTabId => throw _privateConstructorUsedError;
  Map<String, BrowserTabState> get tabsState =>
      throw _privateConstructorUsedError;
  bool get clearCacheOnNextTab => throw _privateConstructorUsedError;
  String get searchText => throw _privateConstructorUsedError;

  /// Create a copy of BrowserTabsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserTabsStateCopyWith<BrowserTabsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabsStateCopyWith<$Res> {
  factory $BrowserTabsStateCopyWith(
          BrowserTabsState value, $Res Function(BrowserTabsState) then) =
      _$BrowserTabsStateCopyWithImpl<$Res, BrowserTabsState>;
  @useResult
  $Res call(
      {List<BrowserTab> tabs,
      String? currentTabId,
      Map<String, BrowserTabState> tabsState,
      bool clearCacheOnNextTab,
      String searchText});
}

/// @nodoc
class _$BrowserTabsStateCopyWithImpl<$Res, $Val extends BrowserTabsState>
    implements $BrowserTabsStateCopyWith<$Res> {
  _$BrowserTabsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserTabsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabs = null,
    Object? currentTabId = freezed,
    Object? tabsState = null,
    Object? clearCacheOnNextTab = null,
    Object? searchText = null,
  }) {
    return _then(_value.copyWith(
      tabs: null == tabs
          ? _value.tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTab>,
      currentTabId: freezed == currentTabId
          ? _value.currentTabId
          : currentTabId // ignore: cast_nullable_to_non_nullable
              as String?,
      tabsState: null == tabsState
          ? _value.tabsState
          : tabsState // ignore: cast_nullable_to_non_nullable
              as Map<String, BrowserTabState>,
      clearCacheOnNextTab: null == clearCacheOnNextTab
          ? _value.clearCacheOnNextTab
          : clearCacheOnNextTab // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserTabsStateImplCopyWith<$Res>
    implements $BrowserTabsStateCopyWith<$Res> {
  factory _$$BrowserTabsStateImplCopyWith(_$BrowserTabsStateImpl value,
          $Res Function(_$BrowserTabsStateImpl) then) =
      __$$BrowserTabsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BrowserTab> tabs,
      String? currentTabId,
      Map<String, BrowserTabState> tabsState,
      bool clearCacheOnNextTab,
      String searchText});
}

/// @nodoc
class __$$BrowserTabsStateImplCopyWithImpl<$Res>
    extends _$BrowserTabsStateCopyWithImpl<$Res, _$BrowserTabsStateImpl>
    implements _$$BrowserTabsStateImplCopyWith<$Res> {
  __$$BrowserTabsStateImplCopyWithImpl(_$BrowserTabsStateImpl _value,
      $Res Function(_$BrowserTabsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserTabsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tabs = null,
    Object? currentTabId = freezed,
    Object? tabsState = null,
    Object? clearCacheOnNextTab = null,
    Object? searchText = null,
  }) {
    return _then(_$BrowserTabsStateImpl(
      tabs: null == tabs
          ? _value._tabs
          : tabs // ignore: cast_nullable_to_non_nullable
              as List<BrowserTab>,
      currentTabId: freezed == currentTabId
          ? _value.currentTabId
          : currentTabId // ignore: cast_nullable_to_non_nullable
              as String?,
      tabsState: null == tabsState
          ? _value._tabsState
          : tabsState // ignore: cast_nullable_to_non_nullable
              as Map<String, BrowserTabState>,
      clearCacheOnNextTab: null == clearCacheOnNextTab
          ? _value.clearCacheOnNextTab
          : clearCacheOnNextTab // ignore: cast_nullable_to_non_nullable
              as bool,
      searchText: null == searchText
          ? _value.searchText
          : searchText // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BrowserTabsStateImpl
    with DiagnosticableTreeMixin
    implements _BrowserTabsState {
  const _$BrowserTabsStateImpl(
      {required final List<BrowserTab> tabs,
      required this.currentTabId,
      required final Map<String, BrowserTabState> tabsState,
      required this.clearCacheOnNextTab,
      required this.searchText})
      : _tabs = tabs,
        _tabsState = tabsState;

  final List<BrowserTab> _tabs;
  @override
  List<BrowserTab> get tabs {
    if (_tabs is EqualUnmodifiableListView) return _tabs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tabs);
  }

  @override
  final String? currentTabId;
  final Map<String, BrowserTabState> _tabsState;
  @override
  Map<String, BrowserTabState> get tabsState {
    if (_tabsState is EqualUnmodifiableMapView) return _tabsState;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tabsState);
  }

  @override
  final bool clearCacheOnNextTab;
  @override
  final String searchText;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BrowserTabsState(tabs: $tabs, currentTabId: $currentTabId, tabsState: $tabsState, clearCacheOnNextTab: $clearCacheOnNextTab, searchText: $searchText)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BrowserTabsState'))
      ..add(DiagnosticsProperty('tabs', tabs))
      ..add(DiagnosticsProperty('currentTabId', currentTabId))
      ..add(DiagnosticsProperty('tabsState', tabsState))
      ..add(DiagnosticsProperty('clearCacheOnNextTab', clearCacheOnNextTab))
      ..add(DiagnosticsProperty('searchText', searchText));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserTabsStateImpl &&
            const DeepCollectionEquality().equals(other._tabs, _tabs) &&
            (identical(other.currentTabId, currentTabId) ||
                other.currentTabId == currentTabId) &&
            const DeepCollectionEquality()
                .equals(other._tabsState, _tabsState) &&
            (identical(other.clearCacheOnNextTab, clearCacheOnNextTab) ||
                other.clearCacheOnNextTab == clearCacheOnNextTab) &&
            (identical(other.searchText, searchText) ||
                other.searchText == searchText));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tabs),
      currentTabId,
      const DeepCollectionEquality().hash(_tabsState),
      clearCacheOnNextTab,
      searchText);

  /// Create a copy of BrowserTabsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserTabsStateImplCopyWith<_$BrowserTabsStateImpl> get copyWith =>
      __$$BrowserTabsStateImplCopyWithImpl<_$BrowserTabsStateImpl>(
          this, _$identity);
}

abstract class _BrowserTabsState implements BrowserTabsState {
  const factory _BrowserTabsState(
      {required final List<BrowserTab> tabs,
      required final String? currentTabId,
      required final Map<String, BrowserTabState> tabsState,
      required final bool clearCacheOnNextTab,
      required final String searchText}) = _$BrowserTabsStateImpl;

  @override
  List<BrowserTab> get tabs;
  @override
  String? get currentTabId;
  @override
  Map<String, BrowserTabState> get tabsState;
  @override
  bool get clearCacheOnNextTab;
  @override
  String get searchText;

  /// Create a copy of BrowserTabsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserTabsStateImplCopyWith<_$BrowserTabsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
