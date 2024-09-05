// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unsigned_message_with_additional_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$UnsignedMessageWithAdditionalInfo {
  UnsignedMessage get message => throw _privateConstructorUsedError;
  String? get dst => throw _privateConstructorUsedError;
  @amountJsonConverter
  BigInt? get amount => throw _privateConstructorUsedError;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UnsignedMessageWithAdditionalInfoCopyWith<UnsignedMessageWithAdditionalInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory $UnsignedMessageWithAdditionalInfoCopyWith(
          UnsignedMessageWithAdditionalInfo value,
          $Res Function(UnsignedMessageWithAdditionalInfo) then) =
      _$UnsignedMessageWithAdditionalInfoCopyWithImpl<$Res,
          UnsignedMessageWithAdditionalInfo>;
  @useResult
  $Res call(
      {UnsignedMessage message,
      String? dst,
      @amountJsonConverter BigInt? amount});
}

/// @nodoc
class _$UnsignedMessageWithAdditionalInfoCopyWithImpl<$Res,
        $Val extends UnsignedMessageWithAdditionalInfo>
    implements $UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  _$UnsignedMessageWithAdditionalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? dst = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as UnsignedMessage,
      dst: freezed == dst
          ? _value.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnsignedMessageWithAdditionalInfoImplCopyWith<$Res>
    implements $UnsignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory _$$UnsignedMessageWithAdditionalInfoImplCopyWith(
          _$UnsignedMessageWithAdditionalInfoImpl value,
          $Res Function(_$UnsignedMessageWithAdditionalInfoImpl) then) =
      __$$UnsignedMessageWithAdditionalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UnsignedMessage message,
      String? dst,
      @amountJsonConverter BigInt? amount});
}

/// @nodoc
class __$$UnsignedMessageWithAdditionalInfoImplCopyWithImpl<$Res>
    extends _$UnsignedMessageWithAdditionalInfoCopyWithImpl<$Res,
        _$UnsignedMessageWithAdditionalInfoImpl>
    implements _$$UnsignedMessageWithAdditionalInfoImplCopyWith<$Res> {
  __$$UnsignedMessageWithAdditionalInfoImplCopyWithImpl(
      _$UnsignedMessageWithAdditionalInfoImpl _value,
      $Res Function(_$UnsignedMessageWithAdditionalInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? dst = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$UnsignedMessageWithAdditionalInfoImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as UnsignedMessage,
      dst: freezed == dst
          ? _value.dst
          : dst // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ));
  }
}

/// @nodoc

class _$UnsignedMessageWithAdditionalInfoImpl
    implements _UnsignedMessageWithAdditionalInfo {
  const _$UnsignedMessageWithAdditionalInfoImpl(
      {required this.message, this.dst, @amountJsonConverter this.amount});

  @override
  final UnsignedMessage message;
  @override
  final String? dst;
  @override
  @amountJsonConverter
  final BigInt? amount;

  @override
  String toString() {
    return 'UnsignedMessageWithAdditionalInfo(message: $message, dst: $dst, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnsignedMessageWithAdditionalInfoImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dst, dst) || other.dst == dst) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, dst, amount);

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnsignedMessageWithAdditionalInfoImplCopyWith<
          _$UnsignedMessageWithAdditionalInfoImpl>
      get copyWith => __$$UnsignedMessageWithAdditionalInfoImplCopyWithImpl<
          _$UnsignedMessageWithAdditionalInfoImpl>(this, _$identity);
}

abstract class _UnsignedMessageWithAdditionalInfo
    implements UnsignedMessageWithAdditionalInfo {
  const factory _UnsignedMessageWithAdditionalInfo(
          {required final UnsignedMessage message,
          final String? dst,
          @amountJsonConverter final BigInt? amount}) =
      _$UnsignedMessageWithAdditionalInfoImpl;

  @override
  UnsignedMessage get message;
  @override
  String? get dst;
  @override
  @amountJsonConverter
  BigInt? get amount;

  /// Create a copy of UnsignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnsignedMessageWithAdditionalInfoImplCopyWith<
          _$UnsignedMessageWithAdditionalInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
