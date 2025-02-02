// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_contract_asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenContractAsset _$TokenContractAssetFromJson(Map<String, dynamic> json) {
  return _TokenContractAsset.fromJson(json);
}

/// @nodoc
mixin _$TokenContractAsset {
  String get name => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  int get decimals =>
      throw _privateConstructorUsedError; // address of rootTokenContract
  Address get address => throw _privateConstructorUsedError;
  String get networkType => throw _privateConstructorUsedError;
  String get networkGroup =>
      throw _privateConstructorUsedError; // true if custom, false if system
  bool get isCustom => throw _privateConstructorUsedError;
  TokenWalletVersion? get version => throw _privateConstructorUsedError;
  int? get chainId =>
      throw _privateConstructorUsedError; // address of owner that could be set when loaded in
// <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
  @JsonKey(includeToJson: false, includeFromJson: false)
  Address? get ownerAddress => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get totalSupply => throw _privateConstructorUsedError;
  String? get logoURI => throw _privateConstructorUsedError;

  /// Serializes this TokenContractAsset to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenContractAssetCopyWith<TokenContractAsset> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenContractAssetCopyWith<$Res> {
  factory $TokenContractAssetCopyWith(
          TokenContractAsset value, $Res Function(TokenContractAsset) then) =
      _$TokenContractAssetCopyWithImpl<$Res, TokenContractAsset>;
  @useResult
  $Res call(
      {String name,
      String symbol,
      int decimals,
      Address address,
      String networkType,
      String networkGroup,
      bool isCustom,
      TokenWalletVersion? version,
      int? chainId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      Address? ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false)
      String? totalSupply,
      String? logoURI});

  $AddressCopyWith<$Res> get address;
  $AddressCopyWith<$Res>? get ownerAddress;
}

/// @nodoc
class _$TokenContractAssetCopyWithImpl<$Res, $Val extends TokenContractAsset>
    implements $TokenContractAssetCopyWith<$Res> {
  _$TokenContractAssetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? address = null,
    Object? networkType = null,
    Object? networkGroup = null,
    Object? isCustom = null,
    Object? version = freezed,
    Object? chainId = freezed,
    Object? ownerAddress = freezed,
    Object? totalSupply = freezed,
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
              as Address,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as TokenWalletVersion?,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerAddress: freezed == ownerAddress
          ? _value.ownerAddress
          : ownerAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      totalSupply: freezed == totalSupply
          ? _value.totalSupply
          : totalSupply // ignore: cast_nullable_to_non_nullable
              as String?,
      logoURI: freezed == logoURI
          ? _value.logoURI
          : logoURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get ownerAddress {
    if (_value.ownerAddress == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.ownerAddress!, (value) {
      return _then(_value.copyWith(ownerAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenContractAssetImplCopyWith<$Res>
    implements $TokenContractAssetCopyWith<$Res> {
  factory _$$TokenContractAssetImplCopyWith(_$TokenContractAssetImpl value,
          $Res Function(_$TokenContractAssetImpl) then) =
      __$$TokenContractAssetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String symbol,
      int decimals,
      Address address,
      String networkType,
      String networkGroup,
      bool isCustom,
      TokenWalletVersion? version,
      int? chainId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      Address? ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false)
      String? totalSupply,
      String? logoURI});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $AddressCopyWith<$Res>? get ownerAddress;
}

/// @nodoc
class __$$TokenContractAssetImplCopyWithImpl<$Res>
    extends _$TokenContractAssetCopyWithImpl<$Res, _$TokenContractAssetImpl>
    implements _$$TokenContractAssetImplCopyWith<$Res> {
  __$$TokenContractAssetImplCopyWithImpl(_$TokenContractAssetImpl _value,
      $Res Function(_$TokenContractAssetImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? symbol = null,
    Object? decimals = null,
    Object? address = null,
    Object? networkType = null,
    Object? networkGroup = null,
    Object? isCustom = null,
    Object? version = freezed,
    Object? chainId = freezed,
    Object? ownerAddress = freezed,
    Object? totalSupply = freezed,
    Object? logoURI = freezed,
  }) {
    return _then(_$TokenContractAssetImpl(
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
              as Address,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as TokenWalletVersion?,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as int?,
      ownerAddress: freezed == ownerAddress
          ? _value.ownerAddress
          : ownerAddress // ignore: cast_nullable_to_non_nullable
              as Address?,
      totalSupply: freezed == totalSupply
          ? _value.totalSupply
          : totalSupply // ignore: cast_nullable_to_non_nullable
              as String?,
      logoURI: freezed == logoURI
          ? _value.logoURI
          : logoURI // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenContractAssetImpl implements _TokenContractAsset {
  const _$TokenContractAssetImpl(
      {required this.name,
      required this.symbol,
      required this.decimals,
      required this.address,
      required this.networkType,
      required this.networkGroup,
      required this.isCustom,
      this.version,
      this.chainId,
      @JsonKey(includeToJson: false, includeFromJson: false) this.ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false) this.totalSupply,
      this.logoURI});

  factory _$TokenContractAssetImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenContractAssetImplFromJson(json);

  @override
  final String name;
  @override
  final String symbol;
  @override
  final int decimals;
// address of rootTokenContract
  @override
  final Address address;
  @override
  final String networkType;
  @override
  final String networkGroup;
// true if custom, false if system
  @override
  final bool isCustom;
  @override
  final TokenWalletVersion? version;
  @override
  final int? chainId;
// address of owner that could be set when loaded in
// <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final Address? ownerAddress;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  final String? totalSupply;
  @override
  final String? logoURI;

  @override
  String toString() {
    return 'TokenContractAsset(name: $name, symbol: $symbol, decimals: $decimals, address: $address, networkType: $networkType, networkGroup: $networkGroup, isCustom: $isCustom, version: $version, chainId: $chainId, ownerAddress: $ownerAddress, totalSupply: $totalSupply, logoURI: $logoURI)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenContractAssetImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.ownerAddress, ownerAddress) ||
                other.ownerAddress == ownerAddress) &&
            (identical(other.totalSupply, totalSupply) ||
                other.totalSupply == totalSupply) &&
            (identical(other.logoURI, logoURI) || other.logoURI == logoURI));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      symbol,
      decimals,
      address,
      networkType,
      networkGroup,
      isCustom,
      version,
      chainId,
      ownerAddress,
      totalSupply,
      logoURI);

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenContractAssetImplCopyWith<_$TokenContractAssetImpl> get copyWith =>
      __$$TokenContractAssetImplCopyWithImpl<_$TokenContractAssetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenContractAssetImplToJson(
      this,
    );
  }
}

abstract class _TokenContractAsset implements TokenContractAsset {
  const factory _TokenContractAsset(
      {required final String name,
      required final String symbol,
      required final int decimals,
      required final Address address,
      required final String networkType,
      required final String networkGroup,
      required final bool isCustom,
      final TokenWalletVersion? version,
      final int? chainId,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final Address? ownerAddress,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final String? totalSupply,
      final String? logoURI}) = _$TokenContractAssetImpl;

  factory _TokenContractAsset.fromJson(Map<String, dynamic> json) =
      _$TokenContractAssetImpl.fromJson;

  @override
  String get name;
  @override
  String get symbol;
  @override
  int get decimals; // address of rootTokenContract
  @override
  Address get address;
  @override
  String get networkType;
  @override
  String get networkGroup; // true if custom, false if system
  @override
  bool get isCustom;
  @override
  TokenWalletVersion? get version;
  @override
  int? get chainId; // address of owner that could be set when loaded in
// <TonWallet.getTokenRootDetailsFromTokenWallet>, may be optional
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  Address? get ownerAddress;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  String? get totalSupply;
  @override
  String? get logoURI;

  /// Create a copy of TokenContractAsset
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenContractAssetImplCopyWith<_$TokenContractAssetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
