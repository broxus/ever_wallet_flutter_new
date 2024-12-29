// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stever_withdraw_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StEverWithdrawRequest _$StEverWithdrawRequestFromJson(
    Map<String, dynamic> json) {
  return _StEverWithdrawRequest.fromJson(json);
}

/// @nodoc
mixin _$StEverWithdrawRequest {
  String get nonce => throw _privateConstructorUsedError;
  StEverWithdrawRequestData get data => throw _privateConstructorUsedError;
  @NekotonAddressConverter()
  Address get accountAddress => throw _privateConstructorUsedError;

  /// Serializes this StEverWithdrawRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StEverWithdrawRequestCopyWith<StEverWithdrawRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StEverWithdrawRequestCopyWith<$Res> {
  factory $StEverWithdrawRequestCopyWith(StEverWithdrawRequest value,
          $Res Function(StEverWithdrawRequest) then) =
      _$StEverWithdrawRequestCopyWithImpl<$Res, StEverWithdrawRequest>;
  @useResult
  $Res call(
      {String nonce,
      StEverWithdrawRequestData data,
      @NekotonAddressConverter() Address accountAddress});

  $StEverWithdrawRequestDataCopyWith<$Res> get data;
  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class _$StEverWithdrawRequestCopyWithImpl<$Res,
        $Val extends StEverWithdrawRequest>
    implements $StEverWithdrawRequestCopyWith<$Res> {
  _$StEverWithdrawRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonce = null,
    Object? data = null,
    Object? accountAddress = null,
  }) {
    return _then(_value.copyWith(
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as StEverWithdrawRequestData,
      accountAddress: null == accountAddress
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ) as $Val);
  }

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StEverWithdrawRequestDataCopyWith<$Res> get data {
    return $StEverWithdrawRequestDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get accountAddress {
    return $AddressCopyWith<$Res>(_value.accountAddress, (value) {
      return _then(_value.copyWith(accountAddress: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StEverWithdrawRequestImplCopyWith<$Res>
    implements $StEverWithdrawRequestCopyWith<$Res> {
  factory _$$StEverWithdrawRequestImplCopyWith(
          _$StEverWithdrawRequestImpl value,
          $Res Function(_$StEverWithdrawRequestImpl) then) =
      __$$StEverWithdrawRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String nonce,
      StEverWithdrawRequestData data,
      @NekotonAddressConverter() Address accountAddress});

  @override
  $StEverWithdrawRequestDataCopyWith<$Res> get data;
  @override
  $AddressCopyWith<$Res> get accountAddress;
}

/// @nodoc
class __$$StEverWithdrawRequestImplCopyWithImpl<$Res>
    extends _$StEverWithdrawRequestCopyWithImpl<$Res,
        _$StEverWithdrawRequestImpl>
    implements _$$StEverWithdrawRequestImplCopyWith<$Res> {
  __$$StEverWithdrawRequestImplCopyWithImpl(_$StEverWithdrawRequestImpl _value,
      $Res Function(_$StEverWithdrawRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nonce = null,
    Object? data = null,
    Object? accountAddress = null,
  }) {
    return _then(_$StEverWithdrawRequestImpl(
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as StEverWithdrawRequestData,
      accountAddress: null == accountAddress
          ? _value.accountAddress
          : accountAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StEverWithdrawRequestImpl implements _StEverWithdrawRequest {
  const _$StEverWithdrawRequestImpl(
      {required this.nonce,
      required this.data,
      @NekotonAddressConverter() required this.accountAddress});

  factory _$StEverWithdrawRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$StEverWithdrawRequestImplFromJson(json);

  @override
  final String nonce;
  @override
  final StEverWithdrawRequestData data;
  @override
  @NekotonAddressConverter()
  final Address accountAddress;

  @override
  String toString() {
    return 'StEverWithdrawRequest(nonce: $nonce, data: $data, accountAddress: $accountAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StEverWithdrawRequestImpl &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.accountAddress, accountAddress) ||
                other.accountAddress == accountAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, nonce, data, accountAddress);

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StEverWithdrawRequestImplCopyWith<_$StEverWithdrawRequestImpl>
      get copyWith => __$$StEverWithdrawRequestImplCopyWithImpl<
          _$StEverWithdrawRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StEverWithdrawRequestImplToJson(
      this,
    );
  }
}

abstract class _StEverWithdrawRequest implements StEverWithdrawRequest {
  const factory _StEverWithdrawRequest(
          {required final String nonce,
          required final StEverWithdrawRequestData data,
          @NekotonAddressConverter() required final Address accountAddress}) =
      _$StEverWithdrawRequestImpl;

  factory _StEverWithdrawRequest.fromJson(Map<String, dynamic> json) =
      _$StEverWithdrawRequestImpl.fromJson;

  @override
  String get nonce;
  @override
  StEverWithdrawRequestData get data;
  @override
  @NekotonAddressConverter()
  Address get accountAddress;

  /// Create a copy of StEverWithdrawRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StEverWithdrawRequestImplCopyWith<_$StEverWithdrawRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

StEverWithdrawRequestData _$StEverWithdrawRequestDataFromJson(
    Map<String, dynamic> json) {
  return _StEverWithdrawRequestData.fromJson(json);
}

/// @nodoc
mixin _$StEverWithdrawRequestData {
  @amountJsonConverter
  BigInt get amount => throw _privateConstructorUsedError;
  @timestampFromStringJsonConverter
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this StEverWithdrawRequestData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StEverWithdrawRequestDataCopyWith<StEverWithdrawRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StEverWithdrawRequestDataCopyWith<$Res> {
  factory $StEverWithdrawRequestDataCopyWith(StEverWithdrawRequestData value,
          $Res Function(StEverWithdrawRequestData) then) =
      _$StEverWithdrawRequestDataCopyWithImpl<$Res, StEverWithdrawRequestData>;
  @useResult
  $Res call(
      {@amountJsonConverter BigInt amount,
      @timestampFromStringJsonConverter DateTime timestamp});
}

/// @nodoc
class _$StEverWithdrawRequestDataCopyWithImpl<$Res,
        $Val extends StEverWithdrawRequestData>
    implements $StEverWithdrawRequestDataCopyWith<$Res> {
  _$StEverWithdrawRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StEverWithdrawRequestDataImplCopyWith<$Res>
    implements $StEverWithdrawRequestDataCopyWith<$Res> {
  factory _$$StEverWithdrawRequestDataImplCopyWith(
          _$StEverWithdrawRequestDataImpl value,
          $Res Function(_$StEverWithdrawRequestDataImpl) then) =
      __$$StEverWithdrawRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@amountJsonConverter BigInt amount,
      @timestampFromStringJsonConverter DateTime timestamp});
}

/// @nodoc
class __$$StEverWithdrawRequestDataImplCopyWithImpl<$Res>
    extends _$StEverWithdrawRequestDataCopyWithImpl<$Res,
        _$StEverWithdrawRequestDataImpl>
    implements _$$StEverWithdrawRequestDataImplCopyWith<$Res> {
  __$$StEverWithdrawRequestDataImplCopyWithImpl(
      _$StEverWithdrawRequestDataImpl _value,
      $Res Function(_$StEverWithdrawRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? timestamp = null,
  }) {
    return _then(_$StEverWithdrawRequestDataImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StEverWithdrawRequestDataImpl implements _StEverWithdrawRequestData {
  const _$StEverWithdrawRequestDataImpl(
      {@amountJsonConverter required this.amount,
      @timestampFromStringJsonConverter required this.timestamp});

  factory _$StEverWithdrawRequestDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$StEverWithdrawRequestDataImplFromJson(json);

  @override
  @amountJsonConverter
  final BigInt amount;
  @override
  @timestampFromStringJsonConverter
  final DateTime timestamp;

  @override
  String toString() {
    return 'StEverWithdrawRequestData(amount: $amount, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StEverWithdrawRequestDataImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, timestamp);

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StEverWithdrawRequestDataImplCopyWith<_$StEverWithdrawRequestDataImpl>
      get copyWith => __$$StEverWithdrawRequestDataImplCopyWithImpl<
          _$StEverWithdrawRequestDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StEverWithdrawRequestDataImplToJson(
      this,
    );
  }
}

abstract class _StEverWithdrawRequestData implements StEverWithdrawRequestData {
  const factory _StEverWithdrawRequestData(
      {@amountJsonConverter required final BigInt amount,
      @timestampFromStringJsonConverter
      required final DateTime timestamp}) = _$StEverWithdrawRequestDataImpl;

  factory _StEverWithdrawRequestData.fromJson(Map<String, dynamic> json) =
      _$StEverWithdrawRequestDataImpl.fromJson;

  @override
  @amountJsonConverter
  BigInt get amount;
  @override
  @timestampFromStringJsonConverter
  DateTime get timestamp;

  /// Create a copy of StEverWithdrawRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StEverWithdrawRequestDataImplCopyWith<_$StEverWithdrawRequestDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}
