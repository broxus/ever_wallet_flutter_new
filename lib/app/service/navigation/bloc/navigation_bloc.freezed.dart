// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NavigationEvent {
  NavigationServiceState get state => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(NavigationServiceState state) navigatedTo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(NavigationServiceState state)? navigatedTo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(NavigationServiceState state)? navigatedTo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NavigatedTo value) navigatedTo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NavigatedTo value)? navigatedTo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigatedTo value)? navigatedTo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of NavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavigationEventCopyWith<NavigationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationEventCopyWith<$Res> {
  factory $NavigationEventCopyWith(
          NavigationEvent value, $Res Function(NavigationEvent) then) =
      _$NavigationEventCopyWithImpl<$Res, NavigationEvent>;
  @useResult
  $Res call({NavigationServiceState state});

  $NavigationServiceStateCopyWith<$Res> get state;
}

/// @nodoc
class _$NavigationEventCopyWithImpl<$Res, $Val extends NavigationEvent>
    implements $NavigationEventCopyWith<$Res> {
  _$NavigationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as NavigationServiceState,
    ) as $Val);
  }

  /// Create a copy of NavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NavigationServiceStateCopyWith<$Res> get state {
    return $NavigationServiceStateCopyWith<$Res>(_value.state, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NavigatedToImplCopyWith<$Res>
    implements $NavigationEventCopyWith<$Res> {
  factory _$$NavigatedToImplCopyWith(
          _$NavigatedToImpl value, $Res Function(_$NavigatedToImpl) then) =
      __$$NavigatedToImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NavigationServiceState state});

  @override
  $NavigationServiceStateCopyWith<$Res> get state;
}

/// @nodoc
class __$$NavigatedToImplCopyWithImpl<$Res>
    extends _$NavigationEventCopyWithImpl<$Res, _$NavigatedToImpl>
    implements _$$NavigatedToImplCopyWith<$Res> {
  __$$NavigatedToImplCopyWithImpl(
      _$NavigatedToImpl _value, $Res Function(_$NavigatedToImpl) _then)
      : super(_value, _then);

  /// Create a copy of NavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
  }) {
    return _then(_$NavigatedToImpl(
      null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as NavigationServiceState,
    ));
  }
}

/// @nodoc

class _$NavigatedToImpl implements _NavigatedTo {
  const _$NavigatedToImpl(this.state);

  @override
  final NavigationServiceState state;

  @override
  String toString() {
    return 'NavigationEvent.navigatedTo(state: $state)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigatedToImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);

  /// Create a copy of NavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigatedToImplCopyWith<_$NavigatedToImpl> get copyWith =>
      __$$NavigatedToImplCopyWithImpl<_$NavigatedToImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(NavigationServiceState state) navigatedTo,
  }) {
    return navigatedTo(state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(NavigationServiceState state)? navigatedTo,
  }) {
    return navigatedTo?.call(state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(NavigationServiceState state)? navigatedTo,
    required TResult orElse(),
  }) {
    if (navigatedTo != null) {
      return navigatedTo(state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_NavigatedTo value) navigatedTo,
  }) {
    return navigatedTo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_NavigatedTo value)? navigatedTo,
  }) {
    return navigatedTo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_NavigatedTo value)? navigatedTo,
    required TResult orElse(),
  }) {
    if (navigatedTo != null) {
      return navigatedTo(this);
    }
    return orElse();
  }
}

abstract class _NavigatedTo implements NavigationEvent {
  const factory _NavigatedTo(final NavigationServiceState state) =
      _$NavigatedToImpl;

  @override
  NavigationServiceState get state;

  /// Create a copy of NavigationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigatedToImplCopyWith<_$NavigatedToImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NavigationState {
  NavigationServiceState? get state => throw _privateConstructorUsedError;
  NavigationServiceState? get oldState => throw _privateConstructorUsedError;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavigationStateCopyWith<NavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStateCopyWith<$Res> {
  factory $NavigationStateCopyWith(
          NavigationState value, $Res Function(NavigationState) then) =
      _$NavigationStateCopyWithImpl<$Res, NavigationState>;
  @useResult
  $Res call({NavigationServiceState? state, NavigationServiceState? oldState});

  $NavigationServiceStateCopyWith<$Res>? get state;
  $NavigationServiceStateCopyWith<$Res>? get oldState;
}

/// @nodoc
class _$NavigationStateCopyWithImpl<$Res, $Val extends NavigationState>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
    Object? oldState = freezed,
  }) {
    return _then(_value.copyWith(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as NavigationServiceState?,
      oldState: freezed == oldState
          ? _value.oldState
          : oldState // ignore: cast_nullable_to_non_nullable
              as NavigationServiceState?,
    ) as $Val);
  }

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NavigationServiceStateCopyWith<$Res>? get state {
    if (_value.state == null) {
      return null;
    }

    return $NavigationServiceStateCopyWith<$Res>(_value.state!, (value) {
      return _then(_value.copyWith(state: value) as $Val);
    });
  }

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NavigationServiceStateCopyWith<$Res>? get oldState {
    if (_value.oldState == null) {
      return null;
    }

    return $NavigationServiceStateCopyWith<$Res>(_value.oldState!, (value) {
      return _then(_value.copyWith(oldState: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NavigationStateImplCopyWith<$Res>
    implements $NavigationStateCopyWith<$Res> {
  factory _$$NavigationStateImplCopyWith(_$NavigationStateImpl value,
          $Res Function(_$NavigationStateImpl) then) =
      __$$NavigationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({NavigationServiceState? state, NavigationServiceState? oldState});

  @override
  $NavigationServiceStateCopyWith<$Res>? get state;
  @override
  $NavigationServiceStateCopyWith<$Res>? get oldState;
}

/// @nodoc
class __$$NavigationStateImplCopyWithImpl<$Res>
    extends _$NavigationStateCopyWithImpl<$Res, _$NavigationStateImpl>
    implements _$$NavigationStateImplCopyWith<$Res> {
  __$$NavigationStateImplCopyWithImpl(
      _$NavigationStateImpl _value, $Res Function(_$NavigationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = freezed,
    Object? oldState = freezed,
  }) {
    return _then(_$NavigationStateImpl(
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as NavigationServiceState?,
      oldState: freezed == oldState
          ? _value.oldState
          : oldState // ignore: cast_nullable_to_non_nullable
              as NavigationServiceState?,
    ));
  }
}

/// @nodoc

class _$NavigationStateImpl implements _NavigationState {
  const _$NavigationStateImpl({this.state, this.oldState});

  @override
  final NavigationServiceState? state;
  @override
  final NavigationServiceState? oldState;

  @override
  String toString() {
    return 'NavigationState(state: $state, oldState: $oldState)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigationStateImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.oldState, oldState) ||
                other.oldState == oldState));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state, oldState);

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigationStateImplCopyWith<_$NavigationStateImpl> get copyWith =>
      __$$NavigationStateImplCopyWithImpl<_$NavigationStateImpl>(
          this, _$identity);
}

abstract class _NavigationState implements NavigationState {
  const factory _NavigationState(
      {final NavigationServiceState? state,
      final NavigationServiceState? oldState}) = _$NavigationStateImpl;

  @override
  NavigationServiceState? get state;
  @override
  NavigationServiceState? get oldState;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigationStateImplCopyWith<_$NavigationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
