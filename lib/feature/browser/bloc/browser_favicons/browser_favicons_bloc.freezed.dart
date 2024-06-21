// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_favicons_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserFaviconsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri> uris) fetchItems,
    required TResult Function(Uri uri, String? faviconURL) setItem,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Uri> uris)? fetchItems,
    TResult? Function(Uri uri, String? faviconURL)? setItem,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri> uris)? fetchItems,
    TResult Function(Uri uri, String? faviconURL)? setItem,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchItems value) fetchItems,
    required TResult Function(_SetItem value) setItem,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchItems value)? fetchItems,
    TResult? Function(_SetItem value)? setItem,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchItems value)? fetchItems,
    TResult Function(_SetItem value)? setItem,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserFaviconsEventCopyWith<$Res> {
  factory $BrowserFaviconsEventCopyWith(BrowserFaviconsEvent value,
          $Res Function(BrowserFaviconsEvent) then) =
      _$BrowserFaviconsEventCopyWithImpl<$Res, BrowserFaviconsEvent>;
}

/// @nodoc
class _$BrowserFaviconsEventCopyWithImpl<$Res,
        $Val extends BrowserFaviconsEvent>
    implements $BrowserFaviconsEventCopyWith<$Res> {
  _$BrowserFaviconsEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$FetchItemsImplCopyWith<$Res> {
  factory _$$FetchItemsImplCopyWith(
          _$FetchItemsImpl value, $Res Function(_$FetchItemsImpl) then) =
      __$$FetchItemsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Uri> uris});
}

/// @nodoc
class __$$FetchItemsImplCopyWithImpl<$Res>
    extends _$BrowserFaviconsEventCopyWithImpl<$Res, _$FetchItemsImpl>
    implements _$$FetchItemsImplCopyWith<$Res> {
  __$$FetchItemsImplCopyWithImpl(
      _$FetchItemsImpl _value, $Res Function(_$FetchItemsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uris = null,
  }) {
    return _then(_$FetchItemsImpl(
      uris: null == uris
          ? _value._uris
          : uris // ignore: cast_nullable_to_non_nullable
              as List<Uri>,
    ));
  }
}

/// @nodoc

class _$FetchItemsImpl implements _FetchItems {
  const _$FetchItemsImpl({required final List<Uri> uris}) : _uris = uris;

  final List<Uri> _uris;
  @override
  List<Uri> get uris {
    if (_uris is EqualUnmodifiableListView) return _uris;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uris);
  }

  @override
  String toString() {
    return 'BrowserFaviconsEvent.fetchItems(uris: $uris)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchItemsImpl &&
            const DeepCollectionEquality().equals(other._uris, _uris));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_uris));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchItemsImplCopyWith<_$FetchItemsImpl> get copyWith =>
      __$$FetchItemsImplCopyWithImpl<_$FetchItemsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri> uris) fetchItems,
    required TResult Function(Uri uri, String? faviconURL) setItem,
  }) {
    return fetchItems(uris);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Uri> uris)? fetchItems,
    TResult? Function(Uri uri, String? faviconURL)? setItem,
  }) {
    return fetchItems?.call(uris);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri> uris)? fetchItems,
    TResult Function(Uri uri, String? faviconURL)? setItem,
    required TResult orElse(),
  }) {
    if (fetchItems != null) {
      return fetchItems(uris);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchItems value) fetchItems,
    required TResult Function(_SetItem value) setItem,
  }) {
    return fetchItems(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchItems value)? fetchItems,
    TResult? Function(_SetItem value)? setItem,
  }) {
    return fetchItems?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchItems value)? fetchItems,
    TResult Function(_SetItem value)? setItem,
    required TResult orElse(),
  }) {
    if (fetchItems != null) {
      return fetchItems(this);
    }
    return orElse();
  }
}

abstract class _FetchItems implements BrowserFaviconsEvent {
  const factory _FetchItems({required final List<Uri> uris}) = _$FetchItemsImpl;

  List<Uri> get uris;
  @JsonKey(ignore: true)
  _$$FetchItemsImplCopyWith<_$FetchItemsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetItemImplCopyWith<$Res> {
  factory _$$SetItemImplCopyWith(
          _$SetItemImpl value, $Res Function(_$SetItemImpl) then) =
      __$$SetItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Uri uri, String? faviconURL});
}

/// @nodoc
class __$$SetItemImplCopyWithImpl<$Res>
    extends _$BrowserFaviconsEventCopyWithImpl<$Res, _$SetItemImpl>
    implements _$$SetItemImplCopyWith<$Res> {
  __$$SetItemImplCopyWithImpl(
      _$SetItemImpl _value, $Res Function(_$SetItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uri = null,
    Object? faviconURL = freezed,
  }) {
    return _then(_$SetItemImpl(
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as Uri,
      faviconURL: freezed == faviconURL
          ? _value.faviconURL
          : faviconURL // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SetItemImpl implements _SetItem {
  const _$SetItemImpl({required this.uri, required this.faviconURL});

  @override
  final Uri uri;
  @override
  final String? faviconURL;

  @override
  String toString() {
    return 'BrowserFaviconsEvent.setItem(uri: $uri, faviconURL: $faviconURL)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetItemImpl &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.faviconURL, faviconURL) ||
                other.faviconURL == faviconURL));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uri, faviconURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetItemImplCopyWith<_$SetItemImpl> get copyWith =>
      __$$SetItemImplCopyWithImpl<_$SetItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(List<Uri> uris) fetchItems,
    required TResult Function(Uri uri, String? faviconURL) setItem,
  }) {
    return setItem(uri, faviconURL);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(List<Uri> uris)? fetchItems,
    TResult? Function(Uri uri, String? faviconURL)? setItem,
  }) {
    return setItem?.call(uri, faviconURL);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(List<Uri> uris)? fetchItems,
    TResult Function(Uri uri, String? faviconURL)? setItem,
    required TResult orElse(),
  }) {
    if (setItem != null) {
      return setItem(uri, faviconURL);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FetchItems value) fetchItems,
    required TResult Function(_SetItem value) setItem,
  }) {
    return setItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FetchItems value)? fetchItems,
    TResult? Function(_SetItem value)? setItem,
  }) {
    return setItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FetchItems value)? fetchItems,
    TResult Function(_SetItem value)? setItem,
    required TResult orElse(),
  }) {
    if (setItem != null) {
      return setItem(this);
    }
    return orElse();
  }
}

abstract class _SetItem implements BrowserFaviconsEvent {
  const factory _SetItem(
      {required final Uri uri,
      required final String? faviconURL}) = _$SetItemImpl;

  Uri get uri;
  String? get faviconURL;
  @JsonKey(ignore: true)
  _$$SetItemImplCopyWith<_$SetItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrowserFaviconsState {
  Map<Uri, String?> get items => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrowserFaviconsStateCopyWith<BrowserFaviconsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserFaviconsStateCopyWith<$Res> {
  factory $BrowserFaviconsStateCopyWith(BrowserFaviconsState value,
          $Res Function(BrowserFaviconsState) then) =
      _$BrowserFaviconsStateCopyWithImpl<$Res, BrowserFaviconsState>;
  @useResult
  $Res call({Map<Uri, String?> items});
}

/// @nodoc
class _$BrowserFaviconsStateCopyWithImpl<$Res,
        $Val extends BrowserFaviconsState>
    implements $BrowserFaviconsStateCopyWith<$Res> {
  _$BrowserFaviconsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<Uri, String?>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserFaviconsStateImplCopyWith<$Res>
    implements $BrowserFaviconsStateCopyWith<$Res> {
  factory _$$BrowserFaviconsStateImplCopyWith(_$BrowserFaviconsStateImpl value,
          $Res Function(_$BrowserFaviconsStateImpl) then) =
      __$$BrowserFaviconsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<Uri, String?> items});
}

/// @nodoc
class __$$BrowserFaviconsStateImplCopyWithImpl<$Res>
    extends _$BrowserFaviconsStateCopyWithImpl<$Res, _$BrowserFaviconsStateImpl>
    implements _$$BrowserFaviconsStateImplCopyWith<$Res> {
  __$$BrowserFaviconsStateImplCopyWithImpl(_$BrowserFaviconsStateImpl _value,
      $Res Function(_$BrowserFaviconsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$BrowserFaviconsStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as Map<Uri, String?>,
    ));
  }
}

/// @nodoc

class _$BrowserFaviconsStateImpl implements _BrowserFaviconsState {
  const _$BrowserFaviconsStateImpl({required final Map<Uri, String?> items})
      : _items = items;

  final Map<Uri, String?> _items;
  @override
  Map<Uri, String?> get items {
    if (_items is EqualUnmodifiableMapView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_items);
  }

  @override
  String toString() {
    return 'BrowserFaviconsState(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserFaviconsStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserFaviconsStateImplCopyWith<_$BrowserFaviconsStateImpl>
      get copyWith =>
          __$$BrowserFaviconsStateImplCopyWithImpl<_$BrowserFaviconsStateImpl>(
              this, _$identity);
}

abstract class _BrowserFaviconsState implements BrowserFaviconsState {
  const factory _BrowserFaviconsState(
      {required final Map<Uri, String?> items}) = _$BrowserFaviconsStateImpl;

  @override
  Map<Uri, String?> get items;
  @override
  @JsonKey(ignore: true)
  _$$BrowserFaviconsStateImplCopyWith<_$BrowserFaviconsStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
