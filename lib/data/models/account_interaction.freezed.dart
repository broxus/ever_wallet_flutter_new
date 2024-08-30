// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_interaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountInteraction _$AccountInteractionFromJson(Map<String, dynamic> json) {
  return _AccountInteraction.fromJson(json);
}

/// @nodoc
mixin _$AccountInteraction {
  Address get address => throw _privateConstructorUsedError;
  PublicKey get publicKey => throw _privateConstructorUsedError;
  WalletContractType get contractType => throw _privateConstructorUsedError;

  /// Serializes this AccountInteraction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountInteractionCopyWith<AccountInteraction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountInteractionCopyWith<$Res> {
  factory $AccountInteractionCopyWith(
          AccountInteraction value, $Res Function(AccountInteraction) then) =
      _$AccountInteractionCopyWithImpl<$Res, AccountInteraction>;
  @useResult
  $Res call(
      {Address address, PublicKey publicKey, WalletContractType contractType});

  $AddressCopyWith<$Res> get address;
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class _$AccountInteractionCopyWithImpl<$Res, $Val extends AccountInteraction>
    implements $AccountInteractionCopyWith<$Res> {
  _$AccountInteractionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? contractType = null,
  }) {
    return _then(_value.copyWith(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as WalletContractType,
    ) as $Val);
  }

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get publicKey {
    return $PublicKeyCopyWith<$Res>(_value.publicKey, (value) {
      return _then(_value.copyWith(publicKey: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountInteractionImplCopyWith<$Res>
    implements $AccountInteractionCopyWith<$Res> {
  factory _$$AccountInteractionImplCopyWith(_$AccountInteractionImpl value,
          $Res Function(_$AccountInteractionImpl) then) =
      __$$AccountInteractionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Address address, PublicKey publicKey, WalletContractType contractType});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $PublicKeyCopyWith<$Res> get publicKey;
}

/// @nodoc
class __$$AccountInteractionImplCopyWithImpl<$Res>
    extends _$AccountInteractionCopyWithImpl<$Res, _$AccountInteractionImpl>
    implements _$$AccountInteractionImplCopyWith<$Res> {
  __$$AccountInteractionImplCopyWithImpl(_$AccountInteractionImpl _value,
      $Res Function(_$AccountInteractionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? contractType = null,
  }) {
    return _then(_$AccountInteractionImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as WalletContractType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountInteractionImpl implements _AccountInteraction {
  const _$AccountInteractionImpl(
      {required this.address,
      required this.publicKey,
      required this.contractType});

  factory _$AccountInteractionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountInteractionImplFromJson(json);

  @override
  final Address address;
  @override
  final PublicKey publicKey;
  @override
  final WalletContractType contractType;

  @override
  String toString() {
    return 'AccountInteraction(address: $address, publicKey: $publicKey, contractType: $contractType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountInteractionImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.contractType, contractType) ||
                other.contractType == contractType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, address, publicKey, contractType);

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountInteractionImplCopyWith<_$AccountInteractionImpl> get copyWith =>
      __$$AccountInteractionImplCopyWithImpl<_$AccountInteractionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountInteractionImplToJson(
      this,
    );
  }
}

abstract class _AccountInteraction implements AccountInteraction {
  const factory _AccountInteraction(
          {required final Address address,
          required final PublicKey publicKey,
          required final WalletContractType contractType}) =
      _$AccountInteractionImpl;

  factory _AccountInteraction.fromJson(Map<String, dynamic> json) =
      _$AccountInteractionImpl.fromJson;

  @override
  Address get address;
  @override
  PublicKey get publicKey;
  @override
  WalletContractType get contractType;

  /// Create a copy of AccountInteraction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountInteractionImplCopyWith<_$AccountInteractionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
