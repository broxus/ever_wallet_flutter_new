// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_send_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TonWalletSendEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(String password) send,
    required TResult Function() allowCloseSend,
    required TResult Function(Transaction transaction) completeSend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(String password)? send,
    TResult? Function()? allowCloseSend,
    TResult? Function(Transaction transaction)? completeSend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(String password)? send,
    TResult Function()? allowCloseSend,
    TResult Function(Transaction transaction)? completeSend,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Prepare value) prepare,
    required TResult Function(_Send value) send,
    required TResult Function(_AllowCloseSend value) allowCloseSend,
    required TResult Function(_CompleteSend value) completeSend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Prepare value)? prepare,
    TResult? Function(_Send value)? send,
    TResult? Function(_AllowCloseSend value)? allowCloseSend,
    TResult? Function(_CompleteSend value)? completeSend,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Prepare value)? prepare,
    TResult Function(_Send value)? send,
    TResult Function(_AllowCloseSend value)? allowCloseSend,
    TResult Function(_CompleteSend value)? completeSend,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonWalletSendEventCopyWith<$Res> {
  factory $TonWalletSendEventCopyWith(
          TonWalletSendEvent value, $Res Function(TonWalletSendEvent) then) =
      _$TonWalletSendEventCopyWithImpl<$Res, TonWalletSendEvent>;
}

/// @nodoc
class _$TonWalletSendEventCopyWithImpl<$Res, $Val extends TonWalletSendEvent>
    implements $TonWalletSendEventCopyWith<$Res> {
  _$TonWalletSendEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PrepareImplCopyWith<$Res> {
  factory _$$PrepareImplCopyWith(
          _$PrepareImpl value, $Res Function(_$PrepareImpl) then) =
      __$$PrepareImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PrepareImplCopyWithImpl<$Res>
    extends _$TonWalletSendEventCopyWithImpl<$Res, _$PrepareImpl>
    implements _$$PrepareImplCopyWith<$Res> {
  __$$PrepareImplCopyWithImpl(
      _$PrepareImpl _value, $Res Function(_$PrepareImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PrepareImpl implements _Prepare {
  const _$PrepareImpl();

  @override
  String toString() {
    return 'TonWalletSendEvent.prepare()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PrepareImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(String password) send,
    required TResult Function() allowCloseSend,
    required TResult Function(Transaction transaction) completeSend,
  }) {
    return prepare();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(String password)? send,
    TResult? Function()? allowCloseSend,
    TResult? Function(Transaction transaction)? completeSend,
  }) {
    return prepare?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(String password)? send,
    TResult Function()? allowCloseSend,
    TResult Function(Transaction transaction)? completeSend,
    required TResult orElse(),
  }) {
    if (prepare != null) {
      return prepare();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Prepare value) prepare,
    required TResult Function(_Send value) send,
    required TResult Function(_AllowCloseSend value) allowCloseSend,
    required TResult Function(_CompleteSend value) completeSend,
  }) {
    return prepare(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Prepare value)? prepare,
    TResult? Function(_Send value)? send,
    TResult? Function(_AllowCloseSend value)? allowCloseSend,
    TResult? Function(_CompleteSend value)? completeSend,
  }) {
    return prepare?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Prepare value)? prepare,
    TResult Function(_Send value)? send,
    TResult Function(_AllowCloseSend value)? allowCloseSend,
    TResult Function(_CompleteSend value)? completeSend,
    required TResult orElse(),
  }) {
    if (prepare != null) {
      return prepare(this);
    }
    return orElse();
  }
}

abstract class _Prepare implements TonWalletSendEvent {
  const factory _Prepare() = _$PrepareImpl;
}

/// @nodoc
abstract class _$$SendImplCopyWith<$Res> {
  factory _$$SendImplCopyWith(
          _$SendImpl value, $Res Function(_$SendImpl) then) =
      __$$SendImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String password});
}

/// @nodoc
class __$$SendImplCopyWithImpl<$Res>
    extends _$TonWalletSendEventCopyWithImpl<$Res, _$SendImpl>
    implements _$$SendImplCopyWith<$Res> {
  __$$SendImplCopyWithImpl(_$SendImpl _value, $Res Function(_$SendImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? password = null,
  }) {
    return _then(_$SendImpl(
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SendImpl implements _Send {
  const _$SendImpl(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'TonWalletSendEvent.send(password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendImpl &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, password);

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendImplCopyWith<_$SendImpl> get copyWith =>
      __$$SendImplCopyWithImpl<_$SendImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(String password) send,
    required TResult Function() allowCloseSend,
    required TResult Function(Transaction transaction) completeSend,
  }) {
    return send(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(String password)? send,
    TResult? Function()? allowCloseSend,
    TResult? Function(Transaction transaction)? completeSend,
  }) {
    return send?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(String password)? send,
    TResult Function()? allowCloseSend,
    TResult Function(Transaction transaction)? completeSend,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Prepare value) prepare,
    required TResult Function(_Send value) send,
    required TResult Function(_AllowCloseSend value) allowCloseSend,
    required TResult Function(_CompleteSend value) completeSend,
  }) {
    return send(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Prepare value)? prepare,
    TResult? Function(_Send value)? send,
    TResult? Function(_AllowCloseSend value)? allowCloseSend,
    TResult? Function(_CompleteSend value)? completeSend,
  }) {
    return send?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Prepare value)? prepare,
    TResult Function(_Send value)? send,
    TResult Function(_AllowCloseSend value)? allowCloseSend,
    TResult Function(_CompleteSend value)? completeSend,
    required TResult orElse(),
  }) {
    if (send != null) {
      return send(this);
    }
    return orElse();
  }
}

abstract class _Send implements TonWalletSendEvent {
  const factory _Send(final String password) = _$SendImpl;

  String get password;

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendImplCopyWith<_$SendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AllowCloseSendImplCopyWith<$Res> {
  factory _$$AllowCloseSendImplCopyWith(_$AllowCloseSendImpl value,
          $Res Function(_$AllowCloseSendImpl) then) =
      __$$AllowCloseSendImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllowCloseSendImplCopyWithImpl<$Res>
    extends _$TonWalletSendEventCopyWithImpl<$Res, _$AllowCloseSendImpl>
    implements _$$AllowCloseSendImplCopyWith<$Res> {
  __$$AllowCloseSendImplCopyWithImpl(
      _$AllowCloseSendImpl _value, $Res Function(_$AllowCloseSendImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllowCloseSendImpl implements _AllowCloseSend {
  const _$AllowCloseSendImpl();

  @override
  String toString() {
    return 'TonWalletSendEvent.allowCloseSend()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AllowCloseSendImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(String password) send,
    required TResult Function() allowCloseSend,
    required TResult Function(Transaction transaction) completeSend,
  }) {
    return allowCloseSend();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(String password)? send,
    TResult? Function()? allowCloseSend,
    TResult? Function(Transaction transaction)? completeSend,
  }) {
    return allowCloseSend?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(String password)? send,
    TResult Function()? allowCloseSend,
    TResult Function(Transaction transaction)? completeSend,
    required TResult orElse(),
  }) {
    if (allowCloseSend != null) {
      return allowCloseSend();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Prepare value) prepare,
    required TResult Function(_Send value) send,
    required TResult Function(_AllowCloseSend value) allowCloseSend,
    required TResult Function(_CompleteSend value) completeSend,
  }) {
    return allowCloseSend(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Prepare value)? prepare,
    TResult? Function(_Send value)? send,
    TResult? Function(_AllowCloseSend value)? allowCloseSend,
    TResult? Function(_CompleteSend value)? completeSend,
  }) {
    return allowCloseSend?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Prepare value)? prepare,
    TResult Function(_Send value)? send,
    TResult Function(_AllowCloseSend value)? allowCloseSend,
    TResult Function(_CompleteSend value)? completeSend,
    required TResult orElse(),
  }) {
    if (allowCloseSend != null) {
      return allowCloseSend(this);
    }
    return orElse();
  }
}

abstract class _AllowCloseSend implements TonWalletSendEvent {
  const factory _AllowCloseSend() = _$AllowCloseSendImpl;
}

/// @nodoc
abstract class _$$CompleteSendImplCopyWith<$Res> {
  factory _$$CompleteSendImplCopyWith(
          _$CompleteSendImpl value, $Res Function(_$CompleteSendImpl) then) =
      __$$CompleteSendImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Transaction transaction});
}

/// @nodoc
class __$$CompleteSendImplCopyWithImpl<$Res>
    extends _$TonWalletSendEventCopyWithImpl<$Res, _$CompleteSendImpl>
    implements _$$CompleteSendImplCopyWith<$Res> {
  __$$CompleteSendImplCopyWithImpl(
      _$CompleteSendImpl _value, $Res Function(_$CompleteSendImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = freezed,
  }) {
    return _then(_$CompleteSendImpl(
      freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
    ));
  }
}

/// @nodoc

class _$CompleteSendImpl implements _CompleteSend {
  const _$CompleteSendImpl(this.transaction);

  @override
  final Transaction transaction;

  @override
  String toString() {
    return 'TonWalletSendEvent.completeSend(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompleteSendImpl &&
            const DeepCollectionEquality()
                .equals(other.transaction, transaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(transaction));

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompleteSendImplCopyWith<_$CompleteSendImpl> get copyWith =>
      __$$CompleteSendImplCopyWithImpl<_$CompleteSendImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() prepare,
    required TResult Function(String password) send,
    required TResult Function() allowCloseSend,
    required TResult Function(Transaction transaction) completeSend,
  }) {
    return completeSend(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? prepare,
    TResult? Function(String password)? send,
    TResult? Function()? allowCloseSend,
    TResult? Function(Transaction transaction)? completeSend,
  }) {
    return completeSend?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? prepare,
    TResult Function(String password)? send,
    TResult Function()? allowCloseSend,
    TResult Function(Transaction transaction)? completeSend,
    required TResult orElse(),
  }) {
    if (completeSend != null) {
      return completeSend(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Prepare value) prepare,
    required TResult Function(_Send value) send,
    required TResult Function(_AllowCloseSend value) allowCloseSend,
    required TResult Function(_CompleteSend value) completeSend,
  }) {
    return completeSend(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Prepare value)? prepare,
    TResult? Function(_Send value)? send,
    TResult? Function(_AllowCloseSend value)? allowCloseSend,
    TResult? Function(_CompleteSend value)? completeSend,
  }) {
    return completeSend?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Prepare value)? prepare,
    TResult Function(_Send value)? send,
    TResult Function(_AllowCloseSend value)? allowCloseSend,
    TResult Function(_CompleteSend value)? completeSend,
    required TResult orElse(),
  }) {
    if (completeSend != null) {
      return completeSend(this);
    }
    return orElse();
  }
}

abstract class _CompleteSend implements TonWalletSendEvent {
  const factory _CompleteSend(final Transaction transaction) =
      _$CompleteSendImpl;

  Transaction get transaction;

  /// Create a copy of TonWalletSendEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompleteSendImplCopyWith<_$CompleteSendImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TonWalletSendState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonWalletSendStateCopyWith<$Res> {
  factory $TonWalletSendStateCopyWith(
          TonWalletSendState value, $Res Function(TonWalletSendState) then) =
      _$TonWalletSendStateCopyWithImpl<$Res, TonWalletSendState>;
}

/// @nodoc
class _$TonWalletSendStateCopyWithImpl<$Res, $Val extends TonWalletSendState>
    implements $TonWalletSendStateCopyWith<$Res> {
  _$TonWalletSendStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TonWalletSendState
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
    extends _$TonWalletSendStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'TonWalletSendState.loading()';
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
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
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
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements TonWalletSendState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$CalculatingErrorImplCopyWith<$Res> {
  factory _$$CalculatingErrorImplCopyWith(_$CalculatingErrorImpl value,
          $Res Function(_$CalculatingErrorImpl) then) =
      __$$CalculatingErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error, BigInt? fee});
}

/// @nodoc
class __$$CalculatingErrorImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res, _$CalculatingErrorImpl>
    implements _$$CalculatingErrorImplCopyWith<$Res> {
  __$$CalculatingErrorImplCopyWithImpl(_$CalculatingErrorImpl _value,
      $Res Function(_$CalculatingErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? fee = freezed,
  }) {
    return _then(_$CalculatingErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ));
  }
}

/// @nodoc

class _$CalculatingErrorImpl implements _CalculatingError {
  const _$CalculatingErrorImpl(this.error, [this.fee]);

  @override
  final String error;
  @override
  final BigInt? fee;

  @override
  String toString() {
    return 'TonWalletSendState.calculatingError(error: $error, fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalculatingErrorImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error, fee);

  /// Create a copy of TonWalletSendState
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
    required TResult Function() loading,
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) {
    return calculatingError(error, fee);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) {
    return calculatingError?.call(error, fee);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
    required TResult orElse(),
  }) {
    if (calculatingError != null) {
      return calculatingError(error, fee);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) {
    return calculatingError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) {
    return calculatingError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) {
    if (calculatingError != null) {
      return calculatingError(this);
    }
    return orElse();
  }
}

abstract class _CalculatingError implements TonWalletSendState {
  const factory _CalculatingError(final String error, [final BigInt? fee]) =
      _$CalculatingErrorImpl;

  String get error;
  BigInt? get fee;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CalculatingErrorImplCopyWith<_$CalculatingErrorImpl> get copyWith =>
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
    extends _$TonWalletSendStateCopyWithImpl<$Res, _$SubscribeErrorImpl>
    implements _$$SubscribeErrorImplCopyWith<$Res> {
  __$$SubscribeErrorImplCopyWithImpl(
      _$SubscribeErrorImpl _value, $Res Function(_$SubscribeErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
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
    return 'TonWalletSendState.subscribeError(error: $error)';
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

  /// Create a copy of TonWalletSendState
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
    required TResult Function() loading,
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) {
    return subscribeError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) {
    return subscribeError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) {
    return subscribeError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) {
    return subscribeError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(this);
    }
    return orElse();
  }
}

abstract class _SubscribeError implements TonWalletSendState {
  const factory _SubscribeError(final Object error) = _$SubscribeErrorImpl;

  Object get error;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ReadyImplCopyWith<$Res> {
  factory _$$ReadyImplCopyWith(
          _$ReadyImpl value, $Res Function(_$ReadyImpl) then) =
      __$$ReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BigInt fee, List<TxTreeSimulationErrorItem>? txErrors});
}

/// @nodoc
class __$$ReadyImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res, _$ReadyImpl>
    implements _$$ReadyImplCopyWith<$Res> {
  __$$ReadyImplCopyWithImpl(
      _$ReadyImpl _value, $Res Function(_$ReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? txErrors = freezed,
  }) {
    return _then(_$ReadyImpl(
      null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      freezed == txErrors
          ? _value._txErrors
          : txErrors // ignore: cast_nullable_to_non_nullable
              as List<TxTreeSimulationErrorItem>?,
    ));
  }
}

/// @nodoc

class _$ReadyImpl implements _Ready {
  const _$ReadyImpl(this.fee, final List<TxTreeSimulationErrorItem>? txErrors)
      : _txErrors = txErrors;

  @override
  final BigInt fee;
  final List<TxTreeSimulationErrorItem>? _txErrors;
  @override
  List<TxTreeSimulationErrorItem>? get txErrors {
    final value = _txErrors;
    if (value == null) return null;
    if (_txErrors is EqualUnmodifiableListView) return _txErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TonWalletSendState.readyToSend(fee: $fee, txErrors: $txErrors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReadyImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            const DeepCollectionEquality().equals(other._txErrors, _txErrors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fee, const DeepCollectionEquality().hash(_txErrors));

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReadyImplCopyWith<_$ReadyImpl> get copyWith =>
      __$$ReadyImplCopyWithImpl<_$ReadyImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) {
    return readyToSend(fee, txErrors);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) {
    return readyToSend?.call(fee, txErrors);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
    required TResult orElse(),
  }) {
    if (readyToSend != null) {
      return readyToSend(fee, txErrors);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) {
    return readyToSend(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) {
    return readyToSend?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) {
    if (readyToSend != null) {
      return readyToSend(this);
    }
    return orElse();
  }
}

abstract class _Ready implements TonWalletSendState {
  const factory _Ready(
          final BigInt fee, final List<TxTreeSimulationErrorItem>? txErrors) =
      _$ReadyImpl;

  BigInt get fee;
  List<TxTreeSimulationErrorItem>? get txErrors;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReadyImplCopyWith<_$ReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendingImplCopyWith<$Res> {
  factory _$$SendingImplCopyWith(
          _$SendingImpl value, $Res Function(_$SendingImpl) then) =
      __$$SendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool canClose});
}

/// @nodoc
class __$$SendingImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res, _$SendingImpl>
    implements _$$SendingImplCopyWith<$Res> {
  __$$SendingImplCopyWithImpl(
      _$SendingImpl _value, $Res Function(_$SendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canClose = null,
  }) {
    return _then(_$SendingImpl(
      canClose: null == canClose
          ? _value.canClose
          : canClose // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SendingImpl implements _Sending {
  const _$SendingImpl({required this.canClose});

  @override
  final bool canClose;

  @override
  String toString() {
    return 'TonWalletSendState.sending(canClose: $canClose)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendingImpl &&
            (identical(other.canClose, canClose) ||
                other.canClose == canClose));
  }

  @override
  int get hashCode => Object.hash(runtimeType, canClose);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendingImplCopyWith<_$SendingImpl> get copyWith =>
      __$$SendingImplCopyWithImpl<_$SendingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) {
    return sending(canClose);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) {
    return sending?.call(canClose);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(canClose);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) {
    return sending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) {
    return sending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) {
    if (sending != null) {
      return sending(this);
    }
    return orElse();
  }
}

abstract class _Sending implements TonWalletSendState {
  const factory _Sending({required final bool canClose}) = _$SendingImpl;

  bool get canClose;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendingImplCopyWith<_$SendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SentImplCopyWith<$Res> {
  factory _$$SentImplCopyWith(
          _$SentImpl value, $Res Function(_$SentImpl) then) =
      __$$SentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BigInt fee, Transaction transaction});
}

/// @nodoc
class __$$SentImplCopyWithImpl<$Res>
    extends _$TonWalletSendStateCopyWithImpl<$Res, _$SentImpl>
    implements _$$SentImplCopyWith<$Res> {
  __$$SentImplCopyWithImpl(_$SentImpl _value, $Res Function(_$SentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? transaction = freezed,
  }) {
    return _then(_$SentImpl(
      null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as BigInt,
      freezed == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as Transaction,
    ));
  }
}

/// @nodoc

class _$SentImpl implements _Sent {
  const _$SentImpl(this.fee, this.transaction);

  @override
  final BigInt fee;
  @override
  final Transaction transaction;

  @override
  String toString() {
    return 'TonWalletSendState.sent(fee: $fee, transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SentImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            const DeepCollectionEquality()
                .equals(other.transaction, transaction));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fee, const DeepCollectionEquality().hash(transaction));

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SentImplCopyWith<_$SentImpl> get copyWith =>
      __$$SentImplCopyWithImpl<_$SentImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(String error, BigInt? fee) calculatingError,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)
        readyToSend,
    required TResult Function(bool canClose) sending,
    required TResult Function(BigInt fee, Transaction transaction) sent,
  }) {
    return sent(fee, transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(String error, BigInt? fee)? calculatingError,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult? Function(bool canClose)? sending,
    TResult? Function(BigInt fee, Transaction transaction)? sent,
  }) {
    return sent?.call(fee, transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(String error, BigInt? fee)? calculatingError,
    TResult Function(Object error)? subscribeError,
    TResult Function(BigInt fee, List<TxTreeSimulationErrorItem>? txErrors)?
        readyToSend,
    TResult Function(bool canClose)? sending,
    TResult Function(BigInt fee, Transaction transaction)? sent,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(fee, transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_CalculatingError value) calculatingError,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Ready value) readyToSend,
    required TResult Function(_Sending value) sending,
    required TResult Function(_Sent value) sent,
  }) {
    return sent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_CalculatingError value)? calculatingError,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Ready value)? readyToSend,
    TResult? Function(_Sending value)? sending,
    TResult? Function(_Sent value)? sent,
  }) {
    return sent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_CalculatingError value)? calculatingError,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Ready value)? readyToSend,
    TResult Function(_Sending value)? sending,
    TResult Function(_Sent value)? sent,
    required TResult orElse(),
  }) {
    if (sent != null) {
      return sent(this);
    }
    return orElse();
  }
}

abstract class _Sent implements TonWalletSendState {
  const factory _Sent(final BigInt fee, final Transaction transaction) =
      _$SentImpl;

  BigInt get fee;
  Transaction get transaction;

  /// Create a copy of TonWalletSendState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SentImplCopyWith<_$SentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
