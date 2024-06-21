// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_balance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AccountBalanceModel _$AccountBalanceModelFromJson(Map<String, dynamic> json) {
  return _AccountBalanceModel.fromJson(json);
}

/// @nodoc
mixin _$AccountBalanceModel {
  Address get rootTokenContract => throw _privateConstructorUsedError;
  @moneyFromStringJsonConverter
  Money get fiatBalance => throw _privateConstructorUsedError;
  @moneyFromStringJsonConverter
  Money get tokenBalance => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AccountBalanceModelCopyWith<AccountBalanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountBalanceModelCopyWith<$Res> {
  factory $AccountBalanceModelCopyWith(
          AccountBalanceModel value, $Res Function(AccountBalanceModel) then) =
      _$AccountBalanceModelCopyWithImpl<$Res, AccountBalanceModel>;
  @useResult
  $Res call(
      {Address rootTokenContract,
      @moneyFromStringJsonConverter Money fiatBalance,
      @moneyFromStringJsonConverter Money tokenBalance});

  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class _$AccountBalanceModelCopyWithImpl<$Res, $Val extends AccountBalanceModel>
    implements $AccountBalanceModelCopyWith<$Res> {
  _$AccountBalanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootTokenContract = null,
    Object? fiatBalance = null,
    Object? tokenBalance = null,
  }) {
    return _then(_value.copyWith(
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
      fiatBalance: null == fiatBalance
          ? _value.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      tokenBalance: null == tokenBalance
          ? _value.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get rootTokenContract {
    return $AddressCopyWith<$Res>(_value.rootTokenContract, (value) {
      return _then(_value.copyWith(rootTokenContract: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountBalanceModelImplCopyWith<$Res>
    implements $AccountBalanceModelCopyWith<$Res> {
  factory _$$AccountBalanceModelImplCopyWith(_$AccountBalanceModelImpl value,
          $Res Function(_$AccountBalanceModelImpl) then) =
      __$$AccountBalanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Address rootTokenContract,
      @moneyFromStringJsonConverter Money fiatBalance,
      @moneyFromStringJsonConverter Money tokenBalance});

  @override
  $AddressCopyWith<$Res> get rootTokenContract;
}

/// @nodoc
class __$$AccountBalanceModelImplCopyWithImpl<$Res>
    extends _$AccountBalanceModelCopyWithImpl<$Res, _$AccountBalanceModelImpl>
    implements _$$AccountBalanceModelImplCopyWith<$Res> {
  __$$AccountBalanceModelImplCopyWithImpl(_$AccountBalanceModelImpl _value,
      $Res Function(_$AccountBalanceModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootTokenContract = null,
    Object? fiatBalance = null,
    Object? tokenBalance = null,
  }) {
    return _then(_$AccountBalanceModelImpl(
      rootTokenContract: null == rootTokenContract
          ? _value.rootTokenContract
          : rootTokenContract // ignore: cast_nullable_to_non_nullable
              as Address,
      fiatBalance: null == fiatBalance
          ? _value.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money,
      tokenBalance: null == tokenBalance
          ? _value.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AccountBalanceModelImpl implements _AccountBalanceModel {
  const _$AccountBalanceModelImpl(
      {required this.rootTokenContract,
      @moneyFromStringJsonConverter required this.fiatBalance,
      @moneyFromStringJsonConverter required this.tokenBalance});

  factory _$AccountBalanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AccountBalanceModelImplFromJson(json);

  @override
  final Address rootTokenContract;
  @override
  @moneyFromStringJsonConverter
  final Money fiatBalance;
  @override
  @moneyFromStringJsonConverter
  final Money tokenBalance;

  @override
  String toString() {
    return 'AccountBalanceModel(rootTokenContract: $rootTokenContract, fiatBalance: $fiatBalance, tokenBalance: $tokenBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountBalanceModelImpl &&
            (identical(other.rootTokenContract, rootTokenContract) ||
                other.rootTokenContract == rootTokenContract) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, rootTokenContract, fiatBalance, tokenBalance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountBalanceModelImplCopyWith<_$AccountBalanceModelImpl> get copyWith =>
      __$$AccountBalanceModelImplCopyWithImpl<_$AccountBalanceModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AccountBalanceModelImplToJson(
      this,
    );
  }
}

abstract class _AccountBalanceModel implements AccountBalanceModel {
  const factory _AccountBalanceModel(
          {required final Address rootTokenContract,
          @moneyFromStringJsonConverter required final Money fiatBalance,
          @moneyFromStringJsonConverter required final Money tokenBalance}) =
      _$AccountBalanceModelImpl;

  factory _AccountBalanceModel.fromJson(Map<String, dynamic> json) =
      _$AccountBalanceModelImpl.fromJson;

  @override
  Address get rootTokenContract;
  @override
  @moneyFromStringJsonConverter
  Money get fiatBalance;
  @override
  @moneyFromStringJsonConverter
  Money get tokenBalance;
  @override
  @JsonKey(ignore: true)
  _$$AccountBalanceModelImplCopyWith<_$AccountBalanceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
