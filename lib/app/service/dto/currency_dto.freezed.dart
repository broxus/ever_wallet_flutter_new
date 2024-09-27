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

  /// Create a copy of CurrencyDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      @HiveField(2) String price});
}

/// @nodoc
class _$CurrencyDtoCopyWithImpl<$Res, $Val extends CurrencyDto>
    implements $CurrencyDtoCopyWith<$Res> {
  _$CurrencyDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CurrencyDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? address = null,
    Object? price = null,
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
      @HiveField(2) String price});
}

/// @nodoc
class __$$CurrencyDtoImplCopyWithImpl<$Res>
    extends _$CurrencyDtoCopyWithImpl<$Res, _$CurrencyDtoImpl>
    implements _$$CurrencyDtoImplCopyWith<$Res> {
  __$$CurrencyDtoImplCopyWithImpl(
      _$CurrencyDtoImpl _value, $Res Function(_$CurrencyDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CurrencyDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currency = null,
    Object? address = null,
    Object? price = null,
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
    ));
  }
}

/// @nodoc

@HiveType(typeId: 4)
class _$CurrencyDtoImpl implements _CurrencyDto {
  const _$CurrencyDtoImpl(
      {@HiveField(0) required this.currency,
      @HiveField(1) required this.address,
      @HiveField(2) required this.price});

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
  String toString() {
    return 'CurrencyDto(currency: $currency, address: $address, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyDtoImpl &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currency, address, price);

  /// Create a copy of CurrencyDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyDtoImplCopyWith<_$CurrencyDtoImpl> get copyWith =>
      __$$CurrencyDtoImplCopyWithImpl<_$CurrencyDtoImpl>(this, _$identity);
}

abstract class _CurrencyDto implements CurrencyDto {
  const factory _CurrencyDto(
      {@HiveField(0) required final String currency,
      @HiveField(1) required final String address,
      @HiveField(2) required final String price}) = _$CurrencyDtoImpl;

  @override
  @HiveField(0)
  String get currency;
  @override
  @HiveField(1)
  String get address;
  @override
  @HiveField(2)
  String get price;

  /// Create a copy of CurrencyDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CurrencyDtoImplCopyWith<_$CurrencyDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
