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
  Address get address => throw _privateConstructorUsedError;

  /// Price in USD
  String get price => throw _privateConstructorUsedError;
  String get networkType => throw _privateConstructorUsedError;
  String get networkGroup => throw _privateConstructorUsedError;

  /// Serializes this CustomCurrency to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      String networkType,
      String networkGroup});

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

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? address = null,
    Object? price = null,
    Object? networkType = null,
    Object? networkGroup = null,
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
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
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
      String networkType,
      String networkGroup});

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

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? address = null,
    Object? price = null,
    Object? networkType = null,
    Object? networkGroup = null,
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
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      networkGroup: null == networkGroup
          ? _value.networkGroup
          : networkGroup // ignore: cast_nullable_to_non_nullable
              as String,
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
      required this.networkType,
      required this.networkGroup});

  factory _$CustomCurrencyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomCurrencyImplFromJson(json);

  @override
  final String currency;
  @override
  final Address address;

  /// Price in USD
  @override
  final String price;
  @override
  final String networkType;
  @override
  final String networkGroup;

  @override
  String toString() {
    return 'CustomCurrency(currency: $currency, address: $address, price: $price, networkType: $networkType, networkGroup: $networkGroup)';
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
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.networkGroup, networkGroup) ||
                other.networkGroup == networkGroup));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, currency, address, price, networkType, networkGroup);

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      required final String networkType,
      required final String networkGroup}) = _$CustomCurrencyImpl;

  factory _CustomCurrency.fromJson(Map<String, dynamic> json) =
      _$CustomCurrencyImpl.fromJson;

  @override
  String get currency;
  @override
  Address get address;

  /// Price in USD
  @override
  String get price;
  @override
  String get networkType;
  @override
  String get networkGroup;

  /// Create a copy of CustomCurrency
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomCurrencyImplCopyWith<_$CustomCurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
