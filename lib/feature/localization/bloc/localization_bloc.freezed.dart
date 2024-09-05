// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'localization_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocalizationEvent {
  SupportedLocaleCodes get code => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SupportedLocaleCodes code)
        setLocaleCodeFromService,
    required TResult Function(SupportedLocaleCodes code) changeLocaleCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult? Function(SupportedLocaleCodes code)? changeLocaleCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult Function(SupportedLocaleCodes code)? changeLocaleCode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetLocaleCodeFromService value)
        setLocaleCodeFromService,
    required TResult Function(_ChangeLocaleCode value) changeLocaleCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetLocaleCodeFromService value)?
        setLocaleCodeFromService,
    TResult? Function(_ChangeLocaleCode value)? changeLocaleCode,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetLocaleCodeFromService value)? setLocaleCodeFromService,
    TResult Function(_ChangeLocaleCode value)? changeLocaleCode,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalizationEventCopyWith<LocalizationEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationEventCopyWith<$Res> {
  factory $LocalizationEventCopyWith(
          LocalizationEvent value, $Res Function(LocalizationEvent) then) =
      _$LocalizationEventCopyWithImpl<$Res, LocalizationEvent>;
  @useResult
  $Res call({SupportedLocaleCodes code});
}

/// @nodoc
class _$LocalizationEventCopyWithImpl<$Res, $Val extends LocalizationEvent>
    implements $LocalizationEventCopyWith<$Res> {
  _$LocalizationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SetLocaleCodeFromServiceImplCopyWith<$Res>
    implements $LocalizationEventCopyWith<$Res> {
  factory _$$SetLocaleCodeFromServiceImplCopyWith(
          _$SetLocaleCodeFromServiceImpl value,
          $Res Function(_$SetLocaleCodeFromServiceImpl) then) =
      __$$SetLocaleCodeFromServiceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SupportedLocaleCodes code});
}

/// @nodoc
class __$$SetLocaleCodeFromServiceImplCopyWithImpl<$Res>
    extends _$LocalizationEventCopyWithImpl<$Res,
        _$SetLocaleCodeFromServiceImpl>
    implements _$$SetLocaleCodeFromServiceImplCopyWith<$Res> {
  __$$SetLocaleCodeFromServiceImplCopyWithImpl(
      _$SetLocaleCodeFromServiceImpl _value,
      $Res Function(_$SetLocaleCodeFromServiceImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$SetLocaleCodeFromServiceImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// @nodoc

class _$SetLocaleCodeFromServiceImpl implements _SetLocaleCodeFromService {
  const _$SetLocaleCodeFromServiceImpl({required this.code});

  @override
  final SupportedLocaleCodes code;

  @override
  String toString() {
    return 'LocalizationEvent.setLocaleCodeFromService(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetLocaleCodeFromServiceImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetLocaleCodeFromServiceImplCopyWith<_$SetLocaleCodeFromServiceImpl>
      get copyWith => __$$SetLocaleCodeFromServiceImplCopyWithImpl<
          _$SetLocaleCodeFromServiceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SupportedLocaleCodes code)
        setLocaleCodeFromService,
    required TResult Function(SupportedLocaleCodes code) changeLocaleCode,
  }) {
    return setLocaleCodeFromService(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult? Function(SupportedLocaleCodes code)? changeLocaleCode,
  }) {
    return setLocaleCodeFromService?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult Function(SupportedLocaleCodes code)? changeLocaleCode,
    required TResult orElse(),
  }) {
    if (setLocaleCodeFromService != null) {
      return setLocaleCodeFromService(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetLocaleCodeFromService value)
        setLocaleCodeFromService,
    required TResult Function(_ChangeLocaleCode value) changeLocaleCode,
  }) {
    return setLocaleCodeFromService(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetLocaleCodeFromService value)?
        setLocaleCodeFromService,
    TResult? Function(_ChangeLocaleCode value)? changeLocaleCode,
  }) {
    return setLocaleCodeFromService?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetLocaleCodeFromService value)? setLocaleCodeFromService,
    TResult Function(_ChangeLocaleCode value)? changeLocaleCode,
    required TResult orElse(),
  }) {
    if (setLocaleCodeFromService != null) {
      return setLocaleCodeFromService(this);
    }
    return orElse();
  }
}

abstract class _SetLocaleCodeFromService implements LocalizationEvent {
  const factory _SetLocaleCodeFromService(
          {required final SupportedLocaleCodes code}) =
      _$SetLocaleCodeFromServiceImpl;

  @override
  SupportedLocaleCodes get code;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetLocaleCodeFromServiceImplCopyWith<_$SetLocaleCodeFromServiceImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeLocaleCodeImplCopyWith<$Res>
    implements $LocalizationEventCopyWith<$Res> {
  factory _$$ChangeLocaleCodeImplCopyWith(_$ChangeLocaleCodeImpl value,
          $Res Function(_$ChangeLocaleCodeImpl) then) =
      __$$ChangeLocaleCodeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SupportedLocaleCodes code});
}

/// @nodoc
class __$$ChangeLocaleCodeImplCopyWithImpl<$Res>
    extends _$LocalizationEventCopyWithImpl<$Res, _$ChangeLocaleCodeImpl>
    implements _$$ChangeLocaleCodeImplCopyWith<$Res> {
  __$$ChangeLocaleCodeImplCopyWithImpl(_$ChangeLocaleCodeImpl _value,
      $Res Function(_$ChangeLocaleCodeImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
  }) {
    return _then(_$ChangeLocaleCodeImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// @nodoc

class _$ChangeLocaleCodeImpl implements _ChangeLocaleCode {
  const _$ChangeLocaleCodeImpl({required this.code});

  @override
  final SupportedLocaleCodes code;

  @override
  String toString() {
    return 'LocalizationEvent.changeLocaleCode(code: $code)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeLocaleCodeImpl &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeLocaleCodeImplCopyWith<_$ChangeLocaleCodeImpl> get copyWith =>
      __$$ChangeLocaleCodeImplCopyWithImpl<_$ChangeLocaleCodeImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(SupportedLocaleCodes code)
        setLocaleCodeFromService,
    required TResult Function(SupportedLocaleCodes code) changeLocaleCode,
  }) {
    return changeLocaleCode(code);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult? Function(SupportedLocaleCodes code)? changeLocaleCode,
  }) {
    return changeLocaleCode?.call(code);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(SupportedLocaleCodes code)? setLocaleCodeFromService,
    TResult Function(SupportedLocaleCodes code)? changeLocaleCode,
    required TResult orElse(),
  }) {
    if (changeLocaleCode != null) {
      return changeLocaleCode(code);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetLocaleCodeFromService value)
        setLocaleCodeFromService,
    required TResult Function(_ChangeLocaleCode value) changeLocaleCode,
  }) {
    return changeLocaleCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetLocaleCodeFromService value)?
        setLocaleCodeFromService,
    TResult? Function(_ChangeLocaleCode value)? changeLocaleCode,
  }) {
    return changeLocaleCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetLocaleCodeFromService value)? setLocaleCodeFromService,
    TResult Function(_ChangeLocaleCode value)? changeLocaleCode,
    required TResult orElse(),
  }) {
    if (changeLocaleCode != null) {
      return changeLocaleCode(this);
    }
    return orElse();
  }
}

abstract class _ChangeLocaleCode implements LocalizationEvent {
  const factory _ChangeLocaleCode({required final SupportedLocaleCodes code}) =
      _$ChangeLocaleCodeImpl;

  @override
  SupportedLocaleCodes get code;

  /// Create a copy of LocalizationEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeLocaleCodeImplCopyWith<_$ChangeLocaleCodeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LocalizationState {
  SupportedLocaleCodes get localeCode => throw _privateConstructorUsedError;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalizationStateCopyWith<LocalizationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalizationStateCopyWith<$Res> {
  factory $LocalizationStateCopyWith(
          LocalizationState value, $Res Function(LocalizationState) then) =
      _$LocalizationStateCopyWithImpl<$Res, LocalizationState>;
  @useResult
  $Res call({SupportedLocaleCodes localeCode});
}

/// @nodoc
class _$LocalizationStateCopyWithImpl<$Res, $Val extends LocalizationState>
    implements $LocalizationStateCopyWith<$Res> {
  _$LocalizationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localeCode = null,
  }) {
    return _then(_value.copyWith(
      localeCode: null == localeCode
          ? _value.localeCode
          : localeCode // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocalizationStateImplCopyWith<$Res>
    implements $LocalizationStateCopyWith<$Res> {
  factory _$$LocalizationStateImplCopyWith(_$LocalizationStateImpl value,
          $Res Function(_$LocalizationStateImpl) then) =
      __$$LocalizationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SupportedLocaleCodes localeCode});
}

/// @nodoc
class __$$LocalizationStateImplCopyWithImpl<$Res>
    extends _$LocalizationStateCopyWithImpl<$Res, _$LocalizationStateImpl>
    implements _$$LocalizationStateImplCopyWith<$Res> {
  __$$LocalizationStateImplCopyWithImpl(_$LocalizationStateImpl _value,
      $Res Function(_$LocalizationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localeCode = null,
  }) {
    return _then(_$LocalizationStateImpl(
      localeCode: null == localeCode
          ? _value.localeCode
          : localeCode // ignore: cast_nullable_to_non_nullable
              as SupportedLocaleCodes,
    ));
  }
}

/// @nodoc

class _$LocalizationStateImpl implements _LocalizationState {
  const _$LocalizationStateImpl({required this.localeCode});

  @override
  final SupportedLocaleCodes localeCode;

  @override
  String toString() {
    return 'LocalizationState(localeCode: $localeCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalizationStateImpl &&
            (identical(other.localeCode, localeCode) ||
                other.localeCode == localeCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, localeCode);

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalizationStateImplCopyWith<_$LocalizationStateImpl> get copyWith =>
      __$$LocalizationStateImplCopyWithImpl<_$LocalizationStateImpl>(
          this, _$identity);
}

abstract class _LocalizationState implements LocalizationState {
  const factory _LocalizationState(
          {required final SupportedLocaleCodes localeCode}) =
      _$LocalizationStateImpl;

  @override
  SupportedLocaleCodes get localeCode;

  /// Create a copy of LocalizationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalizationStateImplCopyWith<_$LocalizationStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
