// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'currency_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CurrencyDto {
  @HiveField(0)
  String get currency => throw _privateConstructorUsedError;
  @HiveField(1)
  String get address => throw _privateConstructorUsedError;
  @HiveField(2)
  String get price => throw _privateConstructorUsedError;
  @HiveField(3)
  String get priceChange => throw _privateConstructorUsedError;
  @HiveField(4)
  String get tvl => throw _privateConstructorUsedError;
  @HiveField(5)
  String get tvlChange => throw _privateConstructorUsedError;
  @HiveField(6)
  String get volume24h => throw _privateConstructorUsedError;
  @HiveField(7)
  String get volumeChange24h => throw _privateConstructorUsedError;
  @HiveField(8)
  String get volume7d => throw _privateConstructorUsedError;
  @HiveField(9)
  String get fee24h => throw _privateConstructorUsedError;
  @HiveField(10)
  int get transactionsCount24h => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CurrencyDtoCopyWith<CurrencyDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyDtoCopyWith<$Res> {
  factory $CurrencyDtoCopyWith(
          CurrencyDto value, $Res Function(CurrencyDto) then) =
      _$CurrencyDtoCopyWithImpl<$Res, CurrencyDto>;
  @useResult
  $Res call(
      {@HiveField(0) String currency,
      @HiveField(1) String address,
      @HiveField(2) String price,
      @HiveField(3) String priceChange,
      @HiveField(4) String tvl,
      @HiveField(5) String tvlChange,
      @HiveField(6) String volume24h,
      @HiveField(7) String volumeChange24h,
      @HiveField(8) String volume7d,
      @HiveField(9) String fee24h,
      @HiveField(10) int transactionsCount24h});
}

/// @nodoc
class _$CurrencyDtoCopyWithImpl<$Res, $Val extends CurrencyDto>
    implements $CurrencyDtoCopyWith<$Res> {
  _$CurrencyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? address = null,
    Object? price = null,
    Object? priceChange = null,
    Object? tvl = null,
    Object? tvlChange = null,
    Object? volume24h = null,
    Object? volumeChange24h = null,
    Object? volume7d = null,
    Object? fee24h = null,
    Object? transactionsCount24h = null,
  }) {
    return _then(_value.copyWith(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      priceChange: null == priceChange
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as String,
      tvl: null == tvl
          ? _value.tvl
          : tvl // ignore: cast_nullable_to_non_nullable
              as String,
      tvlChange: null == tvlChange
          ? _value.tvlChange
          : tvlChange // ignore: cast_nullable_to_non_nullable
              as String,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as String,
      volumeChange24h: null == volumeChange24h
          ? _value.volumeChange24h
          : volumeChange24h // ignore: cast_nullable_to_non_nullable
              as String,
      volume7d: null == volume7d
          ? _value.volume7d
          : volume7d // ignore: cast_nullable_to_non_nullable
              as String,
      fee24h: null == fee24h
          ? _value.fee24h
          : fee24h // ignore: cast_nullable_to_non_nullable
              as String,
      transactionsCount24h: null == transactionsCount24h
          ? _value.transactionsCount24h
          : transactionsCount24h // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrencyDtoImplCopyWith<$Res>
    implements $CurrencyDtoCopyWith<$Res> {
  factory _$$CurrencyDtoImplCopyWith(
          _$CurrencyDtoImpl value, $Res Function(_$CurrencyDtoImpl) then) =
      __$$CurrencyDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String currency,
      @HiveField(1) String address,
      @HiveField(2) String price,
      @HiveField(3) String priceChange,
      @HiveField(4) String tvl,
      @HiveField(5) String tvlChange,
      @HiveField(6) String volume24h,
      @HiveField(7) String volumeChange24h,
      @HiveField(8) String volume7d,
      @HiveField(9) String fee24h,
      @HiveField(10) int transactionsCount24h});
}

/// @nodoc
class __$$CurrencyDtoImplCopyWithImpl<$Res>
    extends _$CurrencyDtoCopyWithImpl<$Res, _$CurrencyDtoImpl>
    implements _$$CurrencyDtoImplCopyWith<$Res> {
  __$$CurrencyDtoImplCopyWithImpl(
      _$CurrencyDtoImpl _value, $Res Function(_$CurrencyDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? address = null,
    Object? price = null,
    Object? priceChange = null,
    Object? tvl = null,
    Object? tvlChange = null,
    Object? volume24h = null,
    Object? volumeChange24h = null,
    Object? volume7d = null,
    Object? fee24h = null,
    Object? transactionsCount24h = null,
  }) {
    return _then(_$CurrencyDtoImpl(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      priceChange: null == priceChange
          ? _value.priceChange
          : priceChange // ignore: cast_nullable_to_non_nullable
              as String,
      tvl: null == tvl
          ? _value.tvl
          : tvl // ignore: cast_nullable_to_non_nullable
              as String,
      tvlChange: null == tvlChange
          ? _value.tvlChange
          : tvlChange // ignore: cast_nullable_to_non_nullable
              as String,
      volume24h: null == volume24h
          ? _value.volume24h
          : volume24h // ignore: cast_nullable_to_non_nullable
              as String,
      volumeChange24h: null == volumeChange24h
          ? _value.volumeChange24h
          : volumeChange24h // ignore: cast_nullable_to_non_nullable
              as String,
      volume7d: null == volume7d
          ? _value.volume7d
          : volume7d // ignore: cast_nullable_to_non_nullable
              as String,
      fee24h: null == fee24h
          ? _value.fee24h
          : fee24h // ignore: cast_nullable_to_non_nullable
              as String,
      transactionsCount24h: null == transactionsCount24h
          ? _value.transactionsCount24h
          : transactionsCount24h // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 4)
class _$CurrencyDtoImpl implements _CurrencyDto {
  const _$CurrencyDtoImpl(
      {@HiveField(0) required this.currency,
      @HiveField(1) required this.address,
      @HiveField(2) required this.price,
      @HiveField(3) required this.priceChange,
      @HiveField(4) required this.tvl,
      @HiveField(5) required this.tvlChange,
      @HiveField(6) required this.volume24h,
      @HiveField(7) required this.volumeChange24h,
      @HiveField(8) required this.volume7d,
      @HiveField(9) required this.fee24h,
      @HiveField(10) required this.transactionsCount24h});

  @override
  @HiveField(0)
  final String currency;
  @override
  @HiveField(1)
  final String address;
  @override
  @HiveField(2)
  final String price;
  @override
  @HiveField(3)
  final String priceChange;
  @override
  @HiveField(4)
  final String tvl;
  @override
  @HiveField(5)
  final String tvlChange;
  @override
  @HiveField(6)
  final String volume24h;
  @override
  @HiveField(7)
  final String volumeChange24h;
  @override
  @HiveField(8)
  final String volume7d;
  @override
  @HiveField(9)
  final String fee24h;
  @override
  @HiveField(10)
  final int transactionsCount24h;

  @override
  String toString() {
    return 'CurrencyDto(currency: $currency, address: $address, price: $price, priceChange: $priceChange, tvl: $tvl, tvlChange: $tvlChange, volume24h: $volume24h, volumeChange24h: $volumeChange24h, volume7d: $volume7d, fee24h: $fee24h, transactionsCount24h: $transactionsCount24h)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyDtoImpl &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.priceChange, priceChange) ||
                other.priceChange == priceChange) &&
            (identical(other.tvl, tvl) || other.tvl == tvl) &&
            (identical(other.tvlChange, tvlChange) ||
                other.tvlChange == tvlChange) &&
            (identical(other.volume24h, volume24h) ||
                other.volume24h == volume24h) &&
            (identical(other.volumeChange24h, volumeChange24h) ||
                other.volumeChange24h == volumeChange24h) &&
            (identical(other.volume7d, volume7d) ||
                other.volume7d == volume7d) &&
            (identical(other.fee24h, fee24h) || other.fee24h == fee24h) &&
            (identical(other.transactionsCount24h, transactionsCount24h) ||
                other.transactionsCount24h == transactionsCount24h));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currency,
      address,
      price,
      priceChange,
      tvl,
      tvlChange,
      volume24h,
      volumeChange24h,
      volume7d,
      fee24h,
      transactionsCount24h);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyDtoImplCopyWith<_$CurrencyDtoImpl> get copyWith =>
      __$$CurrencyDtoImplCopyWithImpl<_$CurrencyDtoImpl>(this, _$identity);
}

abstract class _CurrencyDto implements CurrencyDto {
  const factory _CurrencyDto(
          {@HiveField(0) required final String currency,
          @HiveField(1) required final String address,
          @HiveField(2) required final String price,
          @HiveField(3) required final String priceChange,
          @HiveField(4) required final String tvl,
          @HiveField(5) required final String tvlChange,
          @HiveField(6) required final String volume24h,
          @HiveField(7) required final String volumeChange24h,
          @HiveField(8) required final String volume7d,
          @HiveField(9) required final String fee24h,
          @HiveField(10) required final int transactionsCount24h}) =
      _$CurrencyDtoImpl;

  @override
  @HiveField(0)
  String get currency;
  @override
  @HiveField(1)
  String get address;
  @override
  @HiveField(2)
  String get price;
  @override
  @HiveField(3)
  String get priceChange;
  @override
  @HiveField(4)
  String get tvl;
  @override
  @HiveField(5)
  String get tvlChange;
  @override
  @HiveField(6)
  String get volume24h;
  @override
  @HiveField(7)
  String get volumeChange24h;
  @override
  @HiveField(8)
  String get volume7d;
  @override
  @HiveField(9)
  String get fee24h;
  @override
  @HiveField(10)
  int get transactionsCount24h;
  @override
  @JsonKey(ignore: true)
  _$$CurrencyDtoImplCopyWith<_$CurrencyDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
