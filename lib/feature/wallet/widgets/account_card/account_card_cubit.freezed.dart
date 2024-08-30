// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_card_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountCardState {
  KeyAccount get account =>
      throw _privateConstructorUsedError; // name of WalletType
  String get walletName => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KeyAccount account, String walletName,
            Money? balance, String? custodiansString)
        data,
    required TResult Function(
            KeyAccount account, String walletName, Object error, bool isLoading)
        subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KeyAccount account, String walletName, Money? balance,
            String? custodiansString)?
        data,
    TResult? Function(KeyAccount account, String walletName, Object error,
            bool isLoading)?
        subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KeyAccount account, String walletName, Money? balance,
            String? custodiansString)?
        data,
    TResult Function(KeyAccount account, String walletName, Object error,
            bool isLoading)?
        subscribeError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data value) data,
    required TResult Function(_SubscribeError value) subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data value)? data,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data value)? data,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountCardStateCopyWith<AccountCardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountCardStateCopyWith<$Res> {
  factory $AccountCardStateCopyWith(
          AccountCardState value, $Res Function(AccountCardState) then) =
      _$AccountCardStateCopyWithImpl<$Res, AccountCardState>;
  @useResult
  $Res call({KeyAccount account, String walletName});
}

/// @nodoc
class _$AccountCardStateCopyWithImpl<$Res, $Val extends AccountCardState>
    implements $AccountCardStateCopyWith<$Res> {
  _$AccountCardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? walletName = null,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res>
    implements $AccountCardStateCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {KeyAccount account,
      String walletName,
      Money? balance,
      String? custodiansString});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$AccountCardStateCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? walletName = null,
    Object? balance = freezed,
    Object? custodiansString = freezed,
  }) {
    return _then(_$DataImpl(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
      balance: freezed == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as Money?,
      custodiansString: freezed == custodiansString
          ? _value.custodiansString
          : custodiansString // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DataImpl implements _Data {
  const _$DataImpl(
      {required this.account,
      required this.walletName,
      this.balance,
      this.custodiansString});

  @override
  final KeyAccount account;
// name of WalletType
  @override
  final String walletName;
  @override
  final Money? balance;
  @override
  final String? custodiansString;

  @override
  String toString() {
    return 'AccountCardState.data(account: $account, walletName: $walletName, balance: $balance, custodiansString: $custodiansString)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.custodiansString, custodiansString) ||
                other.custodiansString == custodiansString));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, account, walletName, balance, custodiansString);

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(KeyAccount account, String walletName,
            Money? balance, String? custodiansString)
        data,
    required TResult Function(
            KeyAccount account, String walletName, Object error, bool isLoading)
        subscribeError,
  }) {
    return data(account, walletName, balance, custodiansString);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KeyAccount account, String walletName, Money? balance,
            String? custodiansString)?
        data,
    TResult? Function(KeyAccount account, String walletName, Object error,
            bool isLoading)?
        subscribeError,
  }) {
    return data?.call(account, walletName, balance, custodiansString);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KeyAccount account, String walletName, Money? balance,
            String? custodiansString)?
        data,
    TResult Function(KeyAccount account, String walletName, Object error,
            bool isLoading)?
        subscribeError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(account, walletName, balance, custodiansString);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data value) data,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data value)? data,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data value)? data,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data implements AccountCardState {
  const factory _Data(
      {required final KeyAccount account,
      required final String walletName,
      final Money? balance,
      final String? custodiansString}) = _$DataImpl;

  @override
  KeyAccount get account; // name of WalletType
  @override
  String get walletName;
  Money? get balance;
  String? get custodiansString;

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscribeErrorImplCopyWith<$Res>
    implements $AccountCardStateCopyWith<$Res> {
  factory _$$SubscribeErrorImplCopyWith(_$SubscribeErrorImpl value,
          $Res Function(_$SubscribeErrorImpl) then) =
      __$$SubscribeErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {KeyAccount account, String walletName, Object error, bool isLoading});
}

/// @nodoc
class __$$SubscribeErrorImplCopyWithImpl<$Res>
    extends _$AccountCardStateCopyWithImpl<$Res, _$SubscribeErrorImpl>
    implements _$$SubscribeErrorImplCopyWith<$Res> {
  __$$SubscribeErrorImplCopyWithImpl(
      _$SubscribeErrorImpl _value, $Res Function(_$SubscribeErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
    Object? walletName = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(_$SubscribeErrorImpl(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error ? _value.error : error,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SubscribeErrorImpl implements _SubscribeError {
  const _$SubscribeErrorImpl(
      {required this.account,
      required this.walletName,
      required this.error,
      required this.isLoading});

  @override
  final KeyAccount account;
// name of WalletType
  @override
  final String walletName;
  @override
  final Object error;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'AccountCardState.subscribeError(account: $account, walletName: $walletName, error: $error, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscribeErrorImpl &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account, walletName,
      const DeepCollectionEquality().hash(error), isLoading);

  /// Create a copy of AccountCardState
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
    required TResult Function(KeyAccount account, String walletName,
            Money? balance, String? custodiansString)
        data,
    required TResult Function(
            KeyAccount account, String walletName, Object error, bool isLoading)
        subscribeError,
  }) {
    return subscribeError(account, walletName, error, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(KeyAccount account, String walletName, Money? balance,
            String? custodiansString)?
        data,
    TResult? Function(KeyAccount account, String walletName, Object error,
            bool isLoading)?
        subscribeError,
  }) {
    return subscribeError?.call(account, walletName, error, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(KeyAccount account, String walletName, Money? balance,
            String? custodiansString)?
        data,
    TResult Function(KeyAccount account, String walletName, Object error,
            bool isLoading)?
        subscribeError,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(account, walletName, error, isLoading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data value) data,
    required TResult Function(_SubscribeError value) subscribeError,
  }) {
    return subscribeError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data value)? data,
    TResult? Function(_SubscribeError value)? subscribeError,
  }) {
    return subscribeError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data value)? data,
    TResult Function(_SubscribeError value)? subscribeError,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(this);
    }
    return orElse();
  }
}

abstract class _SubscribeError implements AccountCardState {
  const factory _SubscribeError(
      {required final KeyAccount account,
      required final String walletName,
      required final Object error,
      required final bool isLoading}) = _$SubscribeErrorImpl;

  @override
  KeyAccount get account; // name of WalletType
  @override
  String get walletName;
  Object get error;
  bool get isLoading;

  /// Create a copy of AccountCardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
