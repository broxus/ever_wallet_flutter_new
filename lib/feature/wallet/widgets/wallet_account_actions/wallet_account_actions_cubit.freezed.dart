// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_account_actions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletAccountActionsState {
  bool get hasStake => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasStake) loading,
    required TResult Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)
        data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasStake)? loading,
    TResult? Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)?
        data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasStake)? loading,
    TResult Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)?
        data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Data value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WalletAccountActionsStateCopyWith<WalletAccountActionsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletAccountActionsStateCopyWith<$Res> {
  factory $WalletAccountActionsStateCopyWith(WalletAccountActionsState value,
          $Res Function(WalletAccountActionsState) then) =
      _$WalletAccountActionsStateCopyWithImpl<$Res, WalletAccountActionsState>;
  @useResult
  $Res call({bool hasStake});
}

/// @nodoc
class _$WalletAccountActionsStateCopyWithImpl<$Res,
        $Val extends WalletAccountActionsState>
    implements $WalletAccountActionsStateCopyWith<$Res> {
  _$WalletAccountActionsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasStake = null,
  }) {
    return _then(_value.copyWith(
      hasStake: null == hasStake
          ? _value.hasStake
          : hasStake // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res>
    implements $WalletAccountActionsStateCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool hasStake});
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$WalletAccountActionsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hasStake = null,
  }) {
    return _then(_$LoadingImpl(
      hasStake: null == hasStake
          ? _value.hasStake
          : hasStake // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({required this.hasStake});

  @override
  final bool hasStake;

  @override
  String toString() {
    return 'WalletAccountActionsState.loading(hasStake: $hasStake)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.hasStake, hasStake) ||
                other.hasStake == hasStake));
  }

  @override
  int get hashCode => Object.hash(runtimeType, hasStake);

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasStake) loading,
    required TResult Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)
        data,
  }) {
    return loading(hasStake);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasStake)? loading,
    TResult? Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)?
        data,
  }) {
    return loading?.call(hasStake);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasStake)? loading,
    TResult Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)?
        data,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(hasStake);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Data value)? data,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements WalletAccountActionsState {
  const factory _Loading({required final bool hasStake}) = _$LoadingImpl;

  @override
  bool get hasStake;

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res>
    implements $WalletAccountActionsStateCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {WalletAccountActionBehavior action,
      bool hasStake,
      bool hasStakeActions});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$WalletAccountActionsStateCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? action = null,
    Object? hasStake = null,
    Object? hasStakeActions = null,
  }) {
    return _then(_$DataImpl(
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as WalletAccountActionBehavior,
      hasStake: null == hasStake
          ? _value.hasStake
          : hasStake // ignore: cast_nullable_to_non_nullable
              as bool,
      hasStakeActions: null == hasStakeActions
          ? _value.hasStakeActions
          : hasStakeActions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DataImpl implements _Data {
  const _$DataImpl(
      {required this.action,
      required this.hasStake,
      required this.hasStakeActions});

  @override
  final WalletAccountActionBehavior action;
  @override
  final bool hasStake;
  @override
  final bool hasStakeActions;

  @override
  String toString() {
    return 'WalletAccountActionsState.data(action: $action, hasStake: $hasStake, hasStakeActions: $hasStakeActions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.hasStake, hasStake) ||
                other.hasStake == hasStake) &&
            (identical(other.hasStakeActions, hasStakeActions) ||
                other.hasStakeActions == hasStakeActions));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, action, hasStake, hasStakeActions);

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool hasStake) loading,
    required TResult Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)
        data,
  }) {
    return data(action, hasStake, hasStakeActions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool hasStake)? loading,
    TResult? Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)?
        data,
  }) {
    return data?.call(action, hasStake, hasStakeActions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool hasStake)? loading,
    TResult Function(WalletAccountActionBehavior action, bool hasStake,
            bool hasStakeActions)?
        data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(action, hasStake, hasStakeActions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Data value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Data value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data implements WalletAccountActionsState {
  const factory _Data(
      {required final WalletAccountActionBehavior action,
      required final bool hasStake,
      required final bool hasStakeActions}) = _$DataImpl;

  WalletAccountActionBehavior get action;
  @override
  bool get hasStake;
  bool get hasStakeActions;

  /// Create a copy of WalletAccountActionsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
