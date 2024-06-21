// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_history_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchHistoryDto {
  @HiveField(0)
  String get url => throw _privateConstructorUsedError;
  @HiveField(1)
  DateTime get openTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchHistoryDtoCopyWith<SearchHistoryDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchHistoryDtoCopyWith<$Res> {
  factory $SearchHistoryDtoCopyWith(
          SearchHistoryDto value, $Res Function(SearchHistoryDto) then) =
      _$SearchHistoryDtoCopyWithImpl<$Res, SearchHistoryDto>;
  @useResult
  $Res call({@HiveField(0) String url, @HiveField(1) DateTime openTime});
}

/// @nodoc
class _$SearchHistoryDtoCopyWithImpl<$Res, $Val extends SearchHistoryDto>
    implements $SearchHistoryDtoCopyWith<$Res> {
  _$SearchHistoryDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? openTime = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      openTime: null == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchHistoryDtoImplCopyWith<$Res>
    implements $SearchHistoryDtoCopyWith<$Res> {
  factory _$$SearchHistoryDtoImplCopyWith(_$SearchHistoryDtoImpl value,
          $Res Function(_$SearchHistoryDtoImpl) then) =
      __$$SearchHistoryDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@HiveField(0) String url, @HiveField(1) DateTime openTime});
}

/// @nodoc
class __$$SearchHistoryDtoImplCopyWithImpl<$Res>
    extends _$SearchHistoryDtoCopyWithImpl<$Res, _$SearchHistoryDtoImpl>
    implements _$$SearchHistoryDtoImplCopyWith<$Res> {
  __$$SearchHistoryDtoImplCopyWithImpl(_$SearchHistoryDtoImpl _value,
      $Res Function(_$SearchHistoryDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? openTime = null,
  }) {
    return _then(_$SearchHistoryDtoImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      openTime: null == openTime
          ? _value.openTime
          : openTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 56)
class _$SearchHistoryDtoImpl implements _SearchHistoryDto {
  const _$SearchHistoryDtoImpl(
      {@HiveField(0) required this.url, @HiveField(1) required this.openTime});

  @override
  @HiveField(0)
  final String url;
  @override
  @HiveField(1)
  final DateTime openTime;

  @override
  String toString() {
    return 'SearchHistoryDto(url: $url, openTime: $openTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchHistoryDtoImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.openTime, openTime) ||
                other.openTime == openTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, openTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchHistoryDtoImplCopyWith<_$SearchHistoryDtoImpl> get copyWith =>
      __$$SearchHistoryDtoImplCopyWithImpl<_$SearchHistoryDtoImpl>(
          this, _$identity);
}

abstract class _SearchHistoryDto implements SearchHistoryDto {
  const factory _SearchHistoryDto(
      {@HiveField(0) required final String url,
      @HiveField(1) required final DateTime openTime}) = _$SearchHistoryDtoImpl;

  @override
  @HiveField(0)
  String get url;
  @override
  @HiveField(1)
  DateTime get openTime;
  @override
  @JsonKey(ignore: true)
  _$$SearchHistoryDtoImplCopyWith<_$SearchHistoryDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
