// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enter_seed_phrase_input_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EnterSeedPhraseInputState {
  int get index => throw _privateConstructorUsedError;
  bool get hasError => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)
        input,
    required TResult Function(String text, int index, bool hasError) entered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)?
        input,
    TResult? Function(String text, int index, bool hasError)? entered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)?
        input,
    TResult Function(String text, int index, bool hasError)? entered,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnterSeedPhraseInput value) input,
    required TResult Function(EnterSeedPhraseEntered value) entered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnterSeedPhraseInput value)? input,
    TResult? Function(EnterSeedPhraseEntered value)? entered,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnterSeedPhraseInput value)? input,
    TResult Function(EnterSeedPhraseEntered value)? entered,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EnterSeedPhraseInputStateCopyWith<EnterSeedPhraseInputState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnterSeedPhraseInputStateCopyWith<$Res> {
  factory $EnterSeedPhraseInputStateCopyWith(EnterSeedPhraseInputState value,
          $Res Function(EnterSeedPhraseInputState) then) =
      _$EnterSeedPhraseInputStateCopyWithImpl<$Res, EnterSeedPhraseInputState>;
  @useResult
  $Res call({int index, bool hasError});
}

/// @nodoc
class _$EnterSeedPhraseInputStateCopyWithImpl<$Res,
        $Val extends EnterSeedPhraseInputState>
    implements $EnterSeedPhraseInputStateCopyWith<$Res> {
  _$EnterSeedPhraseInputStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? hasError = null,
  }) {
    return _then(_value.copyWith(
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnterSeedPhraseInputImplCopyWith<$Res>
    implements $EnterSeedPhraseInputStateCopyWith<$Res> {
  factory _$$EnterSeedPhraseInputImplCopyWith(_$EnterSeedPhraseInputImpl value,
          $Res Function(_$EnterSeedPhraseInputImpl) then) =
      __$$EnterSeedPhraseInputImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TextEditingController controller,
      FocusNode focus,
      int index,
      bool hasError});
}

/// @nodoc
class __$$EnterSeedPhraseInputImplCopyWithImpl<$Res>
    extends _$EnterSeedPhraseInputStateCopyWithImpl<$Res,
        _$EnterSeedPhraseInputImpl>
    implements _$$EnterSeedPhraseInputImplCopyWith<$Res> {
  __$$EnterSeedPhraseInputImplCopyWithImpl(_$EnterSeedPhraseInputImpl _value,
      $Res Function(_$EnterSeedPhraseInputImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = null,
    Object? focus = null,
    Object? index = null,
    Object? hasError = null,
  }) {
    return _then(_$EnterSeedPhraseInputImpl(
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      focus: null == focus
          ? _value.focus
          : focus // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EnterSeedPhraseInputImpl implements EnterSeedPhraseInput {
  const _$EnterSeedPhraseInputImpl(
      {required this.controller,
      required this.focus,
      required this.index,
      required this.hasError});

  @override
  final TextEditingController controller;
  @override
  final FocusNode focus;
  @override
  final int index;
  @override
  final bool hasError;

  @override
  String toString() {
    return 'EnterSeedPhraseInputState.input(controller: $controller, focus: $focus, index: $index, hasError: $hasError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterSeedPhraseInputImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.focus, focus) || other.focus == focus) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, controller, focus, index, hasError);

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnterSeedPhraseInputImplCopyWith<_$EnterSeedPhraseInputImpl>
      get copyWith =>
          __$$EnterSeedPhraseInputImplCopyWithImpl<_$EnterSeedPhraseInputImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)
        input,
    required TResult Function(String text, int index, bool hasError) entered,
  }) {
    return input(controller, focus, index, hasError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)?
        input,
    TResult? Function(String text, int index, bool hasError)? entered,
  }) {
    return input?.call(controller, focus, index, hasError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)?
        input,
    TResult Function(String text, int index, bool hasError)? entered,
    required TResult orElse(),
  }) {
    if (input != null) {
      return input(controller, focus, index, hasError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnterSeedPhraseInput value) input,
    required TResult Function(EnterSeedPhraseEntered value) entered,
  }) {
    return input(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnterSeedPhraseInput value)? input,
    TResult? Function(EnterSeedPhraseEntered value)? entered,
  }) {
    return input?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnterSeedPhraseInput value)? input,
    TResult Function(EnterSeedPhraseEntered value)? entered,
    required TResult orElse(),
  }) {
    if (input != null) {
      return input(this);
    }
    return orElse();
  }
}

abstract class EnterSeedPhraseInput implements EnterSeedPhraseInputState {
  const factory EnterSeedPhraseInput(
      {required final TextEditingController controller,
      required final FocusNode focus,
      required final int index,
      required final bool hasError}) = _$EnterSeedPhraseInputImpl;

  TextEditingController get controller;
  FocusNode get focus;
  @override
  int get index;
  @override
  bool get hasError;

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnterSeedPhraseInputImplCopyWith<_$EnterSeedPhraseInputImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnterSeedPhraseEnteredImplCopyWith<$Res>
    implements $EnterSeedPhraseInputStateCopyWith<$Res> {
  factory _$$EnterSeedPhraseEnteredImplCopyWith(
          _$EnterSeedPhraseEnteredImpl value,
          $Res Function(_$EnterSeedPhraseEnteredImpl) then) =
      __$$EnterSeedPhraseEnteredImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, int index, bool hasError});
}

/// @nodoc
class __$$EnterSeedPhraseEnteredImplCopyWithImpl<$Res>
    extends _$EnterSeedPhraseInputStateCopyWithImpl<$Res,
        _$EnterSeedPhraseEnteredImpl>
    implements _$$EnterSeedPhraseEnteredImplCopyWith<$Res> {
  __$$EnterSeedPhraseEnteredImplCopyWithImpl(
      _$EnterSeedPhraseEnteredImpl _value,
      $Res Function(_$EnterSeedPhraseEnteredImpl) _then)
      : super(_value, _then);

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? index = null,
    Object? hasError = null,
  }) {
    return _then(_$EnterSeedPhraseEnteredImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      hasError: null == hasError
          ? _value.hasError
          : hasError // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EnterSeedPhraseEnteredImpl implements EnterSeedPhraseEntered {
  const _$EnterSeedPhraseEnteredImpl(
      {required this.text, required this.index, required this.hasError});

  @override
  final String text;
  @override
  final int index;
  @override
  final bool hasError;

  @override
  String toString() {
    return 'EnterSeedPhraseInputState.entered(text: $text, index: $index, hasError: $hasError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterSeedPhraseEnteredImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.hasError, hasError) ||
                other.hasError == hasError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, index, hasError);

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnterSeedPhraseEnteredImplCopyWith<_$EnterSeedPhraseEnteredImpl>
      get copyWith => __$$EnterSeedPhraseEnteredImplCopyWithImpl<
          _$EnterSeedPhraseEnteredImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)
        input,
    required TResult Function(String text, int index, bool hasError) entered,
  }) {
    return entered(text, index, hasError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)?
        input,
    TResult? Function(String text, int index, bool hasError)? entered,
  }) {
    return entered?.call(text, index, hasError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(TextEditingController controller, FocusNode focus,
            int index, bool hasError)?
        input,
    TResult Function(String text, int index, bool hasError)? entered,
    required TResult orElse(),
  }) {
    if (entered != null) {
      return entered(text, index, hasError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EnterSeedPhraseInput value) input,
    required TResult Function(EnterSeedPhraseEntered value) entered,
  }) {
    return entered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EnterSeedPhraseInput value)? input,
    TResult? Function(EnterSeedPhraseEntered value)? entered,
  }) {
    return entered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EnterSeedPhraseInput value)? input,
    TResult Function(EnterSeedPhraseEntered value)? entered,
    required TResult orElse(),
  }) {
    if (entered != null) {
      return entered(this);
    }
    return orElse();
  }
}

abstract class EnterSeedPhraseEntered implements EnterSeedPhraseInputState {
  const factory EnterSeedPhraseEntered(
      {required final String text,
      required final int index,
      required final bool hasError}) = _$EnterSeedPhraseEnteredImpl;

  String get text;
  @override
  int get index;
  @override
  bool get hasError;

  /// Create a copy of EnterSeedPhraseInputState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnterSeedPhraseEnteredImplCopyWith<_$EnterSeedPhraseEnteredImpl>
      get copyWith => throw _privateConstructorUsedError;
}
