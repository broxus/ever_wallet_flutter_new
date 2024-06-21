// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_meta_data_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SiteMetaDataDto {
  @HiveField(0)
  String get url => throw _privateConstructorUsedError;
  @HiveField(1)
  String? get title => throw _privateConstructorUsedError;
  @HiveField(2)
  String? get image => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SiteMetaDataDtoCopyWith<SiteMetaDataDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteMetaDataDtoCopyWith<$Res> {
  factory $SiteMetaDataDtoCopyWith(
          SiteMetaDataDto value, $Res Function(SiteMetaDataDto) then) =
      _$SiteMetaDataDtoCopyWithImpl<$Res, SiteMetaDataDto>;
  @useResult
  $Res call(
      {@HiveField(0) String url,
      @HiveField(1) String? title,
      @HiveField(2) String? image,
      @HiveField(3) String? description});
}

/// @nodoc
class _$SiteMetaDataDtoCopyWithImpl<$Res, $Val extends SiteMetaDataDto>
    implements $SiteMetaDataDtoCopyWith<$Res> {
  _$SiteMetaDataDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SiteMetaDataDtoImplCopyWith<$Res>
    implements $SiteMetaDataDtoCopyWith<$Res> {
  factory _$$SiteMetaDataDtoImplCopyWith(_$SiteMetaDataDtoImpl value,
          $Res Function(_$SiteMetaDataDtoImpl) then) =
      __$$SiteMetaDataDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String url,
      @HiveField(1) String? title,
      @HiveField(2) String? image,
      @HiveField(3) String? description});
}

/// @nodoc
class __$$SiteMetaDataDtoImplCopyWithImpl<$Res>
    extends _$SiteMetaDataDtoCopyWithImpl<$Res, _$SiteMetaDataDtoImpl>
    implements _$$SiteMetaDataDtoImplCopyWith<$Res> {
  __$$SiteMetaDataDtoImplCopyWithImpl(
      _$SiteMetaDataDtoImpl _value, $Res Function(_$SiteMetaDataDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_$SiteMetaDataDtoImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 2)
class _$SiteMetaDataDtoImpl implements _SiteMetaDataDto {
  const _$SiteMetaDataDtoImpl(
      {@HiveField(0) required this.url,
      @HiveField(1) this.title,
      @HiveField(2) this.image,
      @HiveField(3) this.description});

  @override
  @HiveField(0)
  final String url;
  @override
  @HiveField(1)
  final String? title;
  @override
  @HiveField(2)
  final String? image;
  @override
  @HiveField(3)
  final String? description;

  @override
  String toString() {
    return 'SiteMetaDataDto(url: $url, title: $title, image: $image, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteMetaDataDtoImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, title, image, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteMetaDataDtoImplCopyWith<_$SiteMetaDataDtoImpl> get copyWith =>
      __$$SiteMetaDataDtoImplCopyWithImpl<_$SiteMetaDataDtoImpl>(
          this, _$identity);
}

abstract class _SiteMetaDataDto implements SiteMetaDataDto {
  const factory _SiteMetaDataDto(
      {@HiveField(0) required final String url,
      @HiveField(1) final String? title,
      @HiveField(2) final String? image,
      @HiveField(3) final String? description}) = _$SiteMetaDataDtoImpl;

  @override
  @HiveField(0)
  String get url;
  @override
  @HiveField(1)
  String? get title;
  @override
  @HiveField(2)
  String? get image;
  @override
  @HiveField(3)
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$SiteMetaDataDtoImplCopyWith<_$SiteMetaDataDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
