// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'action_staking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ActionStakingBlocEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(BigInt amount, PublicKey accountKey) stake,
    required TResult Function(
            BigInt amount, PublicKey accountKey, int withdrawHours)
        unstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(BigInt amount, PublicKey accountKey)? stake,
    TResult? Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(BigInt amount, PublicKey accountKey)? stake,
    TResult Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_Stake value) stake,
    required TResult Function(_Unstake value) unstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Init value)? init,
    TResult? Function(_Stake value)? stake,
    TResult? Function(_Unstake value)? unstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_Stake value)? stake,
    TResult Function(_Unstake value)? unstake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionStakingBlocEventCopyWith<$Res> {
  factory $ActionStakingBlocEventCopyWith(ActionStakingBlocEvent value,
          $Res Function(ActionStakingBlocEvent) then) =
      _$ActionStakingBlocEventCopyWithImpl<$Res, ActionStakingBlocEvent>;
}

/// @nodoc
class _$ActionStakingBlocEventCopyWithImpl<$Res,
        $Val extends ActionStakingBlocEvent>
    implements $ActionStakingBlocEventCopyWith<$Res> {
  _$ActionStakingBlocEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitImplCopyWith<$Res> {
  factory _$$InitImplCopyWith(
          _$InitImpl value, $Res Function(_$InitImpl) then) =
      __$$InitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocEventCopyWithImpl<$Res, _$InitImpl>
    implements _$$InitImplCopyWith<$Res> {
  __$$InitImplCopyWithImpl(_$InitImpl _value, $Res Function(_$InitImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitImpl implements _Init {
  const _$InitImpl();

  @override
  String toString() {
    return 'ActionStakingBlocEvent.init()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(BigInt amount, PublicKey accountKey) stake,
    required TResult Function(
            BigInt amount, PublicKey accountKey, int withdrawHours)
        unstake,
  }) {
    return init();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(BigInt amount, PublicKey accountKey)? stake,
    TResult? Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
  }) {
    return init?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(BigInt amount, PublicKey accountKey)? stake,
    TResult Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_Stake value) stake,
    required TResult Function(_Unstake value) unstake,
  }) {
    return init(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Init value)? init,
    TResult? Function(_Stake value)? stake,
    TResult? Function(_Unstake value)? unstake,
  }) {
    return init?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_Stake value)? stake,
    TResult Function(_Unstake value)? unstake,
    required TResult orElse(),
  }) {
    if (init != null) {
      return init(this);
    }
    return orElse();
  }
}

abstract class _Init implements ActionStakingBlocEvent {
  const factory _Init() = _$InitImpl;
}

/// @nodoc
abstract class _$$StakeImplCopyWith<$Res> {
  factory _$$StakeImplCopyWith(
          _$StakeImpl value, $Res Function(_$StakeImpl) then) =
      __$$StakeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BigInt amount, PublicKey accountKey});

  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class __$$StakeImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocEventCopyWithImpl<$Res, _$StakeImpl>
    implements _$$StakeImplCopyWith<$Res> {
  __$$StakeImplCopyWithImpl(
      _$StakeImpl _value, $Res Function(_$StakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? accountKey = null,
  }) {
    return _then(_$StakeImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
    ));
  }

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_value.accountKey, (value) {
      return _then(_value.copyWith(accountKey: value));
    });
  }
}

/// @nodoc

class _$StakeImpl implements _Stake {
  const _$StakeImpl({required this.amount, required this.accountKey});

// in native tokens
  @override
  final BigInt amount;
  @override
  final PublicKey accountKey;

  @override
  String toString() {
    return 'ActionStakingBlocEvent.stake(amount: $amount, accountKey: $accountKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StakeImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, amount, accountKey);

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StakeImplCopyWith<_$StakeImpl> get copyWith =>
      __$$StakeImplCopyWithImpl<_$StakeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(BigInt amount, PublicKey accountKey) stake,
    required TResult Function(
            BigInt amount, PublicKey accountKey, int withdrawHours)
        unstake,
  }) {
    return stake(amount, accountKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(BigInt amount, PublicKey accountKey)? stake,
    TResult? Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
  }) {
    return stake?.call(amount, accountKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(BigInt amount, PublicKey accountKey)? stake,
    TResult Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
    required TResult orElse(),
  }) {
    if (stake != null) {
      return stake(amount, accountKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_Stake value) stake,
    required TResult Function(_Unstake value) unstake,
  }) {
    return stake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Init value)? init,
    TResult? Function(_Stake value)? stake,
    TResult? Function(_Unstake value)? unstake,
  }) {
    return stake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_Stake value)? stake,
    TResult Function(_Unstake value)? unstake,
    required TResult orElse(),
  }) {
    if (stake != null) {
      return stake(this);
    }
    return orElse();
  }
}

abstract class _Stake implements ActionStakingBlocEvent {
  const factory _Stake(
      {required final BigInt amount,
      required final PublicKey accountKey}) = _$StakeImpl;

// in native tokens
  BigInt get amount;
  PublicKey get accountKey;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StakeImplCopyWith<_$StakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnstakeImplCopyWith<$Res> {
  factory _$$UnstakeImplCopyWith(
          _$UnstakeImpl value, $Res Function(_$UnstakeImpl) then) =
      __$$UnstakeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BigInt amount, PublicKey accountKey, int withdrawHours});

  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class __$$UnstakeImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocEventCopyWithImpl<$Res, _$UnstakeImpl>
    implements _$$UnstakeImplCopyWith<$Res> {
  __$$UnstakeImplCopyWithImpl(
      _$UnstakeImpl _value, $Res Function(_$UnstakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? accountKey = null,
    Object? withdrawHours = null,
  }) {
    return _then(_$UnstakeImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      withdrawHours: null == withdrawHours
          ? _value.withdrawHours
          : withdrawHours // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_value.accountKey, (value) {
      return _then(_value.copyWith(accountKey: value));
    });
  }
}

/// @nodoc

class _$UnstakeImpl implements _Unstake {
  const _$UnstakeImpl(
      {required this.amount,
      required this.accountKey,
      required this.withdrawHours});

// in staking tokens
  @override
  final BigInt amount;
  @override
  final PublicKey accountKey;
  @override
  final int withdrawHours;

  @override
  String toString() {
    return 'ActionStakingBlocEvent.unstake(amount: $amount, accountKey: $accountKey, withdrawHours: $withdrawHours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnstakeImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.withdrawHours, withdrawHours) ||
                other.withdrawHours == withdrawHours));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, amount, accountKey, withdrawHours);

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnstakeImplCopyWith<_$UnstakeImpl> get copyWith =>
      __$$UnstakeImplCopyWithImpl<_$UnstakeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function(BigInt amount, PublicKey accountKey) stake,
    required TResult Function(
            BigInt amount, PublicKey accountKey, int withdrawHours)
        unstake,
  }) {
    return unstake(amount, accountKey, withdrawHours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function(BigInt amount, PublicKey accountKey)? stake,
    TResult? Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
  }) {
    return unstake?.call(amount, accountKey, withdrawHours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function(BigInt amount, PublicKey accountKey)? stake,
    TResult Function(BigInt amount, PublicKey accountKey, int withdrawHours)?
        unstake,
    required TResult orElse(),
  }) {
    if (unstake != null) {
      return unstake(amount, accountKey, withdrawHours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_Stake value) stake,
    required TResult Function(_Unstake value) unstake,
  }) {
    return unstake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Init value)? init,
    TResult? Function(_Stake value)? stake,
    TResult? Function(_Unstake value)? unstake,
  }) {
    return unstake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_Stake value)? stake,
    TResult Function(_Unstake value)? unstake,
    required TResult orElse(),
  }) {
    if (unstake != null) {
      return unstake(this);
    }
    return orElse();
  }
}

abstract class _Unstake implements ActionStakingBlocEvent {
  const factory _Unstake(
      {required final BigInt amount,
      required final PublicKey accountKey,
      required final int withdrawHours}) = _$UnstakeImpl;

// in staking tokens
  BigInt get amount;
  PublicKey get accountKey;
  int get withdrawHours;

  /// Create a copy of ActionStakingBlocEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnstakeImplCopyWith<_$UnstakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActionStakingBlocState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() nothing,
    required TResult Function() inProgress,
    required TResult Function() showHowItWorksSheet,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee)
        goStake,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)
        goUnstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? nothing,
    TResult? Function()? inProgress,
    TResult? Function()? showHowItWorksSheet,
    TResult? Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult? Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? nothing,
    TResult Function()? inProgress,
    TResult Function()? showHowItWorksSheet,
    TResult Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Nothing value) nothing,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_ShowHowItWorks value) showHowItWorksSheet,
    required TResult Function(_GoStake value) goStake,
    required TResult Function(_GoUnstake value) goUnstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Nothing value)? nothing,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult? Function(_GoStake value)? goStake,
    TResult? Function(_GoUnstake value)? goUnstake,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Nothing value)? nothing,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult Function(_GoStake value)? goStake,
    TResult Function(_GoUnstake value)? goUnstake,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActionStakingBlocStateCopyWith<$Res> {
  factory $ActionStakingBlocStateCopyWith(ActionStakingBlocState value,
          $Res Function(ActionStakingBlocState) then) =
      _$ActionStakingBlocStateCopyWithImpl<$Res, ActionStakingBlocState>;
}

/// @nodoc
class _$ActionStakingBlocStateCopyWithImpl<$Res,
        $Val extends ActionStakingBlocState>
    implements $ActionStakingBlocStateCopyWith<$Res> {
  _$ActionStakingBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NothingImplCopyWith<$Res> {
  factory _$$NothingImplCopyWith(
          _$NothingImpl value, $Res Function(_$NothingImpl) then) =
      __$$NothingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NothingImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocStateCopyWithImpl<$Res, _$NothingImpl>
    implements _$$NothingImplCopyWith<$Res> {
  __$$NothingImplCopyWithImpl(
      _$NothingImpl _value, $Res Function(_$NothingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NothingImpl implements _Nothing {
  const _$NothingImpl();

  @override
  String toString() {
    return 'ActionStakingBlocState.nothing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NothingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() nothing,
    required TResult Function() inProgress,
    required TResult Function() showHowItWorksSheet,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee)
        goStake,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)
        goUnstake,
  }) {
    return nothing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? nothing,
    TResult? Function()? inProgress,
    TResult? Function()? showHowItWorksSheet,
    TResult? Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult? Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
  }) {
    return nothing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? nothing,
    TResult Function()? inProgress,
    TResult Function()? showHowItWorksSheet,
    TResult Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
    required TResult orElse(),
  }) {
    if (nothing != null) {
      return nothing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Nothing value) nothing,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_ShowHowItWorks value) showHowItWorksSheet,
    required TResult Function(_GoStake value) goStake,
    required TResult Function(_GoUnstake value) goUnstake,
  }) {
    return nothing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Nothing value)? nothing,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult? Function(_GoStake value)? goStake,
    TResult? Function(_GoUnstake value)? goUnstake,
  }) {
    return nothing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Nothing value)? nothing,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult Function(_GoStake value)? goStake,
    TResult Function(_GoUnstake value)? goUnstake,
    required TResult orElse(),
  }) {
    if (nothing != null) {
      return nothing(this);
    }
    return orElse();
  }
}

abstract class _Nothing implements ActionStakingBlocState {
  const factory _Nothing() = _$NothingImpl;
}

/// @nodoc
abstract class _$$InProgressImplCopyWith<$Res> {
  factory _$$InProgressImplCopyWith(
          _$InProgressImpl value, $Res Function(_$InProgressImpl) then) =
      __$$InProgressImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InProgressImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocStateCopyWithImpl<$Res, _$InProgressImpl>
    implements _$$InProgressImplCopyWith<$Res> {
  __$$InProgressImplCopyWithImpl(
      _$InProgressImpl _value, $Res Function(_$InProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InProgressImpl implements _InProgress {
  const _$InProgressImpl();

  @override
  String toString() {
    return 'ActionStakingBlocState.inProgress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InProgressImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() nothing,
    required TResult Function() inProgress,
    required TResult Function() showHowItWorksSheet,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee)
        goStake,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)
        goUnstake,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? nothing,
    TResult? Function()? inProgress,
    TResult? Function()? showHowItWorksSheet,
    TResult? Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult? Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
  }) {
    return inProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? nothing,
    TResult Function()? inProgress,
    TResult Function()? showHowItWorksSheet,
    TResult Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Nothing value) nothing,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_ShowHowItWorks value) showHowItWorksSheet,
    required TResult Function(_GoStake value) goStake,
    required TResult Function(_GoUnstake value) goUnstake,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Nothing value)? nothing,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult? Function(_GoStake value)? goStake,
    TResult? Function(_GoUnstake value)? goUnstake,
  }) {
    return inProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Nothing value)? nothing,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult Function(_GoStake value)? goStake,
    TResult Function(_GoUnstake value)? goUnstake,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements ActionStakingBlocState {
  const factory _InProgress() = _$InProgressImpl;
}

/// @nodoc
abstract class _$$ShowHowItWorksImplCopyWith<$Res> {
  factory _$$ShowHowItWorksImplCopyWith(_$ShowHowItWorksImpl value,
          $Res Function(_$ShowHowItWorksImpl) then) =
      __$$ShowHowItWorksImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ShowHowItWorksImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocStateCopyWithImpl<$Res, _$ShowHowItWorksImpl>
    implements _$$ShowHowItWorksImplCopyWith<$Res> {
  __$$ShowHowItWorksImplCopyWithImpl(
      _$ShowHowItWorksImpl _value, $Res Function(_$ShowHowItWorksImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ShowHowItWorksImpl implements _ShowHowItWorks {
  const _$ShowHowItWorksImpl();

  @override
  String toString() {
    return 'ActionStakingBlocState.showHowItWorksSheet()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ShowHowItWorksImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() nothing,
    required TResult Function() inProgress,
    required TResult Function() showHowItWorksSheet,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee)
        goStake,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)
        goUnstake,
  }) {
    return showHowItWorksSheet();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? nothing,
    TResult? Function()? inProgress,
    TResult? Function()? showHowItWorksSheet,
    TResult? Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult? Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
  }) {
    return showHowItWorksSheet?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? nothing,
    TResult Function()? inProgress,
    TResult Function()? showHowItWorksSheet,
    TResult Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
    required TResult orElse(),
  }) {
    if (showHowItWorksSheet != null) {
      return showHowItWorksSheet();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Nothing value) nothing,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_ShowHowItWorks value) showHowItWorksSheet,
    required TResult Function(_GoStake value) goStake,
    required TResult Function(_GoUnstake value) goUnstake,
  }) {
    return showHowItWorksSheet(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Nothing value)? nothing,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult? Function(_GoStake value)? goStake,
    TResult? Function(_GoUnstake value)? goUnstake,
  }) {
    return showHowItWorksSheet?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Nothing value)? nothing,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult Function(_GoStake value)? goStake,
    TResult Function(_GoUnstake value)? goUnstake,
    required TResult orElse(),
  }) {
    if (showHowItWorksSheet != null) {
      return showHowItWorksSheet(this);
    }
    return orElse();
  }
}

abstract class _ShowHowItWorks implements ActionStakingBlocState {
  const factory _ShowHowItWorks() = _$ShowHowItWorksImpl;
}

/// @nodoc
abstract class _$$GoStakeImplCopyWith<$Res> {
  factory _$$GoStakeImplCopyWith(
          _$GoStakeImpl value, $Res Function(_$GoStakeImpl) then) =
      __$$GoStakeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String payload,
      BigInt amount,
      Address destination,
      Address sender,
      PublicKey accountKey,
      BigInt attachedFee});

  $AddressCopyWith<$Res> get destination;
  $AddressCopyWith<$Res> get sender;
  $PublicKeyCopyWith<$Res> get accountKey;
}

/// @nodoc
class __$$GoStakeImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocStateCopyWithImpl<$Res, _$GoStakeImpl>
    implements _$$GoStakeImplCopyWith<$Res> {
  __$$GoStakeImplCopyWithImpl(
      _$GoStakeImpl _value, $Res Function(_$GoStakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
    Object? amount = null,
    Object? destination = null,
    Object? sender = null,
    Object? accountKey = null,
    Object? attachedFee = null,
  }) {
    return _then(_$GoStakeImpl(
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Address,
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      attachedFee: null == attachedFee
          ? _value.attachedFee
          : attachedFee // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get sender {
    return $AddressCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_value.accountKey, (value) {
      return _then(_value.copyWith(accountKey: value));
    });
  }
}

/// @nodoc

class _$GoStakeImpl implements _GoStake {
  const _$GoStakeImpl(
      {required this.payload,
      required this.amount,
      required this.destination,
      required this.sender,
      required this.accountKey,
      required this.attachedFee});

  @override
  final String payload;
// amount in native tokens
  @override
  final BigInt amount;
  @override
  final Address destination;
  @override
  final Address sender;
  @override
  final PublicKey accountKey;
  @override
  final BigInt attachedFee;

  @override
  String toString() {
    return 'ActionStakingBlocState.goStake(payload: $payload, amount: $amount, destination: $destination, sender: $sender, accountKey: $accountKey, attachedFee: $attachedFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoStakeImpl &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.attachedFee, attachedFee) ||
                other.attachedFee == attachedFee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payload, amount, destination,
      sender, accountKey, attachedFee);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoStakeImplCopyWith<_$GoStakeImpl> get copyWith =>
      __$$GoStakeImplCopyWithImpl<_$GoStakeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() nothing,
    required TResult Function() inProgress,
    required TResult Function() showHowItWorksSheet,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee)
        goStake,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)
        goUnstake,
  }) {
    return goStake(
        payload, amount, destination, sender, accountKey, attachedFee);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? nothing,
    TResult? Function()? inProgress,
    TResult? Function()? showHowItWorksSheet,
    TResult? Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult? Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
  }) {
    return goStake?.call(
        payload, amount, destination, sender, accountKey, attachedFee);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? nothing,
    TResult Function()? inProgress,
    TResult Function()? showHowItWorksSheet,
    TResult Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
    required TResult orElse(),
  }) {
    if (goStake != null) {
      return goStake(
          payload, amount, destination, sender, accountKey, attachedFee);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Nothing value) nothing,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_ShowHowItWorks value) showHowItWorksSheet,
    required TResult Function(_GoStake value) goStake,
    required TResult Function(_GoUnstake value) goUnstake,
  }) {
    return goStake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Nothing value)? nothing,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult? Function(_GoStake value)? goStake,
    TResult? Function(_GoUnstake value)? goUnstake,
  }) {
    return goStake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Nothing value)? nothing,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult Function(_GoStake value)? goStake,
    TResult Function(_GoUnstake value)? goUnstake,
    required TResult orElse(),
  }) {
    if (goStake != null) {
      return goStake(this);
    }
    return orElse();
  }
}

abstract class _GoStake implements ActionStakingBlocState {
  const factory _GoStake(
      {required final String payload,
      required final BigInt amount,
      required final Address destination,
      required final Address sender,
      required final PublicKey accountKey,
      required final BigInt attachedFee}) = _$GoStakeImpl;

  String get payload; // amount in native tokens
  BigInt get amount;
  Address get destination;
  Address get sender;
  PublicKey get accountKey;
  BigInt get attachedFee;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoStakeImplCopyWith<_$GoStakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GoUnstakeImplCopyWith<$Res> {
  factory _$$GoUnstakeImplCopyWith(
          _$GoUnstakeImpl value, $Res Function(_$GoUnstakeImpl) then) =
      __$$GoUnstakeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String payload,
      BigInt amount,
      Address destination,
      Address sender,
      PublicKey accountKey,
      BigInt attachedFee,
      int withdrawHours,
      Address stakeContractAddress});

  $AddressCopyWith<$Res> get destination;
  $AddressCopyWith<$Res> get sender;
  $PublicKeyCopyWith<$Res> get accountKey;
  $AddressCopyWith<$Res> get stakeContractAddress;
}

/// @nodoc
class __$$GoUnstakeImplCopyWithImpl<$Res>
    extends _$ActionStakingBlocStateCopyWithImpl<$Res, _$GoUnstakeImpl>
    implements _$$GoUnstakeImplCopyWith<$Res> {
  __$$GoUnstakeImplCopyWithImpl(
      _$GoUnstakeImpl _value, $Res Function(_$GoUnstakeImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payload = null,
    Object? amount = null,
    Object? destination = null,
    Object? sender = null,
    Object? accountKey = null,
    Object? attachedFee = null,
    Object? withdrawHours = null,
    Object? stakeContractAddress = null,
  }) {
    return _then(_$GoUnstakeImpl(
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      destination: null == destination
          ? _value.destination
          : destination // ignore: cast_nullable_to_non_nullable
              as Address,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Address,
      accountKey: null == accountKey
          ? _value.accountKey
          : accountKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      attachedFee: null == attachedFee
          ? _value.attachedFee
          : attachedFee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      withdrawHours: null == withdrawHours
          ? _value.withdrawHours
          : withdrawHours // ignore: cast_nullable_to_non_nullable
              as int,
      stakeContractAddress: null == stakeContractAddress
          ? _value.stakeContractAddress
          : stakeContractAddress // ignore: cast_nullable_to_non_nullable
              as Address,
    ));
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get destination {
    return $AddressCopyWith<$Res>(_value.destination, (value) {
      return _then(_value.copyWith(destination: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get sender {
    return $AddressCopyWith<$Res>(_value.sender, (value) {
      return _then(_value.copyWith(sender: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get accountKey {
    return $PublicKeyCopyWith<$Res>(_value.accountKey, (value) {
      return _then(_value.copyWith(accountKey: value));
    });
  }

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res> get stakeContractAddress {
    return $AddressCopyWith<$Res>(_value.stakeContractAddress, (value) {
      return _then(_value.copyWith(stakeContractAddress: value));
    });
  }
}

/// @nodoc

class _$GoUnstakeImpl implements _GoUnstake {
  const _$GoUnstakeImpl(
      {required this.payload,
      required this.amount,
      required this.destination,
      required this.sender,
      required this.accountKey,
      required this.attachedFee,
      required this.withdrawHours,
      required this.stakeContractAddress});

  @override
  final String payload;
// amount in staking tokens
  @override
  final BigInt amount;
  @override
  final Address destination;
  @override
  final Address sender;
  @override
  final PublicKey accountKey;
  @override
  final BigInt attachedFee;
  @override
  final int withdrawHours;
  @override
  final Address stakeContractAddress;

  @override
  String toString() {
    return 'ActionStakingBlocState.goUnstake(payload: $payload, amount: $amount, destination: $destination, sender: $sender, accountKey: $accountKey, attachedFee: $attachedFee, withdrawHours: $withdrawHours, stakeContractAddress: $stakeContractAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoUnstakeImpl &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.destination, destination) ||
                other.destination == destination) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.accountKey, accountKey) ||
                other.accountKey == accountKey) &&
            (identical(other.attachedFee, attachedFee) ||
                other.attachedFee == attachedFee) &&
            (identical(other.withdrawHours, withdrawHours) ||
                other.withdrawHours == withdrawHours) &&
            (identical(other.stakeContractAddress, stakeContractAddress) ||
                other.stakeContractAddress == stakeContractAddress));
  }

  @override
  int get hashCode => Object.hash(runtimeType, payload, amount, destination,
      sender, accountKey, attachedFee, withdrawHours, stakeContractAddress);

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoUnstakeImplCopyWith<_$GoUnstakeImpl> get copyWith =>
      __$$GoUnstakeImplCopyWithImpl<_$GoUnstakeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() nothing,
    required TResult Function() inProgress,
    required TResult Function() showHowItWorksSheet,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee)
        goStake,
    required TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)
        goUnstake,
  }) {
    return goUnstake(payload, amount, destination, sender, accountKey,
        attachedFee, withdrawHours, stakeContractAddress);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? nothing,
    TResult? Function()? inProgress,
    TResult? Function()? showHowItWorksSheet,
    TResult? Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult? Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
  }) {
    return goUnstake?.call(payload, amount, destination, sender, accountKey,
        attachedFee, withdrawHours, stakeContractAddress);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? nothing,
    TResult Function()? inProgress,
    TResult Function()? showHowItWorksSheet,
    TResult Function(String payload, BigInt amount, Address destination,
            Address sender, PublicKey accountKey, BigInt attachedFee)?
        goStake,
    TResult Function(
            String payload,
            BigInt amount,
            Address destination,
            Address sender,
            PublicKey accountKey,
            BigInt attachedFee,
            int withdrawHours,
            Address stakeContractAddress)?
        goUnstake,
    required TResult orElse(),
  }) {
    if (goUnstake != null) {
      return goUnstake(payload, amount, destination, sender, accountKey,
          attachedFee, withdrawHours, stakeContractAddress);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Nothing value) nothing,
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_ShowHowItWorks value) showHowItWorksSheet,
    required TResult Function(_GoStake value) goStake,
    required TResult Function(_GoUnstake value) goUnstake,
  }) {
    return goUnstake(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Nothing value)? nothing,
    TResult? Function(_InProgress value)? inProgress,
    TResult? Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult? Function(_GoStake value)? goStake,
    TResult? Function(_GoUnstake value)? goUnstake,
  }) {
    return goUnstake?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Nothing value)? nothing,
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_ShowHowItWorks value)? showHowItWorksSheet,
    TResult Function(_GoStake value)? goStake,
    TResult Function(_GoUnstake value)? goUnstake,
    required TResult orElse(),
  }) {
    if (goUnstake != null) {
      return goUnstake(this);
    }
    return orElse();
  }
}

abstract class _GoUnstake implements ActionStakingBlocState {
  const factory _GoUnstake(
      {required final String payload,
      required final BigInt amount,
      required final Address destination,
      required final Address sender,
      required final PublicKey accountKey,
      required final BigInt attachedFee,
      required final int withdrawHours,
      required final Address stakeContractAddress}) = _$GoUnstakeImpl;

  String get payload; // amount in staking tokens
  BigInt get amount;
  Address get destination;
  Address get sender;
  PublicKey get accountKey;
  BigInt get attachedFee;
  int get withdrawHours;
  Address get stakeContractAddress;

  /// Create a copy of ActionStakingBlocState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoUnstakeImplCopyWith<_$GoUnstakeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
