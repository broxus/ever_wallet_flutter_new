// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transport_manifest_option.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransportManifestOption {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fromConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fromConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fromConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransportManifestOptionFromConnection value)
        fromConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransportManifestOptionFromConnection value)?
        fromConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransportManifestOptionFromConnection value)?
        fromConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransportManifestOptionCopyWith<$Res> {
  factory $TransportManifestOptionCopyWith(TransportManifestOption value,
          $Res Function(TransportManifestOption) then) =
      _$TransportManifestOptionCopyWithImpl<$Res, TransportManifestOption>;
}

/// @nodoc
class _$TransportManifestOptionCopyWithImpl<$Res,
        $Val extends TransportManifestOption>
    implements $TransportManifestOptionCopyWith<$Res> {
  _$TransportManifestOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransportManifestOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransportManifestOptionFromConnectionImplCopyWith<$Res> {
  factory _$$TransportManifestOptionFromConnectionImplCopyWith(
          _$TransportManifestOptionFromConnectionImpl value,
          $Res Function(_$TransportManifestOptionFromConnectionImpl) then) =
      __$$TransportManifestOptionFromConnectionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransportManifestOptionFromConnectionImplCopyWithImpl<$Res>
    extends _$TransportManifestOptionCopyWithImpl<$Res,
        _$TransportManifestOptionFromConnectionImpl>
    implements _$$TransportManifestOptionFromConnectionImplCopyWith<$Res> {
  __$$TransportManifestOptionFromConnectionImplCopyWithImpl(
      _$TransportManifestOptionFromConnectionImpl _value,
      $Res Function(_$TransportManifestOptionFromConnectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransportManifestOption
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransportManifestOptionFromConnectionImpl
    implements _TransportManifestOptionFromConnection {
  const _$TransportManifestOptionFromConnectionImpl();

  @override
  String toString() {
    return 'TransportManifestOption.fromConnection()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransportManifestOptionFromConnectionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fromConnection,
  }) {
    return fromConnection();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? fromConnection,
  }) {
    return fromConnection?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fromConnection,
    required TResult orElse(),
  }) {
    if (fromConnection != null) {
      return fromConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_TransportManifestOptionFromConnection value)
        fromConnection,
  }) {
    return fromConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_TransportManifestOptionFromConnection value)?
        fromConnection,
  }) {
    return fromConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_TransportManifestOptionFromConnection value)?
        fromConnection,
    required TResult orElse(),
  }) {
    if (fromConnection != null) {
      return fromConnection(this);
    }
    return orElse();
  }
}

abstract class _TransportManifestOptionFromConnection
    implements TransportManifestOption {
  const factory _TransportManifestOptionFromConnection() =
      _$TransportManifestOptionFromConnectionImpl;
}
