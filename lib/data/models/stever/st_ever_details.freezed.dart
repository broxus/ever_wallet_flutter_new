// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'st_ever_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StEverDetails _$StEverDetailsFromJson(Map<String, dynamic> json) {
  return _StEverDetails.fromJson(json);
}

/// @nodoc
mixin _$StEverDetails {
  @amountJsonConverter
  BigInt get stEverSupply => throw _privateConstructorUsedError;
  @amountJsonConverter
  BigInt get totalAssets =>
      throw _privateConstructorUsedError; // Time before withdrawing in secodns
  String get withdrawHoldTime => throw _privateConstructorUsedError;

  /// Serializes this StEverDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StEverDetailsCopyWith<StEverDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StEverDetailsCopyWith<$Res> {
  factory $StEverDetailsCopyWith(
          StEverDetails value, $Res Function(StEverDetails) then) =
      _$StEverDetailsCopyWithImpl<$Res, StEverDetails>;
  @useResult
  $Res call(
      {@amountJsonConverter BigInt stEverSupply,
      @amountJsonConverter BigInt totalAssets,
      String withdrawHoldTime});
}

/// @nodoc
class _$StEverDetailsCopyWithImpl<$Res, $Val extends StEverDetails>
    implements $StEverDetailsCopyWith<$Res> {
  _$StEverDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stEverSupply = null,
    Object? totalAssets = null,
    Object? withdrawHoldTime = null,
  }) {
    return _then(_value.copyWith(
      stEverSupply: null == stEverSupply
          ? _value.stEverSupply
          : stEverSupply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      totalAssets: null == totalAssets
          ? _value.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as BigInt,
      withdrawHoldTime: null == withdrawHoldTime
          ? _value.withdrawHoldTime
          : withdrawHoldTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StEverDetailsImplCopyWith<$Res>
    implements $StEverDetailsCopyWith<$Res> {
  factory _$$StEverDetailsImplCopyWith(
          _$StEverDetailsImpl value, $Res Function(_$StEverDetailsImpl) then) =
      __$$StEverDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@amountJsonConverter BigInt stEverSupply,
      @amountJsonConverter BigInt totalAssets,
      String withdrawHoldTime});
}

/// @nodoc
class __$$StEverDetailsImplCopyWithImpl<$Res>
    extends _$StEverDetailsCopyWithImpl<$Res, _$StEverDetailsImpl>
    implements _$$StEverDetailsImplCopyWith<$Res> {
  __$$StEverDetailsImplCopyWithImpl(
      _$StEverDetailsImpl _value, $Res Function(_$StEverDetailsImpl) _then)
      : super(_value, _then);

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stEverSupply = null,
    Object? totalAssets = null,
    Object? withdrawHoldTime = null,
  }) {
    return _then(_$StEverDetailsImpl(
      stEverSupply: null == stEverSupply
          ? _value.stEverSupply
          : stEverSupply // ignore: cast_nullable_to_non_nullable
              as BigInt,
      totalAssets: null == totalAssets
          ? _value.totalAssets
          : totalAssets // ignore: cast_nullable_to_non_nullable
              as BigInt,
      withdrawHoldTime: null == withdrawHoldTime
          ? _value.withdrawHoldTime
          : withdrawHoldTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StEverDetailsImpl implements _StEverDetails {
  const _$StEverDetailsImpl(
      {@amountJsonConverter required this.stEverSupply,
      @amountJsonConverter required this.totalAssets,
      required this.withdrawHoldTime});

  factory _$StEverDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$StEverDetailsImplFromJson(json);

  @override
  @amountJsonConverter
  final BigInt stEverSupply;
  @override
  @amountJsonConverter
  final BigInt totalAssets;
// Time before withdrawing in secodns
  @override
  final String withdrawHoldTime;

  @override
  String toString() {
    return 'StEverDetails(stEverSupply: $stEverSupply, totalAssets: $totalAssets, withdrawHoldTime: $withdrawHoldTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StEverDetailsImpl &&
            (identical(other.stEverSupply, stEverSupply) ||
                other.stEverSupply == stEverSupply) &&
            (identical(other.totalAssets, totalAssets) ||
                other.totalAssets == totalAssets) &&
            (identical(other.withdrawHoldTime, withdrawHoldTime) ||
                other.withdrawHoldTime == withdrawHoldTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, stEverSupply, totalAssets, withdrawHoldTime);

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StEverDetailsImplCopyWith<_$StEverDetailsImpl> get copyWith =>
      __$$StEverDetailsImplCopyWithImpl<_$StEverDetailsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StEverDetailsImplToJson(
      this,
    );
  }
}

abstract class _StEverDetails implements StEverDetails {
  const factory _StEverDetails(
      {@amountJsonConverter required final BigInt stEverSupply,
      @amountJsonConverter required final BigInt totalAssets,
      required final String withdrawHoldTime}) = _$StEverDetailsImpl;

  factory _StEverDetails.fromJson(Map<String, dynamic> json) =
      _$StEverDetailsImpl.fromJson;

  @override
  @amountJsonConverter
  BigInt get stEverSupply;
  @override
  @amountJsonConverter
  BigInt get totalAssets; // Time before withdrawing in secodns
  @override
  String get withdrawHoldTime;

  /// Create a copy of StEverDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StEverDetailsImplCopyWith<_$StEverDetailsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
