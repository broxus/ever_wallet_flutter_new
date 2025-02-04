// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gas_price_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GasPriceParams _$GasPriceParamsFromJson(Map<String, dynamic> json) {
  return _GasPriceParams.fromJson(json);
}

/// @nodoc
mixin _$GasPriceParams {
  /// Flat tag
  String get tag1 => throw _privateConstructorUsedError;

  /// Ext tag
  String get tag2 => throw _privateConstructorUsedError;

  /// The price of gas unit
  @amountJsonConverter
  BigInt get gasPrice => throw _privateConstructorUsedError;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  @amountJsonConverter
  BigInt get gasLimit => throw _privateConstructorUsedError;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  @amountJsonConverter
  BigInt get specialGasLimit => throw _privateConstructorUsedError;

  /// The maximum amount of gas available before `ACCEPT`
  @amountJsonConverter
  BigInt get gasCredit => throw _privateConstructorUsedError;

  /// The maximum amount of gas units per block
  @amountJsonConverter
  BigInt get blockGasLimit => throw _privateConstructorUsedError;

  /// Amount of debt (in tokens) after which the account will be frozen
  @amountJsonConverter
  BigInt get freezeDueLimit => throw _privateConstructorUsedError;

  /// Amount of debt (in tokens) after which the contract will be deleted
  @amountJsonConverter
  BigInt get deleteDueLimit => throw _privateConstructorUsedError;

  /// Size of the first portion of gas with different price
  @amountJsonConverter
  BigInt get flatGasLimit => throw _privateConstructorUsedError;

  /// The gas price for the first portion determinted by flatGasLimit
  @amountJsonConverter
  BigInt get flatGasPrice => throw _privateConstructorUsedError;

  /// Serializes this GasPriceParams to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GasPriceParamsCopyWith<GasPriceParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GasPriceParamsCopyWith<$Res> {
  factory $GasPriceParamsCopyWith(
          GasPriceParams value, $Res Function(GasPriceParams) then) =
      _$GasPriceParamsCopyWithImpl<$Res, GasPriceParams>;
  @useResult
  $Res call(
      {String tag1,
      String tag2,
      @amountJsonConverter BigInt gasPrice,
      @amountJsonConverter BigInt gasLimit,
      @amountJsonConverter BigInt specialGasLimit,
      @amountJsonConverter BigInt gasCredit,
      @amountJsonConverter BigInt blockGasLimit,
      @amountJsonConverter BigInt freezeDueLimit,
      @amountJsonConverter BigInt deleteDueLimit,
      @amountJsonConverter BigInt flatGasLimit,
      @amountJsonConverter BigInt flatGasPrice});
}

/// @nodoc
class _$GasPriceParamsCopyWithImpl<$Res, $Val extends GasPriceParams>
    implements $GasPriceParamsCopyWith<$Res> {
  _$GasPriceParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag1 = null,
    Object? tag2 = null,
    Object? gasPrice = null,
    Object? gasLimit = null,
    Object? specialGasLimit = null,
    Object? gasCredit = null,
    Object? blockGasLimit = null,
    Object? freezeDueLimit = null,
    Object? deleteDueLimit = null,
    Object? flatGasLimit = null,
    Object? flatGasPrice = null,
  }) {
    return _then(_value.copyWith(
      tag1: null == tag1
          ? _value.tag1
          : tag1 // ignore: cast_nullable_to_non_nullable
              as String,
      tag2: null == tag2
          ? _value.tag2
          : tag2 // ignore: cast_nullable_to_non_nullable
              as String,
      gasPrice: null == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasLimit: null == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      specialGasLimit: null == specialGasLimit
          ? _value.specialGasLimit
          : specialGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasCredit: null == gasCredit
          ? _value.gasCredit
          : gasCredit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      blockGasLimit: null == blockGasLimit
          ? _value.blockGasLimit
          : blockGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      freezeDueLimit: null == freezeDueLimit
          ? _value.freezeDueLimit
          : freezeDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      deleteDueLimit: null == deleteDueLimit
          ? _value.deleteDueLimit
          : deleteDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasLimit: null == flatGasLimit
          ? _value.flatGasLimit
          : flatGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasPrice: null == flatGasPrice
          ? _value.flatGasPrice
          : flatGasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GasPriceParamsImplCopyWith<$Res>
    implements $GasPriceParamsCopyWith<$Res> {
  factory _$$GasPriceParamsImplCopyWith(_$GasPriceParamsImpl value,
          $Res Function(_$GasPriceParamsImpl) then) =
      __$$GasPriceParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tag1,
      String tag2,
      @amountJsonConverter BigInt gasPrice,
      @amountJsonConverter BigInt gasLimit,
      @amountJsonConverter BigInt specialGasLimit,
      @amountJsonConverter BigInt gasCredit,
      @amountJsonConverter BigInt blockGasLimit,
      @amountJsonConverter BigInt freezeDueLimit,
      @amountJsonConverter BigInt deleteDueLimit,
      @amountJsonConverter BigInt flatGasLimit,
      @amountJsonConverter BigInt flatGasPrice});
}

/// @nodoc
class __$$GasPriceParamsImplCopyWithImpl<$Res>
    extends _$GasPriceParamsCopyWithImpl<$Res, _$GasPriceParamsImpl>
    implements _$$GasPriceParamsImplCopyWith<$Res> {
  __$$GasPriceParamsImplCopyWithImpl(
      _$GasPriceParamsImpl _value, $Res Function(_$GasPriceParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag1 = null,
    Object? tag2 = null,
    Object? gasPrice = null,
    Object? gasLimit = null,
    Object? specialGasLimit = null,
    Object? gasCredit = null,
    Object? blockGasLimit = null,
    Object? freezeDueLimit = null,
    Object? deleteDueLimit = null,
    Object? flatGasLimit = null,
    Object? flatGasPrice = null,
  }) {
    return _then(_$GasPriceParamsImpl(
      tag1: null == tag1
          ? _value.tag1
          : tag1 // ignore: cast_nullable_to_non_nullable
              as String,
      tag2: null == tag2
          ? _value.tag2
          : tag2 // ignore: cast_nullable_to_non_nullable
              as String,
      gasPrice: null == gasPrice
          ? _value.gasPrice
          : gasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasLimit: null == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      specialGasLimit: null == specialGasLimit
          ? _value.specialGasLimit
          : specialGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      gasCredit: null == gasCredit
          ? _value.gasCredit
          : gasCredit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      blockGasLimit: null == blockGasLimit
          ? _value.blockGasLimit
          : blockGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      freezeDueLimit: null == freezeDueLimit
          ? _value.freezeDueLimit
          : freezeDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      deleteDueLimit: null == deleteDueLimit
          ? _value.deleteDueLimit
          : deleteDueLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasLimit: null == flatGasLimit
          ? _value.flatGasLimit
          : flatGasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      flatGasPrice: null == flatGasPrice
          ? _value.flatGasPrice
          : flatGasPrice // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GasPriceParamsImpl implements _GasPriceParams {
  const _$GasPriceParamsImpl(
      {required this.tag1,
      required this.tag2,
      @amountJsonConverter required this.gasPrice,
      @amountJsonConverter required this.gasLimit,
      @amountJsonConverter required this.specialGasLimit,
      @amountJsonConverter required this.gasCredit,
      @amountJsonConverter required this.blockGasLimit,
      @amountJsonConverter required this.freezeDueLimit,
      @amountJsonConverter required this.deleteDueLimit,
      @amountJsonConverter required this.flatGasLimit,
      @amountJsonConverter required this.flatGasPrice});

  factory _$GasPriceParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GasPriceParamsImplFromJson(json);

  /// Flat tag
  @override
  final String tag1;

  /// Ext tag
  @override
  final String tag2;

  /// The price of gas unit
  @override
  @amountJsonConverter
  final BigInt gasPrice;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  @override
  @amountJsonConverter
  final BigInt gasLimit;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  @override
  @amountJsonConverter
  final BigInt specialGasLimit;

  /// The maximum amount of gas available before `ACCEPT`
  @override
  @amountJsonConverter
  final BigInt gasCredit;

  /// The maximum amount of gas units per block
  @override
  @amountJsonConverter
  final BigInt blockGasLimit;

  /// Amount of debt (in tokens) after which the account will be frozen
  @override
  @amountJsonConverter
  final BigInt freezeDueLimit;

  /// Amount of debt (in tokens) after which the contract will be deleted
  @override
  @amountJsonConverter
  final BigInt deleteDueLimit;

  /// Size of the first portion of gas with different price
  @override
  @amountJsonConverter
  final BigInt flatGasLimit;

  /// The gas price for the first portion determinted by flatGasLimit
  @override
  @amountJsonConverter
  final BigInt flatGasPrice;

  @override
  String toString() {
    return 'GasPriceParams(tag1: $tag1, tag2: $tag2, gasPrice: $gasPrice, gasLimit: $gasLimit, specialGasLimit: $specialGasLimit, gasCredit: $gasCredit, blockGasLimit: $blockGasLimit, freezeDueLimit: $freezeDueLimit, deleteDueLimit: $deleteDueLimit, flatGasLimit: $flatGasLimit, flatGasPrice: $flatGasPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GasPriceParamsImpl &&
            (identical(other.tag1, tag1) || other.tag1 == tag1) &&
            (identical(other.tag2, tag2) || other.tag2 == tag2) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.specialGasLimit, specialGasLimit) ||
                other.specialGasLimit == specialGasLimit) &&
            (identical(other.gasCredit, gasCredit) ||
                other.gasCredit == gasCredit) &&
            (identical(other.blockGasLimit, blockGasLimit) ||
                other.blockGasLimit == blockGasLimit) &&
            (identical(other.freezeDueLimit, freezeDueLimit) ||
                other.freezeDueLimit == freezeDueLimit) &&
            (identical(other.deleteDueLimit, deleteDueLimit) ||
                other.deleteDueLimit == deleteDueLimit) &&
            (identical(other.flatGasLimit, flatGasLimit) ||
                other.flatGasLimit == flatGasLimit) &&
            (identical(other.flatGasPrice, flatGasPrice) ||
                other.flatGasPrice == flatGasPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tag1,
      tag2,
      gasPrice,
      gasLimit,
      specialGasLimit,
      gasCredit,
      blockGasLimit,
      freezeDueLimit,
      deleteDueLimit,
      flatGasLimit,
      flatGasPrice);

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GasPriceParamsImplCopyWith<_$GasPriceParamsImpl> get copyWith =>
      __$$GasPriceParamsImplCopyWithImpl<_$GasPriceParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GasPriceParamsImplToJson(
      this,
    );
  }
}

abstract class _GasPriceParams implements GasPriceParams {
  const factory _GasPriceParams(
          {required final String tag1,
          required final String tag2,
          @amountJsonConverter required final BigInt gasPrice,
          @amountJsonConverter required final BigInt gasLimit,
          @amountJsonConverter required final BigInt specialGasLimit,
          @amountJsonConverter required final BigInt gasCredit,
          @amountJsonConverter required final BigInt blockGasLimit,
          @amountJsonConverter required final BigInt freezeDueLimit,
          @amountJsonConverter required final BigInt deleteDueLimit,
          @amountJsonConverter required final BigInt flatGasLimit,
          @amountJsonConverter required final BigInt flatGasPrice}) =
      _$GasPriceParamsImpl;

  factory _GasPriceParams.fromJson(Map<String, dynamic> json) =
      _$GasPriceParamsImpl.fromJson;

  /// Flat tag
  @override
  String get tag1;

  /// Ext tag
  @override
  String get tag2;

  /// The price of gas unit
  @override
  @amountJsonConverter
  BigInt get gasPrice;

  /// The maximum amount of gas available for a compute phase of
  /// an ordinary transaction
  @override
  @amountJsonConverter
  BigInt get gasLimit;

  /// The maximum amount of gas available for a compute phase of
  /// a special transaction
  @override
  @amountJsonConverter
  BigInt get specialGasLimit;

  /// The maximum amount of gas available before `ACCEPT`
  @override
  @amountJsonConverter
  BigInt get gasCredit;

  /// The maximum amount of gas units per block
  @override
  @amountJsonConverter
  BigInt get blockGasLimit;

  /// Amount of debt (in tokens) after which the account will be frozen
  @override
  @amountJsonConverter
  BigInt get freezeDueLimit;

  /// Amount of debt (in tokens) after which the contract will be deleted
  @override
  @amountJsonConverter
  BigInt get deleteDueLimit;

  /// Size of the first portion of gas with different price
  @override
  @amountJsonConverter
  BigInt get flatGasLimit;

  /// The gas price for the first portion determinted by flatGasLimit
  @override
  @amountJsonConverter
  BigInt get flatGasPrice;

  /// Create a copy of GasPriceParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GasPriceParamsImplCopyWith<_$GasPriceParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
