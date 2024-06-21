// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserTabDto {
  @HiveField(0)
  String get url => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get image => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get title => throw _privateConstructorUsedError;
  @HiveField(3, defaultValue: 0)
  int get lastScrollPosition => throw _privateConstructorUsedError;
  @HiveField(4)
  Uint8List? get screenshot => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrowserTabDtoCopyWith<BrowserTabDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabDtoCopyWith<$Res> {
  factory $BrowserTabDtoCopyWith(
          BrowserTabDto value, $Res Function(BrowserTabDto) then) =
      _$BrowserTabDtoCopyWithImpl<$Res, BrowserTabDto>;
  @useResult
  $Res call(
      {@HiveField(0) String url,
      @HiveField(1) String? image,
      @HiveField(2) String? title,
      @HiveField(3, defaultValue: 0) int lastScrollPosition,
      @HiveField(4) Uint8List? screenshot});
}

/// @nodoc
class _$BrowserTabDtoCopyWithImpl<$Res, $Val extends BrowserTabDto>
    implements $BrowserTabDtoCopyWith<$Res> {
  _$BrowserTabDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? image = freezed,
    Object? title = freezed,
    Object? lastScrollPosition = null,
    Object? screenshot = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      lastScrollPosition: null == lastScrollPosition
          ? _value.lastScrollPosition
          : lastScrollPosition // ignore: cast_nullable_to_non_nullable
              as int,
      screenshot: freezed == screenshot
          ? _value.screenshot
          : screenshot // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserTabImplCopyWith<$Res>
    implements $BrowserTabDtoCopyWith<$Res> {
  factory _$$BrowserTabImplCopyWith(
          _$BrowserTabImpl value, $Res Function(_$BrowserTabImpl) then) =
      __$$BrowserTabImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String url,
      @HiveField(1) String? image,
      @HiveField(2) String? title,
      @HiveField(3, defaultValue: 0) int lastScrollPosition,
      @HiveField(4) Uint8List? screenshot});
}

/// @nodoc
class __$$BrowserTabImplCopyWithImpl<$Res>
    extends _$BrowserTabDtoCopyWithImpl<$Res, _$BrowserTabImpl>
    implements _$$BrowserTabImplCopyWith<$Res> {
  __$$BrowserTabImplCopyWithImpl(
      _$BrowserTabImpl _value, $Res Function(_$BrowserTabImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? image = freezed,
    Object? title = freezed,
    Object? lastScrollPosition = null,
    Object? screenshot = freezed,
  }) {
    return _then(_$BrowserTabImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      lastScrollPosition: null == lastScrollPosition
          ? _value.lastScrollPosition
          : lastScrollPosition // ignore: cast_nullable_to_non_nullable
              as int,
      screenshot: freezed == screenshot
          ? _value.screenshot
          : screenshot // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 55)
class _$BrowserTabImpl implements _BrowserTab {
  const _$BrowserTabImpl(
      {@HiveField(0) required this.url,
      @HiveField(1) required this.image,
      @HiveField(2) required this.title,
      @HiveField(3, defaultValue: 0) required this.lastScrollPosition,
      @HiveField(4) this.screenshot});

  @override
  @HiveField(0)
  final String url;
  @override
  @HiveField(1)
  final String? image;
  @override
  @HiveField(2)
  final String? title;
  @override
  @HiveField(3, defaultValue: 0)
  final int lastScrollPosition;
  @override
  @HiveField(4)
  final Uint8List? screenshot;

  @override
  String toString() {
    return 'BrowserTabDto(url: $url, image: $image, title: $title, lastScrollPosition: $lastScrollPosition, screenshot: $screenshot)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserTabImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lastScrollPosition, lastScrollPosition) ||
                other.lastScrollPosition == lastScrollPosition) &&
            const DeepCollectionEquality()
                .equals(other.screenshot, screenshot));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, image, title,
      lastScrollPosition, const DeepCollectionEquality().hash(screenshot));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserTabImplCopyWith<_$BrowserTabImpl> get copyWith =>
      __$$BrowserTabImplCopyWithImpl<_$BrowserTabImpl>(this, _$identity);
}

abstract class _BrowserTab implements BrowserTabDto {
  const factory _BrowserTab(
      {@HiveField(0) required final String url,
      @HiveField(1) required final String? image,
      @HiveField(2) required final String? title,
      @HiveField(3, defaultValue: 0) required final int lastScrollPosition,
      @HiveField(4) final Uint8List? screenshot}) = _$BrowserTabImpl;

  @override
  @HiveField(0)
  String get url;
  @override
  @HiveField(1)
  String? get image;
  @override
  @HiveField(2)
  String? get title;
  @override
  @HiveField(3, defaultValue: 0)
  int get lastScrollPosition;
  @override
  @HiveField(4)
  Uint8List? get screenshot;
  @override
  @JsonKey(ignore: true)
  _$$BrowserTabImplCopyWith<_$BrowserTabImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
