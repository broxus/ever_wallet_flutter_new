// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hud_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HudEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? show,
    TResult? Function()? hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? hide,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Hide value) hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Show value)? show,
    TResult? Function(_Hide value)? hide,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Hide value)? hide,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HudEventCopyWith<$Res> {
  factory $HudEventCopyWith(HudEvent value, $Res Function(HudEvent) then) =
      _$HudEventCopyWithImpl<$Res, HudEvent>;
}

/// @nodoc
class _$HudEventCopyWithImpl<$Res, $Val extends HudEvent>
    implements $HudEventCopyWith<$Res> {
  _$HudEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ShowImplCopyWith<$Res> {
  factory _$$ShowImplCopyWith(
          _$ShowImpl value, $Res Function(_$ShowImpl) then) =
      __$$ShowImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShowImplCopyWithImpl<$Res>
    extends _$HudEventCopyWithImpl<$Res, _$ShowImpl>
    implements _$$ShowImplCopyWith<$Res> {
  __$$ShowImplCopyWithImpl(_$ShowImpl _value, $Res Function(_$ShowImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ShowImpl implements _Show {
  const _$ShowImpl();

  @override
  String toString() {
    return 'HudEvent.show()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShowImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() hide,
  }) {
    return show();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? show,
    TResult? Function()? hide,
  }) {
    return show?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? hide,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Hide value) hide,
  }) {
    return show(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Show value)? show,
    TResult? Function(_Hide value)? hide,
  }) {
    return show?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Hide value)? hide,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show(this);
    }
    return orElse();
  }
}

abstract class _Show implements HudEvent {
  const factory _Show() = _$ShowImpl;
}

/// @nodoc
abstract class _$$HideImplCopyWith<$Res> {
  factory _$$HideImplCopyWith(
          _$HideImpl value, $Res Function(_$HideImpl) then) =
      __$$HideImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$HideImplCopyWithImpl<$Res>
    extends _$HudEventCopyWithImpl<$Res, _$HideImpl>
    implements _$$HideImplCopyWith<$Res> {
  __$$HideImplCopyWithImpl(_$HideImpl _value, $Res Function(_$HideImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$HideImpl implements _Hide {
  const _$HideImpl();

  @override
  String toString() {
    return 'HudEvent.hide()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$HideImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() hide,
  }) {
    return hide();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? show,
    TResult? Function()? hide,
  }) {
    return hide?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? hide,
    required TResult orElse(),
  }) {
    if (hide != null) {
      return hide();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Hide value) hide,
  }) {
    return hide(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Show value)? show,
    TResult? Function(_Hide value)? hide,
  }) {
    return hide?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Hide value)? hide,
    required TResult orElse(),
  }) {
    if (hide != null) {
      return hide(this);
    }
    return orElse();
  }
}

abstract class _Hide implements HudEvent {
  const factory _Hide() = _$HideImpl;
}

/// @nodoc
mixin _$HudState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() visible,
    required TResult Function() invisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? visible,
    TResult? Function()? invisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? visible,
    TResult Function()? invisible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Visible value) visible,
    required TResult Function(_Invisible value) invisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Visible value)? visible,
    TResult? Function(_Invisible value)? invisible,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Visible value)? visible,
    TResult Function(_Invisible value)? invisible,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HudStateCopyWith<$Res> {
  factory $HudStateCopyWith(HudState value, $Res Function(HudState) then) =
      _$HudStateCopyWithImpl<$Res, HudState>;
}

/// @nodoc
class _$HudStateCopyWithImpl<$Res, $Val extends HudState>
    implements $HudStateCopyWith<$Res> {
  _$HudStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$VisibleImplCopyWith<$Res> {
  factory _$$VisibleImplCopyWith(
          _$VisibleImpl value, $Res Function(_$VisibleImpl) then) =
      __$$VisibleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$VisibleImplCopyWithImpl<$Res>
    extends _$HudStateCopyWithImpl<$Res, _$VisibleImpl>
    implements _$$VisibleImplCopyWith<$Res> {
  __$$VisibleImplCopyWithImpl(
      _$VisibleImpl _value, $Res Function(_$VisibleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$VisibleImpl implements _Visible {
  const _$VisibleImpl();

  @override
  String toString() {
    return 'HudState.visible()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$VisibleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() visible,
    required TResult Function() invisible,
  }) {
    return visible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? visible,
    TResult? Function()? invisible,
  }) {
    return visible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? visible,
    TResult Function()? invisible,
    required TResult orElse(),
  }) {
    if (visible != null) {
      return visible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Visible value) visible,
    required TResult Function(_Invisible value) invisible,
  }) {
    return visible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Visible value)? visible,
    TResult? Function(_Invisible value)? invisible,
  }) {
    return visible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Visible value)? visible,
    TResult Function(_Invisible value)? invisible,
    required TResult orElse(),
  }) {
    if (visible != null) {
      return visible(this);
    }
    return orElse();
  }
}

abstract class _Visible implements HudState {
  const factory _Visible() = _$VisibleImpl;
}

/// @nodoc
abstract class _$$InvisibleImplCopyWith<$Res> {
  factory _$$InvisibleImplCopyWith(
          _$InvisibleImpl value, $Res Function(_$InvisibleImpl) then) =
      __$$InvisibleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvisibleImplCopyWithImpl<$Res>
    extends _$HudStateCopyWithImpl<$Res, _$InvisibleImpl>
    implements _$$InvisibleImplCopyWith<$Res> {
  __$$InvisibleImplCopyWithImpl(
      _$InvisibleImpl _value, $Res Function(_$InvisibleImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$InvisibleImpl implements _Invisible {
  const _$InvisibleImpl();

  @override
  String toString() {
    return 'HudState.invisible()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InvisibleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() visible,
    required TResult Function() invisible,
  }) {
    return invisible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? visible,
    TResult? Function()? invisible,
  }) {
    return invisible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? visible,
    TResult Function()? invisible,
    required TResult orElse(),
  }) {
    if (invisible != null) {
      return invisible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Visible value) visible,
    required TResult Function(_Invisible value) invisible,
  }) {
    return invisible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Visible value)? visible,
    TResult? Function(_Invisible value)? invisible,
  }) {
    return invisible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Visible value)? visible,
    TResult Function(_Invisible value)? invisible,
    required TResult orElse(),
  }) {
    if (invisible != null) {
      return invisible(this);
    }
    return orElse();
  }
}

abstract class _Invisible implements HudState {
  const factory _Invisible() = _$InvisibleImpl;
}
