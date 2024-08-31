// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookmark_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookmarkDto {
  @HiveField(0)
  int get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get url => throw _privateConstructorUsedError;

  /// Create a copy of BookmarkDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BookmarkDtoCopyWith<BookmarkDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookmarkDtoCopyWith<$Res> {
  factory $BookmarkDtoCopyWith(
          BookmarkDto value, $Res Function(BookmarkDto) then) =
      _$BookmarkDtoCopyWithImpl<$Res, BookmarkDto>;
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) String url});
}

/// @nodoc
class _$BookmarkDtoCopyWithImpl<$Res, $Val extends BookmarkDto>
    implements $BookmarkDtoCopyWith<$Res> {
  _$BookmarkDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookmarkDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BookmarkDtoImplCopyWith<$Res>
    implements $BookmarkDtoCopyWith<$Res> {
  factory _$$BookmarkDtoImplCopyWith(
          _$BookmarkDtoImpl value, $Res Function(_$BookmarkDtoImpl) then) =
      __$$BookmarkDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) int id,
      @HiveField(1) String name,
      @HiveField(2) String url});
}

/// @nodoc
class __$$BookmarkDtoImplCopyWithImpl<$Res>
    extends _$BookmarkDtoCopyWithImpl<$Res, _$BookmarkDtoImpl>
    implements _$$BookmarkDtoImplCopyWith<$Res> {
  __$$BookmarkDtoImplCopyWithImpl(
      _$BookmarkDtoImpl _value, $Res Function(_$BookmarkDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookmarkDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? url = null,
  }) {
    return _then(_$BookmarkDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 3)
class _$BookmarkDtoImpl implements _BookmarkDto {
  const _$BookmarkDtoImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.name,
      @HiveField(2) required this.url});

  @override
  @HiveField(0)
  final int id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String url;

  @override
  String toString() {
    return 'BookmarkDto(id: $id, name: $name, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookmarkDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name, url);

  /// Create a copy of BookmarkDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookmarkDtoImplCopyWith<_$BookmarkDtoImpl> get copyWith =>
      __$$BookmarkDtoImplCopyWithImpl<_$BookmarkDtoImpl>(this, _$identity);
}

abstract class _BookmarkDto implements BookmarkDto {
  const factory _BookmarkDto(
      {@HiveField(0) required final int id,
      @HiveField(1) required final String name,
      @HiveField(2) required final String url}) = _$BookmarkDtoImpl;

  @override
  @HiveField(0)
  int get id;
  @override
  @HiveField(1)
  String get name;
  @override
  @HiveField(2)
  String get url;

  /// Create a copy of BookmarkDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookmarkDtoImplCopyWith<_$BookmarkDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
