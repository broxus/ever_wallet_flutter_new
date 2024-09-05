// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'site_meta_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SiteMetaData _$SiteMetaDataFromJson(Map<String, dynamic> json) {
  return _SiteMetaData.fromJson(json);
}

/// @nodoc
mixin _$SiteMetaData {
  String get url => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this SiteMetaData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SiteMetaDataCopyWith<SiteMetaData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SiteMetaDataCopyWith<$Res> {
  factory $SiteMetaDataCopyWith(
          SiteMetaData value, $Res Function(SiteMetaData) then) =
      _$SiteMetaDataCopyWithImpl<$Res, SiteMetaData>;
  @useResult
  $Res call({String url, String? title, String? image, String? description});
}

/// @nodoc
class _$SiteMetaDataCopyWithImpl<$Res, $Val extends SiteMetaData>
    implements $SiteMetaDataCopyWith<$Res> {
  _$SiteMetaDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$SiteMetaDataImplCopyWith<$Res>
    implements $SiteMetaDataCopyWith<$Res> {
  factory _$$SiteMetaDataImplCopyWith(
          _$SiteMetaDataImpl value, $Res Function(_$SiteMetaDataImpl) then) =
      __$$SiteMetaDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, String? title, String? image, String? description});
}

/// @nodoc
class __$$SiteMetaDataImplCopyWithImpl<$Res>
    extends _$SiteMetaDataCopyWithImpl<$Res, _$SiteMetaDataImpl>
    implements _$$SiteMetaDataImplCopyWith<$Res> {
  __$$SiteMetaDataImplCopyWithImpl(
      _$SiteMetaDataImpl _value, $Res Function(_$SiteMetaDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = freezed,
    Object? image = freezed,
    Object? description = freezed,
  }) {
    return _then(_$SiteMetaDataImpl(
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
@JsonSerializable()
class _$SiteMetaDataImpl implements _SiteMetaData {
  const _$SiteMetaDataImpl(
      {required this.url, this.title, this.image, this.description});

  factory _$SiteMetaDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SiteMetaDataImplFromJson(json);

  @override
  final String url;
  @override
  final String? title;
  @override
  final String? image;
  @override
  final String? description;

  @override
  String toString() {
    return 'SiteMetaData(url: $url, title: $title, image: $image, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SiteMetaDataImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, title, image, description);

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SiteMetaDataImplCopyWith<_$SiteMetaDataImpl> get copyWith =>
      __$$SiteMetaDataImplCopyWithImpl<_$SiteMetaDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SiteMetaDataImplToJson(
      this,
    );
  }
}

abstract class _SiteMetaData implements SiteMetaData {
  const factory _SiteMetaData(
      {required final String url,
      final String? title,
      final String? image,
      final String? description}) = _$SiteMetaDataImpl;

  factory _SiteMetaData.fromJson(Map<String, dynamic> json) =
      _$SiteMetaDataImpl.fromJson;

  @override
  String get url;
  @override
  String? get title;
  @override
  String? get image;
  @override
  String? get description;

  /// Create a copy of SiteMetaData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SiteMetaDataImplCopyWith<_$SiteMetaDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
