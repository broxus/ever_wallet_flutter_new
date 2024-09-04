// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_message_with_additional_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SignedMessageWithAdditionalInfo {
  SignedMessage get message => throw _privateConstructorUsedError;
  String? get dst => throw _privateConstructorUsedError;
  @amountJsonConverter
  BigInt? get amount => throw _privateConstructorUsedError;

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignedMessageWithAdditionalInfoCopyWith<SignedMessageWithAdditionalInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory $SignedMessageWithAdditionalInfoCopyWith(
          SignedMessageWithAdditionalInfo value,
          $Res Function(SignedMessageWithAdditionalInfo) then) =
      _$SignedMessageWithAdditionalInfoCopyWithImpl<$Res,
          SignedMessageWithAdditionalInfo>;
  @useResult
  $Res call(
      {SignedMessage message,
      String? dst,
      @amountJsonConverter BigInt? amount});

  $SignedMessageCopyWith<$Res> get message;
}

/// @nodoc
class _$SignedMessageWithAdditionalInfoCopyWithImpl<$Res,
        $Val extends SignedMessageWithAdditionalInfo>
    implements $SignedMessageWithAdditionalInfoCopyWith<$Res> {
  _$SignedMessageWithAdditionalInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignedMessageWithAdditionalInfo
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
              as SignedMessage,
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

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SignedMessageCopyWith<$Res> get message {
    return $SignedMessageCopyWith<$Res>(_value.message, (value) {
      return _then(_value.copyWith(message: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignedMessageWithAdditionalInfoImplCopyWith<$Res>
    implements $SignedMessageWithAdditionalInfoCopyWith<$Res> {
  factory _$$SignedMessageWithAdditionalInfoImplCopyWith(
          _$SignedMessageWithAdditionalInfoImpl value,
          $Res Function(_$SignedMessageWithAdditionalInfoImpl) then) =
      __$$SignedMessageWithAdditionalInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SignedMessage message,
      String? dst,
      @amountJsonConverter BigInt? amount});

  @override
  $SignedMessageCopyWith<$Res> get message;
}

/// @nodoc
class __$$SignedMessageWithAdditionalInfoImplCopyWithImpl<$Res>
    extends _$SignedMessageWithAdditionalInfoCopyWithImpl<$Res,
        _$SignedMessageWithAdditionalInfoImpl>
    implements _$$SignedMessageWithAdditionalInfoImplCopyWith<$Res> {
  __$$SignedMessageWithAdditionalInfoImplCopyWithImpl(
      _$SignedMessageWithAdditionalInfoImpl _value,
      $Res Function(_$SignedMessageWithAdditionalInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? dst = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$SignedMessageWithAdditionalInfoImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as SignedMessage,
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

class _$SignedMessageWithAdditionalInfoImpl
    implements _SignedMessageWithAdditionalInfo {
  const _$SignedMessageWithAdditionalInfoImpl(
      {required this.message, this.dst, @amountJsonConverter this.amount});

  @override
  final SignedMessage message;
  @override
  final String? dst;
  @override
  @amountJsonConverter
  final BigInt? amount;

  @override
  String toString() {
    return 'SignedMessageWithAdditionalInfo(message: $message, dst: $dst, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedMessageWithAdditionalInfoImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dst, dst) || other.dst == dst) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, dst, amount);

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedMessageWithAdditionalInfoImplCopyWith<
          _$SignedMessageWithAdditionalInfoImpl>
      get copyWith => __$$SignedMessageWithAdditionalInfoImplCopyWithImpl<
          _$SignedMessageWithAdditionalInfoImpl>(this, _$identity);
}

abstract class _SignedMessageWithAdditionalInfo
    implements SignedMessageWithAdditionalInfo {
  const factory _SignedMessageWithAdditionalInfo(
          {required final SignedMessage message,
          final String? dst,
          @amountJsonConverter final BigInt? amount}) =
      _$SignedMessageWithAdditionalInfoImpl;

  @override
  SignedMessage get message;
  @override
  String? get dst;
  @override
  @amountJsonConverter
  BigInt? get amount;

  /// Create a copy of SignedMessageWithAdditionalInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignedMessageWithAdditionalInfoImplCopyWith<
          _$SignedMessageWithAdditionalInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
