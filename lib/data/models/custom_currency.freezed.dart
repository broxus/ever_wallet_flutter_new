// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_currency.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomCurrency _$CustomCurrencyFromJson(Map<String, dynamic> json) {
  return _CustomCurrency.fromJson(json);
}

/// @nodoc
mixin _$CustomCurrency {
  String get currency => throw _privateConstructorUsedError;
  Address get address => throw _privateConstructorUsedError; // Price in USD
// TODO(nesquikm): refactor to use Currency and Money
  String get price => throw _privateConstructorUsedError;
  String get priceChange => throw _privateConstructorUsedError;
  String get tvl => throw _privateConstructorUsedError;
  String get tvlChange => throw _privateConstructorUsedError;
  String get volume24h => throw _privateConstructorUsedError;
  String get volumeChange24h => throw _privateConstructorUsedError;
  String get volume7d => throw _privateConstructorUsedError;
  String get fee24h => throw _privateConstructorUsedError;
  int get transactionsCount24h => throw _privateConstructorUsedError;
  NetworkType get networkType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomCurrencyCopyWith<CustomCurrency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomCurrencyCopyWith<$Res> {
  factory $CustomCurrencyCopyWith(
          CustomCurrency value, $Res Function(CustomCurrency) then) =
      _$CustomCurrencyCopyWithImpl<$Res, CustomCurrency>;
  @useResult
  $Res call(
      {String currency,
      Address address,
      String price,
      String priceChange,
      String tvl,
      String tvlChange,
      String volume24h,
      String volumeChange24h,
      String volume7d,
      String fee24h,
      int transactionsCount24h,
      NetworkType networkType});

  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class _$CustomCurrencyCopyWithImpl<$Res, $Val extends CustomCurrency>
    implements $CustomCurrencyCopyWith<$Res> {
  _$CustomCurrencyCopyWithImpl(this._value, this._then);

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
    Object? networkType = null,
  }) {
    return _then(_value.copyWith(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
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
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get address {
    return $AddressCopyWith<$Res>(_value.address, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomCurrencyImplCopyWith<$Res>
    implements $CustomCurrencyCopyWith<$Res> {
  factory _$$CustomCurrencyImplCopyWith(_$CustomCurrencyImpl value,
          $Res Function(_$CustomCurrencyImpl) then) =
      __$$CustomCurrencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currency,
      Address address,
      String price,
      String priceChange,
      String tvl,
      String tvlChange,
      String volume24h,
      String volumeChange24h,
      String volume7d,
      String fee24h,
      int transactionsCount24h,
      NetworkType networkType});

  @override
  $AddressCopyWith<$Res> get address;
}

/// @nodoc
class __$$CustomCurrencyImplCopyWithImpl<$Res>
    extends _$CustomCurrencyCopyWithImpl<$Res, _$CustomCurrencyImpl>
    implements _$$CustomCurrencyImplCopyWith<$Res> {
  __$$CustomCurrencyImplCopyWithImpl(
      _$CustomCurrencyImpl _value, $Res Function(_$CustomCurrencyImpl) _then)
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
    Object? networkType = null,
  }) {
    return _then(_$CustomCurrencyImpl(
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address,
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
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as NetworkType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomCurrencyImpl implements _CustomCurrency {
  const _$CustomCurrencyImpl(
      {required this.currency,
      required this.address,
      required this.price,
      required this.priceChange,
      required this.tvl,
      required this.tvlChange,
      required this.volume24h,
      required this.volumeChange24h,
      required this.volume7d,
      required this.fee24h,
      required this.transactionsCount24h,
      required this.networkType});

  factory _$CustomCurrencyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomCurrencyImplFromJson(json);

  @override
  final String currency;
  @override
  final Address address;
// Price in USD
// TODO(nesquikm): refactor to use Currency and Money
  @override
  final String price;
  @override
  final String priceChange;
  @override
  final String tvl;
  @override
  final String tvlChange;
  @override
  final String volume24h;
  @override
  final String volumeChange24h;
  @override
  final String volume7d;
  @override
  final String fee24h;
  @override
  final int transactionsCount24h;
  @override
  final NetworkType networkType;

  @override
  String toString() {
    return 'CustomCurrency(currency: $currency, address: $address, price: $price, priceChange: $priceChange, tvl: $tvl, tvlChange: $tvlChange, volume24h: $volume24h, volumeChange24h: $volumeChange24h, volume7d: $volume7d, fee24h: $fee24h, transactionsCount24h: $transactionsCount24h, networkType: $networkType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomCurrencyImpl &&
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
                other.transactionsCount24h == transactionsCount24h) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType));
  }

  @JsonKey(ignore: true)
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
      transactionsCount24h,
      networkType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomCurrencyImplCopyWith<_$CustomCurrencyImpl> get copyWith =>
      __$$CustomCurrencyImplCopyWithImpl<_$CustomCurrencyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomCurrencyImplToJson(
      this,
    );
  }
}

abstract class _CustomCurrency implements CustomCurrency {
  const factory _CustomCurrency(
      {required final String currency,
      required final Address address,
      required final String price,
      required final String priceChange,
      required final String tvl,
      required final String tvlChange,
      required final String volume24h,
      required final String volumeChange24h,
      required final String volume7d,
      required final String fee24h,
      required final int transactionsCount24h,
      required final NetworkType networkType}) = _$CustomCurrencyImpl;

  factory _CustomCurrency.fromJson(Map<String, dynamic> json) =
      _$CustomCurrencyImpl.fromJson;

  @override
  String get currency;
  @override
  Address get address;
  @override // Price in USD
// TODO(nesquikm): refactor to use Currency and Money
  String get price;
  @override
  String get priceChange;
  @override
  String get tvl;
  @override
  String get tvlChange;
  @override
  String get volume24h;
  @override
  String get volumeChange24h;
  @override
  String get volume7d;
  @override
  String get fee24h;
  @override
  int get transactionsCount24h;
  @override
  NetworkType get networkType;
  @override
  @JsonKey(ignore: true)
  _$$CustomCurrencyImplCopyWith<_$CustomCurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
