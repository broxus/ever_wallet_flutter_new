// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_seed_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateSeedPasswordState {
  bool get isLoading => throw _privateConstructorUsedError;
  PasswordStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateSeedPasswordStateCopyWith<CreateSeedPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSeedPasswordStateCopyWith<$Res> {
  factory $CreateSeedPasswordStateCopyWith(CreateSeedPasswordState value,
          $Res Function(CreateSeedPasswordState) then) =
      _$CreateSeedPasswordStateCopyWithImpl<$Res, CreateSeedPasswordState>;
  @useResult
  $Res call({bool isLoading, PasswordStatus status});
}

/// @nodoc
class _$CreateSeedPasswordStateCopyWithImpl<$Res,
        $Val extends CreateSeedPasswordState>
    implements $CreateSeedPasswordStateCopyWith<$Res> {
  _$CreateSeedPasswordStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PasswordStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateSeedPasswordStateImplCopyWith<$Res>
    implements $CreateSeedPasswordStateCopyWith<$Res> {
  factory _$$CreateSeedPasswordStateImplCopyWith(
          _$CreateSeedPasswordStateImpl value,
          $Res Function(_$CreateSeedPasswordStateImpl) then) =
      __$$CreateSeedPasswordStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, PasswordStatus status});
}

/// @nodoc
class __$$CreateSeedPasswordStateImplCopyWithImpl<$Res>
    extends _$CreateSeedPasswordStateCopyWithImpl<$Res,
        _$CreateSeedPasswordStateImpl>
    implements _$$CreateSeedPasswordStateImplCopyWith<$Res> {
  __$$CreateSeedPasswordStateImplCopyWithImpl(
      _$CreateSeedPasswordStateImpl _value,
      $Res Function(_$CreateSeedPasswordStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? status = null,
  }) {
    return _then(_$CreateSeedPasswordStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PasswordStatus,
    ));
  }
}

/// @nodoc

class _$CreateSeedPasswordStateImpl implements _CreateSeedPasswordState {
  const _$CreateSeedPasswordStateImpl(
      {required this.isLoading, required this.status});

  @override
  final bool isLoading;
  @override
  final PasswordStatus status;

  @override
  String toString() {
    return 'CreateSeedPasswordState(isLoading: $isLoading, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSeedPasswordStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, status);

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSeedPasswordStateImplCopyWith<_$CreateSeedPasswordStateImpl>
      get copyWith => __$$CreateSeedPasswordStateImplCopyWithImpl<
          _$CreateSeedPasswordStateImpl>(this, _$identity);
}

abstract class _CreateSeedPasswordState implements CreateSeedPasswordState {
  const factory _CreateSeedPasswordState(
      {required final bool isLoading,
      required final PasswordStatus status}) = _$CreateSeedPasswordStateImpl;

  @override
  bool get isLoading;
  @override
  PasswordStatus get status;

  /// Create a copy of CreateSeedPasswordState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateSeedPasswordStateImplCopyWith<_$CreateSeedPasswordStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
