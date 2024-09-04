// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_transaction_with_additional_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PendingTransactionWithAdditionalInfo
    _$PendingTransactionWithAdditionalInfoFromJson(Map<String, dynamic> json) {
  return _PendingTransactionWithAdditionalInfo.fromJson(json);
}

/// @nodoc
mixin _$PendingTransactionWithAdditionalInfo {
  PendingTransaction get transaction => throw _privateConstructorUsedError;
  @amountJsonConverter
  BigInt? get amount => throw _privateConstructorUsedError;
  int get createdAt => throw _privateConstructorUsedError;
  String? get dst => throw _privateConstructorUsedError;

  /// Serializes this PendingTransactionWithAdditionalInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingTransactionWithAdditionalInfoCopyWith<
          PendingTransactionWithAdditionalInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  factory $PendingTransactionWithAdditionalInfoCopyWith(
          PendingTransactionWithAdditionalInfo value,
          $Res Function(PendingTransactionWithAdditionalInfo) then) =
      _$PendingTransactionWithAdditionalInfoCopyWithImpl<$Res,
          PendingTransactionWithAdditionalInfo>;
  @useResult
  $Res call(
      {PendingTransaction transaction,
      @amountJsonConverter BigInt? amount,
      int createdAt,
      String? dst});

  $PendingTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class _$PendingTransactionWithAdditionalInfoCopyWithImpl<$Res,
        $Val extends PendingTransactionWithAdditionalInfo>
    implements $PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  _$PendingTransactionWithAdditionalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? amount = freezed,
    Object? createdAt = null,
    Object? dst = freezed,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as PendingTransaction,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      dst: freezed == dst
          ? _value.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PendingTransactionCopyWith<$Res> get transaction {
    return $PendingTransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PendingTransactionWithAdditionalInfoImplCopyWith<$Res>
    implements $PendingTransactionWithAdditionalInfoCopyWith<$Res> {
  factory _$$PendingTransactionWithAdditionalInfoImplCopyWith(
          _$PendingTransactionWithAdditionalInfoImpl value,
          $Res Function(_$PendingTransactionWithAdditionalInfoImpl) then) =
      __$$PendingTransactionWithAdditionalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PendingTransaction transaction,
      @amountJsonConverter BigInt? amount,
      int createdAt,
      String? dst});

  @override
  $PendingTransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$PendingTransactionWithAdditionalInfoImplCopyWithImpl<$Res>
    extends _$PendingTransactionWithAdditionalInfoCopyWithImpl<$Res,
        _$PendingTransactionWithAdditionalInfoImpl>
    implements _$$PendingTransactionWithAdditionalInfoImplCopyWith<$Res> {
  __$$PendingTransactionWithAdditionalInfoImplCopyWithImpl(
      _$PendingTransactionWithAdditionalInfoImpl _value,
      $Res Function(_$PendingTransactionWithAdditionalInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? amount = freezed,
    Object? createdAt = null,
    Object? dst = freezed,
  }) {
    return _then(_$PendingTransactionWithAdditionalInfoImpl(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as PendingTransaction,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as int,
      dst: freezed == dst
          ? _value.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PendingTransactionWithAdditionalInfoImpl
    extends _PendingTransactionWithAdditionalInfo {
  const _$PendingTransactionWithAdditionalInfoImpl(
      {required this.transaction,
      @amountJsonConverter required this.amount,
      required this.createdAt,
      this.dst})
      : super._();

  factory _$PendingTransactionWithAdditionalInfoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PendingTransactionWithAdditionalInfoImplFromJson(json);

  @override
  final PendingTransaction transaction;
  @override
  @amountJsonConverter
  final BigInt? amount;
  @override
  final int createdAt;
  @override
  final String? dst;

  @override
  String toString() {
    return 'PendingTransactionWithAdditionalInfo(transaction: $transaction, amount: $amount, createdAt: $createdAt, dst: $dst)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingTransactionWithAdditionalInfoImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.dst, dst) || other.dst == dst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transaction, amount, createdAt, dst);

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingTransactionWithAdditionalInfoImplCopyWith<
          _$PendingTransactionWithAdditionalInfoImpl>
      get copyWith => __$$PendingTransactionWithAdditionalInfoImplCopyWithImpl<
          _$PendingTransactionWithAdditionalInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingTransactionWithAdditionalInfoImplToJson(
      this,
    );
  }
}

abstract class _PendingTransactionWithAdditionalInfo
    extends PendingTransactionWithAdditionalInfo {
  const factory _PendingTransactionWithAdditionalInfo(
      {required final PendingTransaction transaction,
      @amountJsonConverter required final BigInt? amount,
      required final int createdAt,
      final String? dst}) = _$PendingTransactionWithAdditionalInfoImpl;
  const _PendingTransactionWithAdditionalInfo._() : super._();

  factory _PendingTransactionWithAdditionalInfo.fromJson(
          Map<String, dynamic> json) =
      _$PendingTransactionWithAdditionalInfoImpl.fromJson;

  @override
  PendingTransaction get transaction;
  @override
  @amountJsonConverter
  BigInt? get amount;
  @override
  int get createdAt;
  @override
  String? get dst;

  /// Create a copy of PendingTransactionWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingTransactionWithAdditionalInfoImplCopyWith<
          _$PendingTransactionWithAdditionalInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
