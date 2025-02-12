// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_deploy_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletDeployEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDeployEventCopyWith<$Res> {
  factory $WalletDeployEventCopyWith(
          WalletDeployEvent value, $Res Function(WalletDeployEvent) then) =
      _$WalletDeployEventCopyWithImpl<$Res, WalletDeployEvent>;
}

/// @nodoc
class _$WalletDeployEventCopyWithImpl<$Res, $Val extends WalletDeployEvent>
    implements $WalletDeployEventCopyWith<$Res> {
  _$WalletDeployEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PrevStepImplCopyWith<$Res> {
  factory _$$PrevStepImplCopyWith(
          _$PrevStepImpl value, $Res Function(_$PrevStepImpl) then) =
      __$$PrevStepImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PrevStepImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$PrevStepImpl>
    implements _$$PrevStepImplCopyWith<$Res> {
  __$$PrevStepImplCopyWithImpl(
      _$PrevStepImpl _value, $Res Function(_$PrevStepImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PrevStepImpl implements _PrevStep {
  const _$PrevStepImpl();

  @override
  String toString() {
    return 'WalletDeployEvent.goPrevStep()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PrevStepImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return goPrevStep();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return goPrevStep?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (goPrevStep != null) {
      return goPrevStep();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return goPrevStep(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return goPrevStep?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (goPrevStep != null) {
      return goPrevStep(this);
    }
    return orElse();
  }
}

abstract class _PrevStep implements WalletDeployEvent {
  const factory _PrevStep() = _$PrevStepImpl;
}

/// @nodoc
abstract class _$$ChangeTypeImplCopyWith<$Res> {
  factory _$$ChangeTypeImplCopyWith(
          _$ChangeTypeImpl value, $Res Function(_$ChangeTypeImpl) then) =
      __$$ChangeTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({WalletDeployType type});
}

/// @nodoc
class __$$ChangeTypeImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$ChangeTypeImpl>
    implements _$$ChangeTypeImplCopyWith<$Res> {
  __$$ChangeTypeImplCopyWithImpl(
      _$ChangeTypeImpl _value, $Res Function(_$ChangeTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$ChangeTypeImpl(
      null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as WalletDeployType,
    ));
  }
}

/// @nodoc

class _$ChangeTypeImpl implements _ChangeType {
  const _$ChangeTypeImpl(this.type);

  @override
  final WalletDeployType type;

  @override
  String toString() {
    return 'WalletDeployEvent.changeType(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeTypeImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeTypeImplCopyWith<_$ChangeTypeImpl> get copyWith =>
      __$$ChangeTypeImplCopyWithImpl<_$ChangeTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return changeType(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return changeType?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (changeType != null) {
      return changeType(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return changeType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return changeType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (changeType != null) {
      return changeType(this);
    }
    return orElse();
  }
}

abstract class _ChangeType implements WalletDeployEvent {
  const factory _ChangeType(final WalletDeployType type) = _$ChangeTypeImpl;

  WalletDeployType get type;

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeTypeImplCopyWith<_$ChangeTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateMultisigDataImplCopyWith<$Res> {
  factory _$$UpdateMultisigDataImplCopyWith(_$UpdateMultisigDataImpl value,
          $Res Function(_$UpdateMultisigDataImpl) then) =
      __$$UpdateMultisigDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PublicKey> custodians, int requireConfirmations, int? hours});
}

/// @nodoc
class __$$UpdateMultisigDataImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$UpdateMultisigDataImpl>
    implements _$$UpdateMultisigDataImplCopyWith<$Res> {
  __$$UpdateMultisigDataImplCopyWithImpl(_$UpdateMultisigDataImpl _value,
      $Res Function(_$UpdateMultisigDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? custodians = null,
    Object? requireConfirmations = null,
    Object? hours = freezed,
  }) {
    return _then(_$UpdateMultisigDataImpl(
      null == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      null == requireConfirmations
          ? _value.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$UpdateMultisigDataImpl implements _UpdateMultisigData {
  const _$UpdateMultisigDataImpl(
      final List<PublicKey> custodians, this.requireConfirmations, this.hours)
      : _custodians = custodians;

  final List<PublicKey> _custodians;
  @override
  List<PublicKey> get custodians {
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_custodians);
  }

  @override
  final int requireConfirmations;
  @override
  final int? hours;

  @override
  String toString() {
    return 'WalletDeployEvent.updateMultisigData(custodians: $custodians, requireConfirmations: $requireConfirmations, hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateMultisigDataImpl &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.hours, hours) || other.hours == hours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      hours);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateMultisigDataImplCopyWith<_$UpdateMultisigDataImpl> get copyWith =>
      __$$UpdateMultisigDataImplCopyWithImpl<_$UpdateMultisigDataImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return updateMultisigData(custodians, requireConfirmations, hours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return updateMultisigData?.call(custodians, requireConfirmations, hours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (updateMultisigData != null) {
      return updateMultisigData(custodians, requireConfirmations, hours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return updateMultisigData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return updateMultisigData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (updateMultisigData != null) {
      return updateMultisigData(this);
    }
    return orElse();
  }
}

abstract class _UpdateMultisigData implements WalletDeployEvent {
  const factory _UpdateMultisigData(
      final List<PublicKey> custodians,
      final int requireConfirmations,
      final int? hours) = _$UpdateMultisigDataImpl;

  List<PublicKey> get custodians;
  int get requireConfirmations;
  int? get hours;

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateMultisigDataImplCopyWith<_$UpdateMultisigDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeployStandardImplCopyWith<$Res> {
  factory _$$DeployStandardImplCopyWith(_$DeployStandardImpl value,
          $Res Function(_$DeployStandardImpl) then) =
      __$$DeployStandardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DeployStandardImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$DeployStandardImpl>
    implements _$$DeployStandardImplCopyWith<$Res> {
  __$$DeployStandardImplCopyWithImpl(
      _$DeployStandardImpl _value, $Res Function(_$DeployStandardImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DeployStandardImpl implements _DeployStandard {
  const _$DeployStandardImpl();

  @override
  String toString() {
    return 'WalletDeployEvent.deployStandard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$DeployStandardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return deployStandard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return deployStandard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (deployStandard != null) {
      return deployStandard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return deployStandard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return deployStandard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (deployStandard != null) {
      return deployStandard(this);
    }
    return orElse();
  }
}

abstract class _DeployStandard implements WalletDeployEvent {
  const factory _DeployStandard() = _$DeployStandardImpl;
}

/// @nodoc
abstract class _$$DeployMultisigImplCopyWith<$Res> {
  factory _$$DeployMultisigImplCopyWith(_$DeployMultisigImpl value,
          $Res Function(_$DeployMultisigImpl) then) =
      __$$DeployMultisigImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PublicKey> custodians, int requireConfirmations, int? hours});
}

/// @nodoc
class __$$DeployMultisigImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$DeployMultisigImpl>
    implements _$$DeployMultisigImplCopyWith<$Res> {
  __$$DeployMultisigImplCopyWithImpl(
      _$DeployMultisigImpl _value, $Res Function(_$DeployMultisigImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? custodians = null,
    Object? requireConfirmations = null,
    Object? hours = freezed,
  }) {
    return _then(_$DeployMultisigImpl(
      null == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      null == requireConfirmations
          ? _value.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
      freezed == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$DeployMultisigImpl implements _DeployMultisig {
  const _$DeployMultisigImpl(
      final List<PublicKey> custodians, this.requireConfirmations, this.hours)
      : _custodians = custodians;

  final List<PublicKey> _custodians;
  @override
  List<PublicKey> get custodians {
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_custodians);
  }

  @override
  final int requireConfirmations;
  @override
  final int? hours;

  @override
  String toString() {
    return 'WalletDeployEvent.deployMultisig(custodians: $custodians, requireConfirmations: $requireConfirmations, hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeployMultisigImpl &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.hours, hours) || other.hours == hours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      hours);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeployMultisigImplCopyWith<_$DeployMultisigImpl> get copyWith =>
      __$$DeployMultisigImplCopyWithImpl<_$DeployMultisigImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return deployMultisig(custodians, requireConfirmations, hours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return deployMultisig?.call(custodians, requireConfirmations, hours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (deployMultisig != null) {
      return deployMultisig(custodians, requireConfirmations, hours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return deployMultisig(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return deployMultisig?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (deployMultisig != null) {
      return deployMultisig(this);
    }
    return orElse();
  }
}

abstract class _DeployMultisig implements WalletDeployEvent {
  const factory _DeployMultisig(final List<PublicKey> custodians,
      final int requireConfirmations, final int? hours) = _$DeployMultisigImpl;

  List<PublicKey> get custodians;
  int get requireConfirmations;
  int? get hours;

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeployMultisigImplCopyWith<_$DeployMultisigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConfirmDeployImplCopyWith<$Res> {
  factory _$$ConfirmDeployImplCopyWith(
          _$ConfirmDeployImpl value, $Res Function(_$ConfirmDeployImpl) then) =
      __$$ConfirmDeployImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$ConfirmDeployImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$ConfirmDeployImpl>
    implements _$$ConfirmDeployImplCopyWith<$Res> {
  __$$ConfirmDeployImplCopyWithImpl(
      _$ConfirmDeployImpl _value, $Res Function(_$ConfirmDeployImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$ConfirmDeployImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ConfirmDeployImpl implements _ConfirmDeploy {
  const _$ConfirmDeployImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'WalletDeployEvent.confirmDeploy(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmDeployImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmDeployImplCopyWith<_$ConfirmDeployImpl> get copyWith =>
      __$$ConfirmDeployImplCopyWithImpl<_$ConfirmDeployImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return confirmDeploy(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return confirmDeploy?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (confirmDeploy != null) {
      return confirmDeploy(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return confirmDeploy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return confirmDeploy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (confirmDeploy != null) {
      return confirmDeploy(this);
    }
    return orElse();
  }
}

abstract class _ConfirmDeploy implements WalletDeployEvent {
  const factory _ConfirmDeploy(final String password) = _$ConfirmDeployImpl;

  String get password;

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConfirmDeployImplCopyWith<_$ConfirmDeployImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AllowCloseDeployImplCopyWith<$Res> {
  factory _$$AllowCloseDeployImplCopyWith(_$AllowCloseDeployImpl value,
          $Res Function(_$AllowCloseDeployImpl) then) =
      __$$AllowCloseDeployImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllowCloseDeployImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$AllowCloseDeployImpl>
    implements _$$AllowCloseDeployImplCopyWith<$Res> {
  __$$AllowCloseDeployImplCopyWithImpl(_$AllowCloseDeployImpl _value,
      $Res Function(_$AllowCloseDeployImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllowCloseDeployImpl implements _AllowCloseDeploy {
  const _$AllowCloseDeployImpl();

  @override
  String toString() {
    return 'WalletDeployEvent.allowCloseDeploy()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AllowCloseDeployImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return allowCloseDeploy();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return allowCloseDeploy?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (allowCloseDeploy != null) {
      return allowCloseDeploy();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return allowCloseDeploy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return allowCloseDeploy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (allowCloseDeploy != null) {
      return allowCloseDeploy(this);
    }
    return orElse();
  }
}

abstract class _AllowCloseDeploy implements WalletDeployEvent {
  const factory _AllowCloseDeploy() = _$AllowCloseDeployImpl;
}

/// @nodoc
abstract class _$$CompleteDeployImplCopyWith<$Res> {
  factory _$$CompleteDeployImplCopyWith(_$CompleteDeployImpl value,
          $Res Function(_$CompleteDeployImpl) then) =
      __$$CompleteDeployImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Transaction transaction});

  $TransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$CompleteDeployImplCopyWithImpl<$Res>
    extends _$WalletDeployEventCopyWithImpl<$Res, _$CompleteDeployImpl>
    implements _$$CompleteDeployImplCopyWith<$Res> {
  __$$CompleteDeployImplCopyWithImpl(
      _$CompleteDeployImpl _value, $Res Function(_$CompleteDeployImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
  }) {
    return _then(_$CompleteDeployImpl(
      null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
    ));
  }

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res> get transaction {
    return $TransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$CompleteDeployImpl implements _CompleteDeploy {
  const _$CompleteDeployImpl(this.transaction);

  @override
  final Transaction transaction;

  @override
  String toString() {
    return 'WalletDeployEvent.completeDeploy(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteDeployImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompleteDeployImplCopyWith<_$CompleteDeployImpl> get copyWith =>
      __$$CompleteDeployImplCopyWithImpl<_$CompleteDeployImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() goPrevStep,
    required TResult Function(WalletDeployType type) changeType,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        updateMultisigData,
    required TResult Function() deployStandard,
    required TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)
        deployMultisig,
    required TResult Function(String password) confirmDeploy,
    required TResult Function() allowCloseDeploy,
    required TResult Function(Transaction transaction) completeDeploy,
  }) {
    return completeDeploy(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? goPrevStep,
    TResult? Function(WalletDeployType type)? changeType,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult? Function()? deployStandard,
    TResult? Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult? Function(String password)? confirmDeploy,
    TResult? Function()? allowCloseDeploy,
    TResult? Function(Transaction transaction)? completeDeploy,
  }) {
    return completeDeploy?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? goPrevStep,
    TResult Function(WalletDeployType type)? changeType,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        updateMultisigData,
    TResult Function()? deployStandard,
    TResult Function(
            List<PublicKey> custodians, int requireConfirmations, int? hours)?
        deployMultisig,
    TResult Function(String password)? confirmDeploy,
    TResult Function()? allowCloseDeploy,
    TResult Function(Transaction transaction)? completeDeploy,
    required TResult orElse(),
  }) {
    if (completeDeploy != null) {
      return completeDeploy(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PrevStep value) goPrevStep,
    required TResult Function(_ChangeType value) changeType,
    required TResult Function(_UpdateMultisigData value) updateMultisigData,
    required TResult Function(_DeployStandard value) deployStandard,
    required TResult Function(_DeployMultisig value) deployMultisig,
    required TResult Function(_ConfirmDeploy value) confirmDeploy,
    required TResult Function(_AllowCloseDeploy value) allowCloseDeploy,
    required TResult Function(_CompleteDeploy value) completeDeploy,
  }) {
    return completeDeploy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PrevStep value)? goPrevStep,
    TResult? Function(_ChangeType value)? changeType,
    TResult? Function(_UpdateMultisigData value)? updateMultisigData,
    TResult? Function(_DeployStandard value)? deployStandard,
    TResult? Function(_DeployMultisig value)? deployMultisig,
    TResult? Function(_ConfirmDeploy value)? confirmDeploy,
    TResult? Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult? Function(_CompleteDeploy value)? completeDeploy,
  }) {
    return completeDeploy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PrevStep value)? goPrevStep,
    TResult Function(_ChangeType value)? changeType,
    TResult Function(_UpdateMultisigData value)? updateMultisigData,
    TResult Function(_DeployStandard value)? deployStandard,
    TResult Function(_DeployMultisig value)? deployMultisig,
    TResult Function(_ConfirmDeploy value)? confirmDeploy,
    TResult Function(_AllowCloseDeploy value)? allowCloseDeploy,
    TResult Function(_CompleteDeploy value)? completeDeploy,
    required TResult orElse(),
  }) {
    if (completeDeploy != null) {
      return completeDeploy(this);
    }
    return orElse();
  }
}

abstract class _CompleteDeploy implements WalletDeployEvent {
  const factory _CompleteDeploy(final Transaction transaction) =
      _$CompleteDeployImpl;

  Transaction get transaction;

  /// Create a copy of WalletDeployEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompleteDeployImplCopyWith<_$CompleteDeployImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WalletDeployState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletDeployStateCopyWith<$Res> {
  factory $WalletDeployStateCopyWith(
          WalletDeployState value, $Res Function(WalletDeployState) then) =
      _$WalletDeployStateCopyWithImpl<$Res, WalletDeployState>;
}

/// @nodoc
class _$WalletDeployStateCopyWithImpl<$Res, $Val extends WalletDeployState>
    implements $WalletDeployStateCopyWith<$Res> {
  _$WalletDeployStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StandardImplCopyWith<$Res> {
  factory _$$StandardImplCopyWith(
          _$StandardImpl value, $Res Function(_$StandardImpl) then) =
      __$$StandardImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StandardImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$StandardImpl>
    implements _$$StandardImplCopyWith<$Res> {
  __$$StandardImplCopyWithImpl(
      _$StandardImpl _value, $Res Function(_$StandardImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StandardImpl implements _Standard {
  const _$StandardImpl();

  @override
  String toString() {
    return 'WalletDeployState.standard()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StandardImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return standard();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return standard?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (standard != null) {
      return standard();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return standard(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return standard?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (standard != null) {
      return standard(this);
    }
    return orElse();
  }
}

abstract class _Standard implements WalletDeployState {
  const factory _Standard() = _$StandardImpl;
}

/// @nodoc
abstract class _$$MultisigImplCopyWith<$Res> {
  factory _$$MultisigImplCopyWith(
          _$MultisigImpl value, $Res Function(_$MultisigImpl) then) =
      __$$MultisigImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<PublicKey> custodians,
      int requireConfirmations,
      int hours,
      WalletType walletType});

  $WalletTypeCopyWith<$Res> get walletType;
}

/// @nodoc
class __$$MultisigImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$MultisigImpl>
    implements _$$MultisigImplCopyWith<$Res> {
  __$$MultisigImplCopyWithImpl(
      _$MultisigImpl _value, $Res Function(_$MultisigImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? custodians = null,
    Object? requireConfirmations = null,
    Object? hours = null,
    Object? walletType = null,
  }) {
    return _then(_$MultisigImpl(
      null == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      null == requireConfirmations
          ? _value.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int,
      null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      null == walletType
          ? _value.walletType
          : walletType // ignore: cast_nullable_to_non_nullable
              as WalletType,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WalletTypeCopyWith<$Res> get walletType {
    return $WalletTypeCopyWith<$Res>(_value.walletType, (value) {
      return _then(_value.copyWith(walletType: value));
    });
  }
}

/// @nodoc

class _$MultisigImpl implements _Multisig {
  const _$MultisigImpl(final List<PublicKey> custodians,
      this.requireConfirmations, this.hours, this.walletType)
      : _custodians = custodians;

  final List<PublicKey> _custodians;
  @override
  List<PublicKey> get custodians {
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_custodians);
  }

  @override
  final int requireConfirmations;
  @override
  final int hours;
  @override
  final WalletType walletType;

  @override
  String toString() {
    return 'WalletDeployState.multisig(custodians: $custodians, requireConfirmations: $requireConfirmations, hours: $hours, walletType: $walletType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultisigImpl &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.walletType, walletType) ||
                other.walletType == walletType));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      hours,
      walletType);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultisigImplCopyWith<_$MultisigImpl> get copyWith =>
      __$$MultisigImplCopyWithImpl<_$MultisigImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return multisig(custodians, requireConfirmations, hours, walletType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return multisig?.call(custodians, requireConfirmations, hours, walletType);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (multisig != null) {
      return multisig(custodians, requireConfirmations, hours, walletType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return multisig(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return multisig?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (multisig != null) {
      return multisig(this);
    }
    return orElse();
  }
}

abstract class _Multisig implements WalletDeployState {
  const factory _Multisig(
      final List<PublicKey> custodians,
      final int requireConfirmations,
      final int hours,
      final WalletType walletType) = _$MultisigImpl;

  List<PublicKey> get custodians;
  int get requireConfirmations;
  int get hours;
  WalletType get walletType;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultisigImplCopyWith<_$MultisigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CalculatingErrorImplCopyWith<$Res> {
  factory _$$CalculatingErrorImplCopyWith(_$CalculatingErrorImpl value,
          $Res Function(_$CalculatingErrorImpl) then) =
      __$$CalculatingErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String error,
      BigInt? fee,
      BigInt? balance,
      List<PublicKey>? custodians,
      int? requireConfirmations,
      String? tonIconPath,
      String? ticker,
      CustomCurrency? currency});

  $CustomCurrencyCopyWith<$Res>? get currency;
}

/// @nodoc
class __$$CalculatingErrorImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$CalculatingErrorImpl>
    implements _$$CalculatingErrorImplCopyWith<$Res> {
  __$$CalculatingErrorImplCopyWithImpl(_$CalculatingErrorImpl _value,
      $Res Function(_$CalculatingErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? fee = freezed,
    Object? balance = freezed,
    Object? custodians = freezed,
    Object? requireConfirmations = freezed,
    Object? tonIconPath = freezed,
    Object? ticker = freezed,
    Object? currency = freezed,
  }) {
    return _then(_$CalculatingErrorImpl(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      custodians: freezed == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
      requireConfirmations: freezed == requireConfirmations
          ? _value.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      tonIconPath: freezed == tonIconPath
          ? _value.tonIconPath
          : tonIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      ticker: freezed == ticker
          ? _value.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as CustomCurrency?,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomCurrencyCopyWith<$Res>? get currency {
    if (_value.currency == null) {
      return null;
    }

    return $CustomCurrencyCopyWith<$Res>(_value.currency!, (value) {
      return _then(_value.copyWith(currency: value));
    });
  }
}

/// @nodoc

class _$CalculatingErrorImpl implements _CalculatingError {
  const _$CalculatingErrorImpl(
      {required this.error,
      this.fee,
      this.balance,
      final List<PublicKey>? custodians,
      this.requireConfirmations,
      this.tonIconPath,
      this.ticker,
      this.currency})
      : _custodians = custodians;

  @override
  final String error;
  @override
  final BigInt? fee;
  @override
  final BigInt? balance;
  final List<PublicKey>? _custodians;
  @override
  List<PublicKey>? get custodians {
    final value = _custodians;
    if (value == null) return null;
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? requireConfirmations;
  @override
  final String? tonIconPath;
  @override
  final String? ticker;
  @override
  final CustomCurrency? currency;

  @override
  String toString() {
    return 'WalletDeployState.calculatingError(error: $error, fee: $fee, balance: $balance, custodians: $custodians, requireConfirmations: $requireConfirmations, tonIconPath: $tonIconPath, ticker: $ticker, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculatingErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.tonIconPath, tonIconPath) ||
                other.tonIconPath == tonIconPath) &&
            (identical(other.ticker, ticker) || other.ticker == ticker) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      error,
      fee,
      balance,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      tonIconPath,
      ticker,
      currency);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CalculatingErrorImplCopyWith<_$CalculatingErrorImpl> get copyWith =>
      __$$CalculatingErrorImplCopyWithImpl<_$CalculatingErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return calculatingError(error, fee, balance, custodians,
        requireConfirmations, tonIconPath, ticker, currency);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return calculatingError?.call(error, fee, balance, custodians,
        requireConfirmations, tonIconPath, ticker, currency);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (calculatingError != null) {
      return calculatingError(error, fee, balance, custodians,
          requireConfirmations, tonIconPath, ticker, currency);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return calculatingError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return calculatingError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (calculatingError != null) {
      return calculatingError(this);
    }
    return orElse();
  }
}

abstract class _CalculatingError implements WalletDeployState {
  const factory _CalculatingError(
      {required final String error,
      final BigInt? fee,
      final BigInt? balance,
      final List<PublicKey>? custodians,
      final int? requireConfirmations,
      final String? tonIconPath,
      final String? ticker,
      final CustomCurrency? currency}) = _$CalculatingErrorImpl;

  String get error;
  BigInt? get fee;
  BigInt? get balance;
  List<PublicKey>? get custodians;
  int? get requireConfirmations;
  String? get tonIconPath;
  String? get ticker;
  CustomCurrency? get currency;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculatingErrorImplCopyWith<_$CalculatingErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReadyToDeployImplCopyWith<$Res> {
  factory _$$ReadyToDeployImplCopyWith(
          _$ReadyToDeployImpl value, $Res Function(_$ReadyToDeployImpl) then) =
      __$$ReadyToDeployImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BigInt fee,
      BigInt balance,
      List<PublicKey>? custodians,
      int? requireConfirmations,
      String? tonIconPath,
      String? ticker,
      CustomCurrency? currency,
      KeyAccount? account,
      int? hours});

  $CustomCurrencyCopyWith<$Res>? get currency;
}

/// @nodoc
class __$$ReadyToDeployImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$ReadyToDeployImpl>
    implements _$$ReadyToDeployImplCopyWith<$Res> {
  __$$ReadyToDeployImplCopyWithImpl(
      _$ReadyToDeployImpl _value, $Res Function(_$ReadyToDeployImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? balance = null,
    Object? custodians = freezed,
    Object? requireConfirmations = freezed,
    Object? tonIconPath = freezed,
    Object? ticker = freezed,
    Object? currency = freezed,
    Object? account = freezed,
    Object? hours = freezed,
  }) {
    return _then(_$ReadyToDeployImpl(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as BigInt,
      custodians: freezed == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
      requireConfirmations: freezed == requireConfirmations
          ? _value.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      tonIconPath: freezed == tonIconPath
          ? _value.tonIconPath
          : tonIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      ticker: freezed == ticker
          ? _value.ticker
          : ticker // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as CustomCurrency?,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount?,
      hours: freezed == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomCurrencyCopyWith<$Res>? get currency {
    if (_value.currency == null) {
      return null;
    }

    return $CustomCurrencyCopyWith<$Res>(_value.currency!, (value) {
      return _then(_value.copyWith(currency: value));
    });
  }
}

/// @nodoc

class _$ReadyToDeployImpl implements _ReadyToDeploy {
  const _$ReadyToDeployImpl(
      {required this.fee,
      required this.balance,
      final List<PublicKey>? custodians,
      this.requireConfirmations,
      this.tonIconPath,
      this.ticker,
      this.currency,
      this.account,
      this.hours})
      : _custodians = custodians;

  @override
  final BigInt fee;
  @override
  final BigInt balance;
  final List<PublicKey>? _custodians;
  @override
  List<PublicKey>? get custodians {
    final value = _custodians;
    if (value == null) return null;
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? requireConfirmations;
  @override
  final String? tonIconPath;
  @override
  final String? ticker;
  @override
  final CustomCurrency? currency;
  @override
  final KeyAccount? account;
  @override
  final int? hours;

  @override
  String toString() {
    return 'WalletDeployState.readyToDeploy(fee: $fee, balance: $balance, custodians: $custodians, requireConfirmations: $requireConfirmations, tonIconPath: $tonIconPath, ticker: $ticker, currency: $currency, account: $account, hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadyToDeployImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.tonIconPath, tonIconPath) ||
                other.tonIconPath == tonIconPath) &&
            (identical(other.ticker, ticker) || other.ticker == ticker) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.hours, hours) || other.hours == hours));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fee,
      balance,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      tonIconPath,
      ticker,
      currency,
      account,
      hours);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadyToDeployImplCopyWith<_$ReadyToDeployImpl> get copyWith =>
      __$$ReadyToDeployImplCopyWithImpl<_$ReadyToDeployImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return readyToDeploy(fee, balance, custodians, requireConfirmations,
        tonIconPath, ticker, currency, account, hours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return readyToDeploy?.call(fee, balance, custodians, requireConfirmations,
        tonIconPath, ticker, currency, account, hours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (readyToDeploy != null) {
      return readyToDeploy(fee, balance, custodians, requireConfirmations,
          tonIconPath, ticker, currency, account, hours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return readyToDeploy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return readyToDeploy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (readyToDeploy != null) {
      return readyToDeploy(this);
    }
    return orElse();
  }
}

abstract class _ReadyToDeploy implements WalletDeployState {
  const factory _ReadyToDeploy(
      {required final BigInt fee,
      required final BigInt balance,
      final List<PublicKey>? custodians,
      final int? requireConfirmations,
      final String? tonIconPath,
      final String? ticker,
      final CustomCurrency? currency,
      final KeyAccount? account,
      final int? hours}) = _$ReadyToDeployImpl;

  BigInt get fee;
  BigInt get balance;
  List<PublicKey>? get custodians;
  int? get requireConfirmations;
  String? get tonIconPath;
  String? get ticker;
  CustomCurrency? get currency;
  KeyAccount? get account;
  int? get hours;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadyToDeployImplCopyWith<_$ReadyToDeployImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeployingImplCopyWith<$Res> {
  factory _$$DeployingImplCopyWith(
          _$DeployingImpl value, $Res Function(_$DeployingImpl) then) =
      __$$DeployingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class __$$DeployingImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$DeployingImpl>
    implements _$$DeployingImplCopyWith<$Res> {
  __$$DeployingImplCopyWithImpl(
      _$DeployingImpl _value, $Res Function(_$DeployingImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canClose = null,
  }) {
    return _then(_$DeployingImpl(
      canClose: null == canClose
          ? _value.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DeployingImpl implements _Deploying {
  const _$DeployingImpl({required this.canClose});

  @override
  final bool canClose;

  @override
  String toString() {
    return 'WalletDeployState.deploying(canClose: $canClose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeployingImpl &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeployingImplCopyWith<_$DeployingImpl> get copyWith =>
      __$$DeployingImplCopyWithImpl<_$DeployingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return deploying(canClose);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return deploying?.call(canClose);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (deploying != null) {
      return deploying(canClose);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return deploying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return deploying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (deploying != null) {
      return deploying(this);
    }
    return orElse();
  }
}

abstract class _Deploying implements WalletDeployState {
  const factory _Deploying({required final bool canClose}) = _$DeployingImpl;

  bool get canClose;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeployingImplCopyWith<_$DeployingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeployedImplCopyWith<$Res> {
  factory _$$DeployedImplCopyWith(
          _$DeployedImpl value, $Res Function(_$DeployedImpl) then) =
      __$$DeployedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {BigInt fee,
      BigInt balance,
      Transaction transaction,
      List<PublicKey>? custodians,
      int? requireConfirmations,
      String? tonIconPath});

  $TransactionCopyWith<$Res> get transaction;
}

/// @nodoc
class __$$DeployedImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$DeployedImpl>
    implements _$$DeployedImplCopyWith<$Res> {
  __$$DeployedImplCopyWithImpl(
      _$DeployedImpl _value, $Res Function(_$DeployedImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? balance = null,
    Object? transaction = null,
    Object? custodians = freezed,
    Object? requireConfirmations = freezed,
    Object? tonIconPath = freezed,
  }) {
    return _then(_$DeployedImpl(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as BigInt,
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
      custodians: freezed == custodians
          ? _value._custodians
          : custodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>?,
      requireConfirmations: freezed == requireConfirmations
          ? _value.requireConfirmations
          : requireConfirmations // ignore: cast_nullable_to_non_nullable
              as int?,
      tonIconPath: freezed == tonIconPath
          ? _value.tonIconPath
          : tonIconPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCopyWith<$Res> get transaction {
    return $TransactionCopyWith<$Res>(_value.transaction, (value) {
      return _then(_value.copyWith(transaction: value));
    });
  }
}

/// @nodoc

class _$DeployedImpl implements _Deployed {
  const _$DeployedImpl(
      {required this.fee,
      required this.balance,
      required this.transaction,
      final List<PublicKey>? custodians,
      this.requireConfirmations,
      this.tonIconPath})
      : _custodians = custodians;

  @override
  final BigInt fee;
  @override
  final BigInt balance;
  @override
  final Transaction transaction;
  final List<PublicKey>? _custodians;
  @override
  List<PublicKey>? get custodians {
    final value = _custodians;
    if (value == null) return null;
    if (_custodians is EqualUnmodifiableListView) return _custodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? requireConfirmations;
  @override
  final String? tonIconPath;

  @override
  String toString() {
    return 'WalletDeployState.deployed(fee: $fee, balance: $balance, transaction: $transaction, custodians: $custodians, requireConfirmations: $requireConfirmations, tonIconPath: $tonIconPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeployedImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            const DeepCollectionEquality()
                .equals(other._custodians, _custodians) &&
            (identical(other.requireConfirmations, requireConfirmations) ||
                other.requireConfirmations == requireConfirmations) &&
            (identical(other.tonIconPath, tonIconPath) ||
                other.tonIconPath == tonIconPath));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      fee,
      balance,
      transaction,
      const DeepCollectionEquality().hash(_custodians),
      requireConfirmations,
      tonIconPath);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeployedImplCopyWith<_$DeployedImpl> get copyWith =>
      __$$DeployedImplCopyWithImpl<_$DeployedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return deployed(fee, balance, transaction, custodians, requireConfirmations,
        tonIconPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return deployed?.call(fee, balance, transaction, custodians,
        requireConfirmations, tonIconPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (deployed != null) {
      return deployed(fee, balance, transaction, custodians,
          requireConfirmations, tonIconPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return deployed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return deployed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (deployed != null) {
      return deployed(this);
    }
    return orElse();
  }
}

abstract class _Deployed implements WalletDeployState {
  const factory _Deployed(
      {required final BigInt fee,
      required final BigInt balance,
      required final Transaction transaction,
      final List<PublicKey>? custodians,
      final int? requireConfirmations,
      final String? tonIconPath}) = _$DeployedImpl;

  BigInt get fee;
  BigInt get balance;
  Transaction get transaction;
  List<PublicKey>? get custodians;
  int? get requireConfirmations;
  String? get tonIconPath;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeployedImplCopyWith<_$DeployedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscribeErrorImplCopyWith<$Res> {
  factory _$$SubscribeErrorImplCopyWith(_$SubscribeErrorImpl value,
          $Res Function(_$SubscribeErrorImpl) then) =
      __$$SubscribeErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error});
}

/// @nodoc
class __$$SubscribeErrorImplCopyWithImpl<$Res>
    extends _$WalletDeployStateCopyWithImpl<$Res, _$SubscribeErrorImpl>
    implements _$$SubscribeErrorImplCopyWith<$Res> {
  __$$SubscribeErrorImplCopyWithImpl(
      _$SubscribeErrorImpl _value, $Res Function(_$SubscribeErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$SubscribeErrorImpl(
      null == error ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$SubscribeErrorImpl implements _SubscribeError {
  const _$SubscribeErrorImpl(this.error);

  @override
  final Object error;

  @override
  String toString() {
    return 'WalletDeployState.subscribeError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscribeErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      __$$SubscribeErrorImplCopyWithImpl<_$SubscribeErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() standard,
    required TResult Function(List<PublicKey> custodians,
            int requireConfirmations, int hours, WalletType walletType)
        multisig,
    required TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)
        calculatingError,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)
        readyToDeploy,
    required TResult Function(bool canClose) deploying,
    required TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)
        deployed,
    required TResult Function(Object error) subscribeError,
  }) {
    return subscribeError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? standard,
    TResult? Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult? Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult? Function(bool canClose)? deploying,
    TResult? Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult? Function(Object error)? subscribeError,
  }) {
    return subscribeError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? standard,
    TResult Function(List<PublicKey> custodians, int requireConfirmations,
            int hours, WalletType walletType)?
        multisig,
    TResult Function(
            String error,
            BigInt? fee,
            BigInt? balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency)?
        calculatingError,
    TResult Function(
            BigInt fee,
            BigInt balance,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath,
            String? ticker,
            CustomCurrency? currency,
            KeyAccount? account,
            int? hours)?
        readyToDeploy,
    TResult Function(bool canClose)? deploying,
    TResult Function(
            BigInt fee,
            BigInt balance,
            Transaction transaction,
            List<PublicKey>? custodians,
            int? requireConfirmations,
            String? tonIconPath)?
        deployed,
    TResult Function(Object error)? subscribeError,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Standard value) standard,
    required TResult Function(_Multisig value) multisig,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_ReadyToDeploy value) readyToDeploy,
    required TResult Function(_Deploying value) deploying,
    required TResult Function(_Deployed value) deployed,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return subscribeError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Standard value)? standard,
    TResult? Function(_Multisig value)? multisig,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_ReadyToDeploy value)? readyToDeploy,
    TResult? Function(_Deploying value)? deploying,
    TResult? Function(_Deployed value)? deployed,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return subscribeError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Standard value)? standard,
    TResult Function(_Multisig value)? multisig,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_ReadyToDeploy value)? readyToDeploy,
    TResult Function(_Deploying value)? deploying,
    TResult Function(_Deployed value)? deployed,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(this);
    }
    return orElse();
  }
}

abstract class _SubscribeError implements WalletDeployState {
  const factory _SubscribeError(final Object error) = _$SubscribeErrorImpl;

  Object get error;

  /// Create a copy of WalletDeployState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
