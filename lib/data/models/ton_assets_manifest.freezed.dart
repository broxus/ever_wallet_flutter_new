// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_assets_manifest.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TonAssetsManifest _$TonAssetsManifestFromJson(Map<String, dynamic> json) {
  return _TonAssetsManifest.fromJson(json);
}

/// @nodoc
mixin _$TonAssetsManifest {
  @JsonKey(name: r'$schema')
  String get schema => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  TonAssetsManifestVersion get version => throw _privateConstructorUsedError;
  List<String> get keywords => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  List<TokenContractAsset> get tokens => throw _privateConstructorUsedError;

  /// Serializes this TonAssetsManifest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TonAssetsManifestCopyWith<TonAssetsManifest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonAssetsManifestCopyWith<$Res> {
  factory $TonAssetsManifestCopyWith(
          TonAssetsManifest value, $Res Function(TonAssetsManifest) then) =
      _$TonAssetsManifestCopyWithImpl<$Res, TonAssetsManifest>;
  @useResult
  $Res call(
      {@JsonKey(name: r'$schema') String schema,
      String name,
      TonAssetsManifestVersion version,
      List<String> keywords,
      String timestamp,
      List<TokenContractAsset> tokens});

  $TonAssetsManifestVersionCopyWith<$Res> get version;
}

/// @nodoc
class _$TonAssetsManifestCopyWithImpl<$Res, $Val extends TonAssetsManifest>
    implements $TonAssetsManifestCopyWith<$Res> {
  _$TonAssetsManifestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? version = null,
    Object? keywords = null,
    Object? timestamp = null,
    Object? tokens = null,
  }) {
    return _then(_value.copyWith(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as TonAssetsManifestVersion,
      keywords: null == keywords
          ? _value.keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value.tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenContractAsset>,
    ) as $Val);
  }

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonAssetsManifestVersionCopyWith<$Res> get version {
    return $TonAssetsManifestVersionCopyWith<$Res>(_value.version, (value) {
      return _then(_value.copyWith(version: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TonAssetsManifestImplCopyWith<$Res>
    implements $TonAssetsManifestCopyWith<$Res> {
  factory _$$TonAssetsManifestImplCopyWith(_$TonAssetsManifestImpl value,
          $Res Function(_$TonAssetsManifestImpl) then) =
      __$$TonAssetsManifestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: r'$schema') String schema,
      String name,
      TonAssetsManifestVersion version,
      List<String> keywords,
      String timestamp,
      List<TokenContractAsset> tokens});

  @override
  $TonAssetsManifestVersionCopyWith<$Res> get version;
}

/// @nodoc
class __$$TonAssetsManifestImplCopyWithImpl<$Res>
    extends _$TonAssetsManifestCopyWithImpl<$Res, _$TonAssetsManifestImpl>
    implements _$$TonAssetsManifestImplCopyWith<$Res> {
  __$$TonAssetsManifestImplCopyWithImpl(_$TonAssetsManifestImpl _value,
      $Res Function(_$TonAssetsManifestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? schema = null,
    Object? name = null,
    Object? version = null,
    Object? keywords = null,
    Object? timestamp = null,
    Object? tokens = null,
  }) {
    return _then(_$TonAssetsManifestImpl(
      schema: null == schema
          ? _value.schema
          : schema // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as TonAssetsManifestVersion,
      keywords: null == keywords
          ? _value._keywords
          : keywords // ignore: cast_nullable_to_non_nullable
              as List<String>,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as String,
      tokens: null == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenContractAsset>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TonAssetsManifestImpl implements _TonAssetsManifest {
  const _$TonAssetsManifestImpl(
      {@JsonKey(name: r'$schema') required this.schema,
      required this.name,
      required this.version,
      required final List<String> keywords,
      required this.timestamp,
      required final List<TokenContractAsset> tokens})
      : _keywords = keywords,
        _tokens = tokens;

  factory _$TonAssetsManifestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TonAssetsManifestImplFromJson(json);

  @override
  @JsonKey(name: r'$schema')
  final String schema;
  @override
  final String name;
  @override
  final TonAssetsManifestVersion version;
  final List<String> _keywords;
  @override
  List<String> get keywords {
    if (_keywords is EqualUnmodifiableListView) return _keywords;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_keywords);
  }

  @override
  final String timestamp;
  final List<TokenContractAsset> _tokens;
  @override
  List<TokenContractAsset> get tokens {
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokens);
  }

  @override
  String toString() {
    return 'TonAssetsManifest(schema: $schema, name: $name, version: $version, keywords: $keywords, timestamp: $timestamp, tokens: $tokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TonAssetsManifestImpl &&
            (identical(other.schema, schema) || other.schema == schema) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.version, version) || other.version == version) &&
            const DeepCollectionEquality().equals(other._keywords, _keywords) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      schema,
      name,
      version,
      const DeepCollectionEquality().hash(_keywords),
      timestamp,
      const DeepCollectionEquality().hash(_tokens));

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TonAssetsManifestImplCopyWith<_$TonAssetsManifestImpl> get copyWith =>
      __$$TonAssetsManifestImplCopyWithImpl<_$TonAssetsManifestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TonAssetsManifestImplToJson(
      this,
    );
  }
}

abstract class _TonAssetsManifest implements TonAssetsManifest {
  const factory _TonAssetsManifest(
          {@JsonKey(name: r'$schema') required final String schema,
          required final String name,
          required final TonAssetsManifestVersion version,
          required final List<String> keywords,
          required final String timestamp,
          required final List<TokenContractAsset> tokens}) =
      _$TonAssetsManifestImpl;

  factory _TonAssetsManifest.fromJson(Map<String, dynamic> json) =
      _$TonAssetsManifestImpl.fromJson;

  @override
  @JsonKey(name: r'$schema')
  String get schema;
  @override
  String get name;
  @override
  TonAssetsManifestVersion get version;
  @override
  List<String> get keywords;
  @override
  String get timestamp;
  @override
  List<TokenContractAsset> get tokens;

  /// Create a copy of TonAssetsManifest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TonAssetsManifestImplCopyWith<_$TonAssetsManifestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
