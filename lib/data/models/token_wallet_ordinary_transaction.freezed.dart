// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_ordinary_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenWalletOrdinaryTransaction {
  String get lt => throw _privateConstructorUsedError;
  bool get isOutgoing => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError;
  @amountJsonConverter
  BigInt get value => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  @amountJsonConverter
  BigInt get fees => throw _privateConstructorUsedError;
  String get hash => throw _privateConstructorUsedError;
  String? get prevTransactionLt => throw _privateConstructorUsedError;
  TokenIncomingTransfer? get incomingTransfer =>
      throw _privateConstructorUsedError;
  TokenOutgoingTransfer? get outgoingTransfer =>
      throw _privateConstructorUsedError;
  TokenSwapBack? get swapBack => throw _privateConstructorUsedError;
  String? get accept => throw _privateConstructorUsedError;
  String? get transferBounced => throw _privateConstructorUsedError;
  String? get swapBackBounced => throw _privateConstructorUsedError;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TokenWalletOrdinaryTransactionCopyWith<TokenWalletOrdinaryTransaction>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenWalletOrdinaryTransactionCopyWith<$Res> {
  factory $TokenWalletOrdinaryTransactionCopyWith(
          TokenWalletOrdinaryTransaction value,
          $Res Function(TokenWalletOrdinaryTransaction) then) =
      _$TokenWalletOrdinaryTransactionCopyWithImpl<$Res,
          TokenWalletOrdinaryTransaction>;
  @useResult
  $Res call(
      {String lt,
      bool isOutgoing,
      Address address,
      @amountJsonConverter BigInt value,
      DateTime date,
      @amountJsonConverter BigInt fees,
      String hash,
      String? prevTransactionLt,
      TokenIncomingTransfer? incomingTransfer,
      TokenOutgoingTransfer? outgoingTransfer,
      TokenSwapBack? swapBack,
      String? accept,
      String? transferBounced,
      String? swapBackBounced});

  $AddressCopyWith<$Res> get address;
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer;
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer;
  $TokenSwapBackCopyWith<$Res>? get swapBack;
}

/// @nodoc
class _$TokenWalletOrdinaryTransactionCopyWithImpl<$Res,
        $Val extends TokenWalletOrdinaryTransaction>
    implements $TokenWalletOrdinaryTransactionCopyWith<$Res> {
  _$TokenWalletOrdinaryTransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lt = null,
    Object? isOutgoing = null,
    Object? address = null,
    Object? value = null,
    Object? date = null,
    Object? fees = null,
    Object? hash = null,
    Object? prevTransactionLt = freezed,
    Object? incomingTransfer = freezed,
    Object? outgoingTransfer = freezed,
    Object? swapBack = freezed,
    Object? accept = freezed,
    Object? transferBounced = freezed,
    Object? swapBackBounced = freezed,
  }) {
    return _then(_value.copyWith(
      lt: null == lt
          ? _value.lt
          : lt // ignore: cast_nullable_to_non_nullable
              as String,
      isOutgoing: null == isOutgoing
          ? _value.isOutgoing
          : isOutgoing // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as BigInt,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      prevTransactionLt: freezed == prevTransactionLt
          ? _value.prevTransactionLt
          : prevTransactionLt // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingTransfer: freezed == incomingTransfer
          ? _value.incomingTransfer
          : incomingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenIncomingTransfer?,
      outgoingTransfer: freezed == outgoingTransfer
          ? _value.outgoingTransfer
          : outgoingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenOutgoingTransfer?,
      swapBack: freezed == swapBack
          ? _value.swapBack
          : swapBack // ignore: cast_nullable_to_non_nullable
              as TokenSwapBack?,
      accept: freezed == accept
          ? _value.accept
          : accept // ignore: cast_nullable_to_non_nullable
              as String?,
      transferBounced: freezed == transferBounced
          ? _value.transferBounced
          : transferBounced // ignore: cast_nullable_to_non_nullable
              as String?,
      swapBackBounced: freezed == swapBackBounced
          ? _value.swapBackBounced
          : swapBackBounced // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer {
    if (_value.incomingTransfer == null) {
      return null;
    }

    return $TokenIncomingTransferCopyWith<$Res>(_value.incomingTransfer!,
        (value) {
      return _then(_value.copyWith(incomingTransfer: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer {
    if (_value.outgoingTransfer == null) {
      return null;
    }

    return $TokenOutgoingTransferCopyWith<$Res>(_value.outgoingTransfer!,
        (value) {
      return _then(_value.copyWith(outgoingTransfer: value) as $Val);
    });
  }

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenSwapBackCopyWith<$Res>? get swapBack {
    if (_value.swapBack == null) {
      return null;
    }

    return $TokenSwapBackCopyWith<$Res>(_value.swapBack!, (value) {
      return _then(_value.copyWith(swapBack: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokenWalletOrdinaryTransactionImplCopyWith<$Res>
    implements $TokenWalletOrdinaryTransactionCopyWith<$Res> {
  factory _$$TokenWalletOrdinaryTransactionImplCopyWith(
          _$TokenWalletOrdinaryTransactionImpl value,
          $Res Function(_$TokenWalletOrdinaryTransactionImpl) then) =
      __$$TokenWalletOrdinaryTransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String lt,
      bool isOutgoing,
      Address address,
      @amountJsonConverter BigInt value,
      DateTime date,
      @amountJsonConverter BigInt fees,
      String hash,
      String? prevTransactionLt,
      TokenIncomingTransfer? incomingTransfer,
      TokenOutgoingTransfer? outgoingTransfer,
      TokenSwapBack? swapBack,
      String? accept,
      String? transferBounced,
      String? swapBackBounced});

  @override
  $AddressCopyWith<$Res> get address;
  @override
  $TokenIncomingTransferCopyWith<$Res>? get incomingTransfer;
  @override
  $TokenOutgoingTransferCopyWith<$Res>? get outgoingTransfer;
  @override
  $TokenSwapBackCopyWith<$Res>? get swapBack;
}

/// @nodoc
class __$$TokenWalletOrdinaryTransactionImplCopyWithImpl<$Res>
    extends _$TokenWalletOrdinaryTransactionCopyWithImpl<$Res,
        _$TokenWalletOrdinaryTransactionImpl>
    implements _$$TokenWalletOrdinaryTransactionImplCopyWith<$Res> {
  __$$TokenWalletOrdinaryTransactionImplCopyWithImpl(
      _$TokenWalletOrdinaryTransactionImpl _value,
      $Res Function(_$TokenWalletOrdinaryTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lt = null,
    Object? isOutgoing = null,
    Object? address = null,
    Object? value = null,
    Object? date = null,
    Object? fees = null,
    Object? hash = null,
    Object? prevTransactionLt = freezed,
    Object? incomingTransfer = freezed,
    Object? outgoingTransfer = freezed,
    Object? swapBack = freezed,
    Object? accept = freezed,
    Object? transferBounced = freezed,
    Object? swapBackBounced = freezed,
  }) {
    return _then(_$TokenWalletOrdinaryTransactionImpl(
      lt: null == lt
          ? _value.lt
          : lt // ignore: cast_nullable_to_non_nullable
              as String,
      isOutgoing: null == isOutgoing
          ? _value.isOutgoing
          : isOutgoing // ignore: cast_nullable_to_non_nullable
              as bool,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      fees: null == fees
          ? _value.fees
          : fees // ignore: cast_nullable_to_non_nullable
              as BigInt,
      hash: null == hash
          ? _value.hash
          : hash // ignore: cast_nullable_to_non_nullable
              as String,
      prevTransactionLt: freezed == prevTransactionLt
          ? _value.prevTransactionLt
          : prevTransactionLt // ignore: cast_nullable_to_non_nullable
              as String?,
      incomingTransfer: freezed == incomingTransfer
          ? _value.incomingTransfer
          : incomingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenIncomingTransfer?,
      outgoingTransfer: freezed == outgoingTransfer
          ? _value.outgoingTransfer
          : outgoingTransfer // ignore: cast_nullable_to_non_nullable
              as TokenOutgoingTransfer?,
      swapBack: freezed == swapBack
          ? _value.swapBack
          : swapBack // ignore: cast_nullable_to_non_nullable
              as TokenSwapBack?,
      accept: freezed == accept
          ? _value.accept
          : accept // ignore: cast_nullable_to_non_nullable
              as String?,
      transferBounced: freezed == transferBounced
          ? _value.transferBounced
          : transferBounced // ignore: cast_nullable_to_non_nullable
              as String?,
      swapBackBounced: freezed == swapBackBounced
          ? _value.swapBackBounced
          : swapBackBounced // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$TokenWalletOrdinaryTransactionImpl
    implements _TokenWalletOrdinaryTransaction {
  const _$TokenWalletOrdinaryTransactionImpl(
      {required this.lt,
      required this.isOutgoing,
      required this.address,
      @amountJsonConverter required this.value,
      required this.date,
      @amountJsonConverter required this.fees,
      required this.hash,
      this.prevTransactionLt,
      this.incomingTransfer,
      this.outgoingTransfer,
      this.swapBack,
      this.accept,
      this.transferBounced,
      this.swapBackBounced});

  @override
  final String lt;
  @override
  final bool isOutgoing;
  @override
  final Address address;
  @override
  @amountJsonConverter
  final BigInt value;
  @override
  final DateTime date;
  @override
  @amountJsonConverter
  final BigInt fees;
  @override
  final String hash;
  @override
  final String? prevTransactionLt;
  @override
  final TokenIncomingTransfer? incomingTransfer;
  @override
  final TokenOutgoingTransfer? outgoingTransfer;
  @override
  final TokenSwapBack? swapBack;
  @override
  final String? accept;
  @override
  final String? transferBounced;
  @override
  final String? swapBackBounced;

  @override
  String toString() {
    return 'TokenWalletOrdinaryTransaction(lt: $lt, isOutgoing: $isOutgoing, address: $address, value: $value, date: $date, fees: $fees, hash: $hash, prevTransactionLt: $prevTransactionLt, incomingTransfer: $incomingTransfer, outgoingTransfer: $outgoingTransfer, swapBack: $swapBack, accept: $accept, transferBounced: $transferBounced, swapBackBounced: $swapBackBounced)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenWalletOrdinaryTransactionImpl &&
            (identical(other.lt, lt) || other.lt == lt) &&
            (identical(other.isOutgoing, isOutgoing) ||
                other.isOutgoing == isOutgoing) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.fees, fees) || other.fees == fees) &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.prevTransactionLt, prevTransactionLt) ||
                other.prevTransactionLt == prevTransactionLt) &&
            (identical(other.incomingTransfer, incomingTransfer) ||
                other.incomingTransfer == incomingTransfer) &&
            (identical(other.outgoingTransfer, outgoingTransfer) ||
                other.outgoingTransfer == outgoingTransfer) &&
            (identical(other.swapBack, swapBack) ||
                other.swapBack == swapBack) &&
            (identical(other.accept, accept) || other.accept == accept) &&
            (identical(other.transferBounced, transferBounced) ||
                other.transferBounced == transferBounced) &&
            (identical(other.swapBackBounced, swapBackBounced) ||
                other.swapBackBounced == swapBackBounced));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      lt,
      isOutgoing,
      address,
      value,
      date,
      fees,
      hash,
      prevTransactionLt,
      incomingTransfer,
      outgoingTransfer,
      swapBack,
      accept,
      transferBounced,
      swapBackBounced);

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenWalletOrdinaryTransactionImplCopyWith<
          _$TokenWalletOrdinaryTransactionImpl>
      get copyWith => __$$TokenWalletOrdinaryTransactionImplCopyWithImpl<
          _$TokenWalletOrdinaryTransactionImpl>(this, _$identity);
}

abstract class _TokenWalletOrdinaryTransaction
    implements TokenWalletOrdinaryTransaction {
  const factory _TokenWalletOrdinaryTransaction(
      {required final String lt,
      required final bool isOutgoing,
      required final Address address,
      @amountJsonConverter required final BigInt value,
      required final DateTime date,
      @amountJsonConverter required final BigInt fees,
      required final String hash,
      final String? prevTransactionLt,
      final TokenIncomingTransfer? incomingTransfer,
      final TokenOutgoingTransfer? outgoingTransfer,
      final TokenSwapBack? swapBack,
      final String? accept,
      final String? transferBounced,
      final String? swapBackBounced}) = _$TokenWalletOrdinaryTransactionImpl;

  @override
  String get lt;
  @override
  bool get isOutgoing;
  @override
  Address get address;
  @override
  @amountJsonConverter
  BigInt get value;
  @override
  DateTime get date;
  @override
  @amountJsonConverter
  BigInt get fees;
  @override
  String get hash;
  @override
  String? get prevTransactionLt;
  @override
  TokenIncomingTransfer? get incomingTransfer;
  @override
  TokenOutgoingTransfer? get outgoingTransfer;
  @override
  TokenSwapBack? get swapBack;
  @override
  String? get accept;
  @override
  String? get transferBounced;
  @override
  String? get swapBackBounced;

  /// Create a copy of TokenWalletOrdinaryTransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TokenWalletOrdinaryTransactionImplCopyWith<
          _$TokenWalletOrdinaryTransactionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
