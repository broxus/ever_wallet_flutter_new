// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_interaction_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountInteractionDto {
  @HiveField(0)
  String get address => throw _privateConstructorUsedError;
  @HiveField(1)
  String get publicKey => throw _privateConstructorUsedError;
  @HiveField(2)
  WalletContractTypeDto get contractType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AccountInteractionDtoCopyWith<AccountInteractionDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountInteractionDtoCopyWith<$Res> {
  factory $AccountInteractionDtoCopyWith(AccountInteractionDto value,
          $Res Function(AccountInteractionDto) then) =
      _$AccountInteractionDtoCopyWithImpl<$Res, AccountInteractionDto>;
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String publicKey,
      @HiveField(2) WalletContractTypeDto contractType});
}

/// @nodoc
class _$AccountInteractionDtoCopyWithImpl<$Res,
        $Val extends AccountInteractionDto>
    implements $AccountInteractionDtoCopyWith<$Res> {
  _$AccountInteractionDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as WalletContractTypeDto,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AccountInteractionDtoImplCopyWith<$Res>
    implements $AccountInteractionDtoCopyWith<$Res> {
  factory _$$AccountInteractionDtoImplCopyWith(
          _$AccountInteractionDtoImpl value,
          $Res Function(_$AccountInteractionDtoImpl) then) =
      __$$AccountInteractionDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String address,
      @HiveField(1) String publicKey,
      @HiveField(2) WalletContractTypeDto contractType});
}

/// @nodoc
class __$$AccountInteractionDtoImplCopyWithImpl<$Res>
    extends _$AccountInteractionDtoCopyWithImpl<$Res,
        _$AccountInteractionDtoImpl>
    implements _$$AccountInteractionDtoImplCopyWith<$Res> {
  __$$AccountInteractionDtoImplCopyWithImpl(_$AccountInteractionDtoImpl _value,
      $Res Function(_$AccountInteractionDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
    Object? publicKey = null,
    Object? contractType = null,
  }) {
    return _then(_$AccountInteractionDtoImpl(
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      contractType: null == contractType
          ? _value.contractType
          : contractType // ignore: cast_nullable_to_non_nullable
              as WalletContractTypeDto,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 222)
class _$AccountInteractionDtoImpl implements _AccountInteractionDto {
  const _$AccountInteractionDtoImpl(
      {@HiveField(0) required this.address,
      @HiveField(1) required this.publicKey,
      @HiveField(2) required this.contractType});

  @override
  @HiveField(0)
  final String address;
  @override
  @HiveField(1)
  final String publicKey;
  @override
  @HiveField(2)
  final WalletContractTypeDto contractType;

  @override
  String toString() {
    return 'AccountInteractionDto(address: $address, publicKey: $publicKey, contractType: $contractType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountInteractionDtoImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.contractType, contractType) ||
                other.contractType == contractType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, address, publicKey, contractType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountInteractionDtoImplCopyWith<_$AccountInteractionDtoImpl>
      get copyWith => __$$AccountInteractionDtoImplCopyWithImpl<
          _$AccountInteractionDtoImpl>(this, _$identity);
}

abstract class _AccountInteractionDto implements AccountInteractionDto {
  const factory _AccountInteractionDto(
          {@HiveField(0) required final String address,
          @HiveField(1) required final String publicKey,
          @HiveField(2) required final WalletContractTypeDto contractType}) =
      _$AccountInteractionDtoImpl;

  @override
  @HiveField(0)
  String get address;
  @override
  @HiveField(1)
  String get publicKey;
  @override
  @HiveField(2)
  WalletContractTypeDto get contractType;
  @override
  @JsonKey(ignore: true)
  _$$AccountInteractionDtoImplCopyWith<_$AccountInteractionDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
