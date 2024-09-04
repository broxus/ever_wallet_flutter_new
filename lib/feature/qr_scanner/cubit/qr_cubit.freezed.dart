// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QrCubitState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() givePermissionsError,
    required TResult Function(MobileScannerController controller, String? data)
        scanning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? givePermissionsError,
    TResult? Function(MobileScannerController controller, String? data)?
        scanning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? givePermissionsError,
    TResult Function(MobileScannerController controller, String? data)?
        scanning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_GivePermissions value) givePermissionsError,
    required TResult Function(_Scanning value) scanning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GivePermissions value)? givePermissionsError,
    TResult? Function(_Scanning value)? scanning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_GivePermissions value)? givePermissionsError,
    TResult Function(_Scanning value)? scanning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QrCubitStateCopyWith<$Res> {
  factory $QrCubitStateCopyWith(
          QrCubitState value, $Res Function(QrCubitState) then) =
      _$QrCubitStateCopyWithImpl<$Res, QrCubitState>;
}

/// @nodoc
class _$QrCubitStateCopyWithImpl<$Res, $Val extends QrCubitState>
    implements $QrCubitStateCopyWith<$Res> {
  _$QrCubitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QrCubitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$QrCubitStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrCubitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'QrCubitState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() givePermissionsError,
    required TResult Function(MobileScannerController controller, String? data)
        scanning,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? givePermissionsError,
    TResult? Function(MobileScannerController controller, String? data)?
        scanning,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? givePermissionsError,
    TResult Function(MobileScannerController controller, String? data)?
        scanning,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_GivePermissions value) givePermissionsError,
    required TResult Function(_Scanning value) scanning,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GivePermissions value)? givePermissionsError,
    TResult? Function(_Scanning value)? scanning,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_GivePermissions value)? givePermissionsError,
    TResult Function(_Scanning value)? scanning,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements QrCubitState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$GivePermissionsImplCopyWith<$Res> {
  factory _$$GivePermissionsImplCopyWith(_$GivePermissionsImpl value,
          $Res Function(_$GivePermissionsImpl) then) =
      __$$GivePermissionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GivePermissionsImplCopyWithImpl<$Res>
    extends _$QrCubitStateCopyWithImpl<$Res, _$GivePermissionsImpl>
    implements _$$GivePermissionsImplCopyWith<$Res> {
  __$$GivePermissionsImplCopyWithImpl(
      _$GivePermissionsImpl _value, $Res Function(_$GivePermissionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrCubitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$GivePermissionsImpl implements _GivePermissions {
  const _$GivePermissionsImpl();

  @override
  String toString() {
    return 'QrCubitState.givePermissionsError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GivePermissionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() givePermissionsError,
    required TResult Function(MobileScannerController controller, String? data)
        scanning,
  }) {
    return givePermissionsError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? givePermissionsError,
    TResult? Function(MobileScannerController controller, String? data)?
        scanning,
  }) {
    return givePermissionsError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? givePermissionsError,
    TResult Function(MobileScannerController controller, String? data)?
        scanning,
    required TResult orElse(),
  }) {
    if (givePermissionsError != null) {
      return givePermissionsError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_GivePermissions value) givePermissionsError,
    required TResult Function(_Scanning value) scanning,
  }) {
    return givePermissionsError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GivePermissions value)? givePermissionsError,
    TResult? Function(_Scanning value)? scanning,
  }) {
    return givePermissionsError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_GivePermissions value)? givePermissionsError,
    TResult Function(_Scanning value)? scanning,
    required TResult orElse(),
  }) {
    if (givePermissionsError != null) {
      return givePermissionsError(this);
    }
    return orElse();
  }
}

abstract class _GivePermissions implements QrCubitState {
  const factory _GivePermissions() = _$GivePermissionsImpl;
}

/// @nodoc
abstract class _$$ScanningImplCopyWith<$Res> {
  factory _$$ScanningImplCopyWith(
          _$ScanningImpl value, $Res Function(_$ScanningImpl) then) =
      __$$ScanningImplCopyWithImpl<$Res>;
  @useResult
  $Res call({MobileScannerController controller, String? data});
}

/// @nodoc
class __$$ScanningImplCopyWithImpl<$Res>
    extends _$QrCubitStateCopyWithImpl<$Res, _$ScanningImpl>
    implements _$$ScanningImplCopyWith<$Res> {
  __$$ScanningImplCopyWithImpl(
      _$ScanningImpl _value, $Res Function(_$ScanningImpl) _then)
      : super(_value, _then);

  /// Create a copy of QrCubitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? controller = null,
    Object? data = freezed,
  }) {
    return _then(_$ScanningImpl(
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as MobileScannerController,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ScanningImpl implements _Scanning {
  const _$ScanningImpl({required this.controller, this.data});

  @override
  final MobileScannerController controller;
  @override
  final String? data;

  @override
  String toString() {
    return 'QrCubitState.scanning(controller: $controller, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScanningImpl &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, controller, data);

  /// Create a copy of QrCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScanningImplCopyWith<_$ScanningImpl> get copyWith =>
      __$$ScanningImplCopyWithImpl<_$ScanningImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() givePermissionsError,
    required TResult Function(MobileScannerController controller, String? data)
        scanning,
  }) {
    return scanning(controller, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? givePermissionsError,
    TResult? Function(MobileScannerController controller, String? data)?
        scanning,
  }) {
    return scanning?.call(controller, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? givePermissionsError,
    TResult Function(MobileScannerController controller, String? data)?
        scanning,
    required TResult orElse(),
  }) {
    if (scanning != null) {
      return scanning(controller, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_GivePermissions value) givePermissionsError,
    required TResult Function(_Scanning value) scanning,
  }) {
    return scanning(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_GivePermissions value)? givePermissionsError,
    TResult? Function(_Scanning value)? scanning,
  }) {
    return scanning?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_GivePermissions value)? givePermissionsError,
    TResult Function(_Scanning value)? scanning,
    required TResult orElse(),
  }) {
    if (scanning != null) {
      return scanning(this);
    }
    return orElse();
  }
}

abstract class _Scanning implements QrCubitState {
  const factory _Scanning(
      {required final MobileScannerController controller,
      final String? data}) = _$ScanningImpl;

  MobileScannerController get controller;
  String? get data;

  /// Create a copy of QrCubitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScanningImplCopyWith<_$ScanningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
