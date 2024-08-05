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
  bool get obscurePassword => throw _privateConstructorUsedError;
  bool get obscureConfirm => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CreateSeedPasswordStateCopyWith<CreateSeedPasswordState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSeedPasswordStateCopyWith<$Res> {
  factory $CreateSeedPasswordStateCopyWith(CreateSeedPasswordState value,
          $Res Function(CreateSeedPasswordState) then) =
      _$CreateSeedPasswordStateCopyWithImpl<$Res, CreateSeedPasswordState>;
  @useResult
  $Res call({bool obscurePassword, bool obscureConfirm, bool isLoading});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obscurePassword = null,
    Object? obscureConfirm = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      obscurePassword: null == obscurePassword
          ? _value.obscurePassword
          : obscurePassword // ignore: cast_nullable_to_non_nullable
              as bool,
      obscureConfirm: null == obscureConfirm
          ? _value.obscureConfirm
          : obscureConfirm // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
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
  $Res call({bool obscurePassword, bool obscureConfirm, bool isLoading});
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

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? obscurePassword = null,
    Object? obscureConfirm = null,
    Object? isLoading = null,
  }) {
    return _then(_$CreateSeedPasswordStateImpl(
      obscurePassword: null == obscurePassword
          ? _value.obscurePassword
          : obscurePassword // ignore: cast_nullable_to_non_nullable
              as bool,
      obscureConfirm: null == obscureConfirm
          ? _value.obscureConfirm
          : obscureConfirm // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@Deprecated('Use v2 version')
class _$CreateSeedPasswordStateImpl implements _CreateSeedPasswordState {
  const _$CreateSeedPasswordStateImpl(
      {required this.obscurePassword,
      required this.obscureConfirm,
      required this.isLoading});

  @override
  final bool obscurePassword;
  @override
  final bool obscureConfirm;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'CreateSeedPasswordState(obscurePassword: $obscurePassword, obscureConfirm: $obscureConfirm, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateSeedPasswordStateImpl &&
            (identical(other.obscurePassword, obscurePassword) ||
                other.obscurePassword == obscurePassword) &&
            (identical(other.obscureConfirm, obscureConfirm) ||
                other.obscureConfirm == obscureConfirm) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, obscurePassword, obscureConfirm, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateSeedPasswordStateImplCopyWith<_$CreateSeedPasswordStateImpl>
      get copyWith => __$$CreateSeedPasswordStateImplCopyWithImpl<
          _$CreateSeedPasswordStateImpl>(this, _$identity);
}

abstract class _CreateSeedPasswordState implements CreateSeedPasswordState {
  const factory _CreateSeedPasswordState(
      {required final bool obscurePassword,
      required final bool obscureConfirm,
      required final bool isLoading}) = _$CreateSeedPasswordStateImpl;

  @override
  bool get obscurePassword;
  @override
  bool get obscureConfirm;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$CreateSeedPasswordStateImplCopyWith<_$CreateSeedPasswordStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
