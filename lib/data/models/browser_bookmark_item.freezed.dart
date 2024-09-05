// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_bookmark_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BrowserBookmarkItem _$BrowserBookmarkItemFromJson(Map<String, dynamic> json) {
  return _BrowserBookmarkItem.fromJson(json);
}

/// @nodoc
mixin _$BrowserBookmarkItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @uriJsonConverter
  Uri get url => throw _privateConstructorUsedError;
  double get sortingOrder => throw _privateConstructorUsedError;

  /// Serializes this BrowserBookmarkItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserBookmarkItemCopyWith<BrowserBookmarkItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserBookmarkItemCopyWith<$Res> {
  factory $BrowserBookmarkItemCopyWith(
          BrowserBookmarkItem value, $Res Function(BrowserBookmarkItem) then) =
      _$BrowserBookmarkItemCopyWithImpl<$Res, BrowserBookmarkItem>;
  @useResult
  $Res call(
      {String id,
      String title,
      @uriJsonConverter Uri url,
      double sortingOrder});
}

/// @nodoc
class _$BrowserBookmarkItemCopyWithImpl<$Res, $Val extends BrowserBookmarkItem>
    implements $BrowserBookmarkItemCopyWith<$Res> {
  _$BrowserBookmarkItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? sortingOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserBookmarkItemImplCopyWith<$Res>
    implements $BrowserBookmarkItemCopyWith<$Res> {
  factory _$$BrowserBookmarkItemImplCopyWith(_$BrowserBookmarkItemImpl value,
          $Res Function(_$BrowserBookmarkItemImpl) then) =
      __$$BrowserBookmarkItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      @uriJsonConverter Uri url,
      double sortingOrder});
}

/// @nodoc
class __$$BrowserBookmarkItemImplCopyWithImpl<$Res>
    extends _$BrowserBookmarkItemCopyWithImpl<$Res, _$BrowserBookmarkItemImpl>
    implements _$$BrowserBookmarkItemImplCopyWith<$Res> {
  __$$BrowserBookmarkItemImplCopyWithImpl(_$BrowserBookmarkItemImpl _value,
      $Res Function(_$BrowserBookmarkItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? sortingOrder = null,
  }) {
    return _then(_$BrowserBookmarkItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as Uri,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowserBookmarkItemImpl implements _BrowserBookmarkItem {
  const _$BrowserBookmarkItemImpl(
      {required this.id,
      required this.title,
      @uriJsonConverter required this.url,
      required this.sortingOrder});

  factory _$BrowserBookmarkItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowserBookmarkItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @uriJsonConverter
  final Uri url;
  @override
  final double sortingOrder;

  @override
  String toString() {
    return 'BrowserBookmarkItem(id: $id, title: $title, url: $url, sortingOrder: $sortingOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserBookmarkItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, sortingOrder);

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserBookmarkItemImplCopyWith<_$BrowserBookmarkItemImpl> get copyWith =>
      __$$BrowserBookmarkItemImplCopyWithImpl<_$BrowserBookmarkItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowserBookmarkItemImplToJson(
      this,
    );
  }
}

abstract class _BrowserBookmarkItem implements BrowserBookmarkItem {
  const factory _BrowserBookmarkItem(
      {required final String id,
      required final String title,
      @uriJsonConverter required final Uri url,
      required final double sortingOrder}) = _$BrowserBookmarkItemImpl;

  factory _BrowserBookmarkItem.fromJson(Map<String, dynamic> json) =
      _$BrowserBookmarkItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  @uriJsonConverter
  Uri get url;
  @override
  double get sortingOrder;

  /// Create a copy of BrowserBookmarkItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserBookmarkItemImplCopyWith<_$BrowserBookmarkItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
