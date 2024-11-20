// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokenBalanceModel _$TokenBalanceModelFromJson(Map<String, dynamic> json) {
  return _TokenBalanceModel.fromJson(json);
}

/// @nodoc
mixin _$TokenBalanceModel {
  String get amount => throw _privateConstructorUsedError;
  Address get ownerAddress => throw _privateConstructorUsedError;
  Address get rootAddress => throw _privateConstructorUsedError;
  Address get tokenWalletAddress => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;

  /// Serializes this TokenBalanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenBalanceModelCopyWith<TokenBalanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenBalanceModelCopyWith<$Res> {
  factory $TokenBalanceModelCopyWith(
          TokenBalanceModel value, $Res Function(TokenBalanceModel) then) =
      _$TokenBalanceModelCopyWithImpl<$Res, TokenBalanceModel>;
  @useResult
  $Res call(
      {String amount,
      Address ownerAddress,
      Address rootAddress,
      Address tokenWalletAddress,
      String token});

  $AddressCopyWith<$Res> get ownerAddress;
  $AddressCopyWith<$Res> get rootAddress;
  $AddressCopyWith<$Res> get tokenWalletAddress;
}

/// @nodoc
class _$TokenBalanceModelCopyWithImpl<$Res, $Val extends TokenBalanceModel>
    implements $TokenBalanceModelCopyWith<$Res> {
  _$TokenBalanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? ownerAddress = null,
    Object? rootAddress = null,
    Object? tokenWalletAddress = null,
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      ownerAddress: null == ownerAddress
          ? _value.ownerAddress
          : ownerAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      rootAddress: null == rootAddress
          ? _value.rootAddress
          : rootAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      tokenWalletAddress: null == tokenWalletAddress
          ? _value.tokenWalletAddress
          : tokenWalletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get ownerAddress {
    return $AddressCopyWith<$Res>(_value.ownerAddress, (value) {
      return _then(_value.copyWith(ownerAddress: value) as $Val);
    });
  }

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootAddress {
    return $AddressCopyWith<$Res>(_value.rootAddress, (value) {
      return _then(_value.copyWith(rootAddress: value) as $Val);
    });
  }

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get tokenWalletAddress {
    return $AddressCopyWith<$Res>(_value.tokenWalletAddress, (value) {
      return _then(_value.copyWith(tokenWalletAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenBalanceModelImplCopyWith<$Res>
    implements $TokenBalanceModelCopyWith<$Res> {
  factory _$$TokenBalanceModelImplCopyWith(_$TokenBalanceModelImpl value,
          $Res Function(_$TokenBalanceModelImpl) then) =
      __$$TokenBalanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String amount,
      Address ownerAddress,
      Address rootAddress,
      Address tokenWalletAddress,
      String token});

  @override
  $AddressCopyWith<$Res> get ownerAddress;
  @override
  $AddressCopyWith<$Res> get rootAddress;
  @override
  $AddressCopyWith<$Res> get tokenWalletAddress;
}

/// @nodoc
class __$$TokenBalanceModelImplCopyWithImpl<$Res>
    extends _$TokenBalanceModelCopyWithImpl<$Res, _$TokenBalanceModelImpl>
    implements _$$TokenBalanceModelImplCopyWith<$Res> {
  __$$TokenBalanceModelImplCopyWithImpl(_$TokenBalanceModelImpl _value,
      $Res Function(_$TokenBalanceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? ownerAddress = null,
    Object? rootAddress = null,
    Object? tokenWalletAddress = null,
    Object? token = null,
  }) {
    return _then(_$TokenBalanceModelImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      ownerAddress: null == ownerAddress
          ? _value.ownerAddress
          : ownerAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      rootAddress: null == rootAddress
          ? _value.rootAddress
          : rootAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      tokenWalletAddress: null == tokenWalletAddress
          ? _value.tokenWalletAddress
          : tokenWalletAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenBalanceModelImpl implements _TokenBalanceModel {
  const _$TokenBalanceModelImpl(
      {required this.amount,
      required this.ownerAddress,
      required this.rootAddress,
      required this.tokenWalletAddress,
      required this.token});

  factory _$TokenBalanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenBalanceModelImplFromJson(json);

  @override
  final String amount;
  @override
  final Address ownerAddress;
  @override
  final Address rootAddress;
  @override
  final Address tokenWalletAddress;
  @override
  final String token;

  @override
  String toString() {
    return 'TokenBalanceModel(amount: $amount, ownerAddress: $ownerAddress, rootAddress: $rootAddress, tokenWalletAddress: $tokenWalletAddress, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenBalanceModelImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.ownerAddress, ownerAddress) ||
                other.ownerAddress == ownerAddress) &&
            (identical(other.rootAddress, rootAddress) ||
                other.rootAddress == rootAddress) &&
            (identical(other.tokenWalletAddress, tokenWalletAddress) ||
                other.tokenWalletAddress == tokenWalletAddress) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, ownerAddress,
      rootAddress, tokenWalletAddress, token);

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenBalanceModelImplCopyWith<_$TokenBalanceModelImpl> get copyWith =>
      __$$TokenBalanceModelImplCopyWithImpl<_$TokenBalanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenBalanceModelImplToJson(
      this,
    );
  }
}

abstract class _TokenBalanceModel implements TokenBalanceModel {
  const factory _TokenBalanceModel(
      {required final String amount,
      required final Address ownerAddress,
      required final Address rootAddress,
      required final Address tokenWalletAddress,
      required final String token}) = _$TokenBalanceModelImpl;

  factory _TokenBalanceModel.fromJson(Map<String, dynamic> json) =
      _$TokenBalanceModelImpl.fromJson;

  @override
  String get amount;
  @override
  Address get ownerAddress;
  @override
  Address get rootAddress;
  @override
  Address get tokenWalletAddress;
  @override
  String get token;

  /// Create a copy of TokenBalanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenBalanceModelImplCopyWith<_$TokenBalanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
