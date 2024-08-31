// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_assets_manifest_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TonAssetsManifestVersion _$TonAssetsManifestVersionFromJson(
    Map<String, dynamic> json) {
  return _TonAssetsManifestVersion.fromJson(json);
}

/// @nodoc
mixin _$TonAssetsManifestVersion {
  int get major => throw _privateConstructorUsedError;
  int get minor => throw _privateConstructorUsedError;
  int get patch => throw _privateConstructorUsedError;

  /// Serializes this TonAssetsManifestVersion to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonAssetsManifestVersionCopyWith<TonAssetsManifestVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonAssetsManifestVersionCopyWith<$Res> {
  factory $TonAssetsManifestVersionCopyWith(TonAssetsManifestVersion value,
          $Res Function(TonAssetsManifestVersion) then) =
      _$TonAssetsManifestVersionCopyWithImpl<$Res, TonAssetsManifestVersion>;
  @useResult
  $Res call({int major, int minor, int patch});
}

/// @nodoc
class _$TonAssetsManifestVersionCopyWithImpl<$Res,
        $Val extends TonAssetsManifestVersion>
    implements $TonAssetsManifestVersionCopyWith<$Res> {
  _$TonAssetsManifestVersionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = null,
  }) {
    return _then(_value.copyWith(
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: null == patch
          ? _value.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TonAssetsManifestVersionImplCopyWith<$Res>
    implements $TonAssetsManifestVersionCopyWith<$Res> {
  factory _$$TonAssetsManifestVersionImplCopyWith(
          _$TonAssetsManifestVersionImpl value,
          $Res Function(_$TonAssetsManifestVersionImpl) then) =
      __$$TonAssetsManifestVersionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int major, int minor, int patch});
}

/// @nodoc
class __$$TonAssetsManifestVersionImplCopyWithImpl<$Res>
    extends _$TonAssetsManifestVersionCopyWithImpl<$Res,
        _$TonAssetsManifestVersionImpl>
    implements _$$TonAssetsManifestVersionImplCopyWith<$Res> {
  __$$TonAssetsManifestVersionImplCopyWithImpl(
      _$TonAssetsManifestVersionImpl _value,
      $Res Function(_$TonAssetsManifestVersionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? major = null,
    Object? minor = null,
    Object? patch = null,
  }) {
    return _then(_$TonAssetsManifestVersionImpl(
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as int,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      patch: null == patch
          ? _value.patch
          : patch // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonAssetsManifestVersionImpl implements _TonAssetsManifestVersion {
  const _$TonAssetsManifestVersionImpl(
      {required this.major, required this.minor, required this.patch});

  factory _$TonAssetsManifestVersionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAssetsManifestVersionImplFromJson(json);

  @override
  final int major;
  @override
  final int minor;
  @override
  final int patch;

  @override
  String toString() {
    return 'TonAssetsManifestVersion(major: $major, minor: $minor, patch: $patch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonAssetsManifestVersionImpl &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.patch, patch) || other.patch == patch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, major, minor, patch);

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonAssetsManifestVersionImplCopyWith<_$TonAssetsManifestVersionImpl>
      get copyWith => __$$TonAssetsManifestVersionImplCopyWithImpl<
          _$TonAssetsManifestVersionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAssetsManifestVersionImplToJson(
      this,
    );
  }
}

abstract class _TonAssetsManifestVersion implements TonAssetsManifestVersion {
  const factory _TonAssetsManifestVersion(
      {required final int major,
      required final int minor,
      required final int patch}) = _$TonAssetsManifestVersionImpl;

  factory _TonAssetsManifestVersion.fromJson(Map<String, dynamic> json) =
      _$TonAssetsManifestVersionImpl.fromJson;

  @override
  int get major;
  @override
  int get minor;
  @override
  int get patch;

  /// Create a copy of TonAssetsManifestVersion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonAssetsManifestVersionImplCopyWith<_$TonAssetsManifestVersionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
