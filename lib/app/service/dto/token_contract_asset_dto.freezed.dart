// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_contract_asset_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenContractAssetDto {
  @HiveField(0)
  String get name => throw _privateConstructorUsedError;
  @HiveField(2)
  String get symbol => throw _privateConstructorUsedError;
  @HiveField(3)
  int get decimals => throw _privateConstructorUsedError;
  @HiveField(4)
  String get address => throw _privateConstructorUsedError;
  @HiveField(6)
  int get version => throw _privateConstructorUsedError;
  @HiveField(1)
  int? get chainId => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get logoURI => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TokenContractAssetDtoCopyWith<TokenContractAssetDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenContractAssetDtoCopyWith<$Res> {
  factory $TokenContractAssetDtoCopyWith(TokenContractAssetDto value,
          $Res Function(TokenContractAssetDto) then) =
      _$TokenContractAssetDtoCopyWithImpl<$Res, TokenContractAssetDto>;
  @useResult
  $Res call(
      {@HiveField(0) String name,
      @HiveField(2) String symbol,
      @HiveField(3) int decimals,
      @HiveField(4) String address,
      @HiveField(6) int version,
      @HiveField(1) int? chainId,
      @HiveField(5) String? logoURI});
}

/// @nodoc
class _$TokenContractAssetDtoCopyWithImpl<$Res,
        $Val extends TokenContractAssetDto>
    implements $TokenContractAssetDtoCopyWith<$Res> {
  _$TokenContractAssetDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? address = null,
    Object? version = null,
    Object? chainId = freezed,
    Object? logoURI = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      logoURI: freezed == logoURI
          ? _value.logoURI
          : logoURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenContractAssetDtoImplCopyWith<$Res>
    implements $TokenContractAssetDtoCopyWith<$Res> {
  factory _$$TokenContractAssetDtoImplCopyWith(
          _$TokenContractAssetDtoImpl value,
          $Res Function(_$TokenContractAssetDtoImpl) then) =
      __$$TokenContractAssetDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String name,
      @HiveField(2) String symbol,
      @HiveField(3) int decimals,
      @HiveField(4) String address,
      @HiveField(6) int version,
      @HiveField(1) int? chainId,
      @HiveField(5) String? logoURI});
}

/// @nodoc
class __$$TokenContractAssetDtoImplCopyWithImpl<$Res>
    extends _$TokenContractAssetDtoCopyWithImpl<$Res,
        _$TokenContractAssetDtoImpl>
    implements _$$TokenContractAssetDtoImplCopyWith<$Res> {
  __$$TokenContractAssetDtoImplCopyWithImpl(_$TokenContractAssetDtoImpl _value,
      $Res Function(_$TokenContractAssetDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? address = null,
    Object? version = null,
    Object? chainId = freezed,
    Object? logoURI = freezed,
  }) {
    return _then(_$TokenContractAssetDtoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as int,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      logoURI: freezed == logoURI
          ? _value.logoURI
          : logoURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 1)
class _$TokenContractAssetDtoImpl implements _TokenContractAssetDto {
  const _$TokenContractAssetDtoImpl(
      {@HiveField(0) required this.name,
      @HiveField(2) required this.symbol,
      @HiveField(3) required this.decimals,
      @HiveField(4) required this.address,
      @HiveField(6) required this.version,
      @HiveField(1) this.chainId,
      @HiveField(5) this.logoURI});

  @override
  @HiveField(0)
  final String name;
  @override
  @HiveField(2)
  final String symbol;
  @override
  @HiveField(3)
  final int decimals;
  @override
  @HiveField(4)
  final String address;
  @override
  @HiveField(6)
  final int version;
  @override
  @HiveField(1)
  final int? chainId;
  @override
  @HiveField(5)
  final String? logoURI;

  @override
  String toString() {
    return 'TokenContractAssetDto(name: $name, symbol: $symbol, decimals: $decimals, address: $address, version: $version, chainId: $chainId, logoURI: $logoURI)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenContractAssetDtoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.logoURI, logoURI) || other.logoURI == logoURI));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, symbol, decimals, address, version, chainId, logoURI);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenContractAssetDtoImplCopyWith<_$TokenContractAssetDtoImpl>
      get copyWith => __$$TokenContractAssetDtoImplCopyWithImpl<
          _$TokenContractAssetDtoImpl>(this, _$identity);
}

abstract class _TokenContractAssetDto implements TokenContractAssetDto {
  const factory _TokenContractAssetDto(
      {@HiveField(0) required final String name,
      @HiveField(2) required final String symbol,
      @HiveField(3) required final int decimals,
      @HiveField(4) required final String address,
      @HiveField(6) required final int version,
      @HiveField(1) final int? chainId,
      @HiveField(5) final String? logoURI}) = _$TokenContractAssetDtoImpl;

  @override
  @HiveField(0)
  String get name;
  @override
  @HiveField(2)
  String get symbol;
  @override
  @HiveField(3)
  int get decimals;
  @override
  @HiveField(4)
  String get address;
  @override
  @HiveField(6)
  int get version;
  @override
  @HiveField(1)
  int? get chainId;
  @override
  @HiveField(5)
  String? get logoURI;
  @override
  @JsonKey(ignore: true)
  _$$TokenContractAssetDtoImplCopyWith<_$TokenContractAssetDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
