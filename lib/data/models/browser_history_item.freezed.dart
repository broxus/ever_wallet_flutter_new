// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BrowserHistoryItem _$BrowserHistoryItemFromJson(Map<String, dynamic> json) {
  return _BrowserHistoryItemDto.fromJson(json);
}

/// @nodoc
mixin _$BrowserHistoryItem {
  /// The id of the tab.
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  @uriJsonConverter
  Uri get url => throw _privateConstructorUsedError;
  DateTime get visitTime => throw _privateConstructorUsedError;

  /// Serializes this BrowserHistoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowserHistoryItemCopyWith<BrowserHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserHistoryItemCopyWith<$Res> {
  factory $BrowserHistoryItemCopyWith(
          BrowserHistoryItem value, $Res Function(BrowserHistoryItem) then) =
      _$BrowserHistoryItemCopyWithImpl<$Res, BrowserHistoryItem>;
  @useResult
  $Res call(
      {String id, String title, @uriJsonConverter Uri url, DateTime visitTime});
}

/// @nodoc
class _$BrowserHistoryItemCopyWithImpl<$Res, $Val extends BrowserHistoryItem>
    implements $BrowserHistoryItemCopyWith<$Res> {
  _$BrowserHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? visitTime = null,
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
      visitTime: null == visitTime
          ? _value.visitTime
          : visitTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserHistoryItemDtoImplCopyWith<$Res>
    implements $BrowserHistoryItemCopyWith<$Res> {
  factory _$$BrowserHistoryItemDtoImplCopyWith(
          _$BrowserHistoryItemDtoImpl value,
          $Res Function(_$BrowserHistoryItemDtoImpl) then) =
      __$$BrowserHistoryItemDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id, String title, @uriJsonConverter Uri url, DateTime visitTime});
}

/// @nodoc
class __$$BrowserHistoryItemDtoImplCopyWithImpl<$Res>
    extends _$BrowserHistoryItemCopyWithImpl<$Res, _$BrowserHistoryItemDtoImpl>
    implements _$$BrowserHistoryItemDtoImplCopyWith<$Res> {
  __$$BrowserHistoryItemDtoImplCopyWithImpl(_$BrowserHistoryItemDtoImpl _value,
      $Res Function(_$BrowserHistoryItemDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? url = null,
    Object? visitTime = null,
  }) {
    return _then(_$BrowserHistoryItemDtoImpl(
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
      visitTime: null == visitTime
          ? _value.visitTime
          : visitTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowserHistoryItemDtoImpl extends _BrowserHistoryItemDto {
  const _$BrowserHistoryItemDtoImpl(
      {required this.id,
      required this.title,
      @uriJsonConverter required this.url,
      required this.visitTime})
      : super._();

  factory _$BrowserHistoryItemDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowserHistoryItemDtoImplFromJson(json);

  /// The id of the tab.
  @override
  final String id;
  @override
  final String title;
  @override
  @uriJsonConverter
  final Uri url;
  @override
  final DateTime visitTime;

  @override
  String toString() {
    return 'BrowserHistoryItem(id: $id, title: $title, url: $url, visitTime: $visitTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserHistoryItemDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.visitTime, visitTime) ||
                other.visitTime == visitTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, url, visitTime);

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserHistoryItemDtoImplCopyWith<_$BrowserHistoryItemDtoImpl>
      get copyWith => __$$BrowserHistoryItemDtoImplCopyWithImpl<
          _$BrowserHistoryItemDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowserHistoryItemDtoImplToJson(
      this,
    );
  }
}

abstract class _BrowserHistoryItemDto extends BrowserHistoryItem {
  const factory _BrowserHistoryItemDto(
      {required final String id,
      required final String title,
      @uriJsonConverter required final Uri url,
      required final DateTime visitTime}) = _$BrowserHistoryItemDtoImpl;
  const _BrowserHistoryItemDto._() : super._();

  factory _BrowserHistoryItemDto.fromJson(Map<String, dynamic> json) =
      _$BrowserHistoryItemDtoImpl.fromJson;

  /// The id of the tab.
  @override
  String get id;
  @override
  String get title;
  @override
  @uriJsonConverter
  Uri get url;
  @override
  DateTime get visitTime;

  /// Create a copy of BrowserHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowserHistoryItemDtoImplCopyWith<_$BrowserHistoryItemDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
