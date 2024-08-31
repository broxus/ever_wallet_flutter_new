// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton_wallet_asset_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TonWalletAssetState {
  String get tokenName => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tokenName, String iconPath,
            Money? fiatBalance, Money? tokenBalance)
        data,
    required TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)
        subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult? Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
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

  @JsonKey(ignore: true)
  $TonWalletAssetStateCopyWith<TonWalletAssetState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TonWalletAssetStateCopyWith<$Res> {
  factory $TonWalletAssetStateCopyWith(
          TonWalletAssetState value, $Res Function(TonWalletAssetState) then) =
      _$TonWalletAssetStateCopyWithImpl<$Res, TonWalletAssetState>;
  @useResult
  $Res call({String tokenName, String iconPath});
}

/// @nodoc
class _$TonWalletAssetStateCopyWithImpl<$Res, $Val extends TonWalletAssetState>
    implements $TonWalletAssetStateCopyWith<$Res> {
  _$TonWalletAssetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenName = null,
    Object? iconPath = null,
  }) {
    return _then(_value.copyWith(
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res>
    implements $TonWalletAssetStateCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String tokenName,
      String iconPath,
      Money? fiatBalance,
      Money? tokenBalance});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$TonWalletAssetStateCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenName = null,
    Object? iconPath = null,
    Object? fiatBalance = freezed,
    Object? tokenBalance = freezed,
  }) {
    return _then(_$DataImpl(
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String,
      fiatBalance: freezed == fiatBalance
          ? _value.fiatBalance
          : fiatBalance // ignore: cast_nullable_to_non_nullable
              as Money?,
      tokenBalance: freezed == tokenBalance
          ? _value.tokenBalance
          : tokenBalance // ignore: cast_nullable_to_non_nullable
              as Money?,
    ));
  }
}

/// @nodoc

class _$DataImpl implements _Data {
  const _$DataImpl(
      {required this.tokenName,
      required this.iconPath,
      this.fiatBalance,
      this.tokenBalance});

  @override
  final String tokenName;
  @override
  final String iconPath;
  @override
  final Money? fiatBalance;
  @override
  final Money? tokenBalance;

  @override
  String toString() {
    return 'TonWalletAssetState.data(tokenName: $tokenName, iconPath: $iconPath, fiatBalance: $fiatBalance, tokenBalance: $tokenBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, tokenName, iconPath, fiatBalance, tokenBalance);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tokenName, String iconPath,
            Money? fiatBalance, Money? tokenBalance)
        data,
    required TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)
        subscribeError,
  }) {
    return data(tokenName, iconPath, fiatBalance, tokenBalance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult? Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
  }) {
    return data?.call(tokenName, iconPath, fiatBalance, tokenBalance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(tokenName, iconPath, fiatBalance, tokenBalance);
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

abstract class _Data implements TonWalletAssetState {
  const factory _Data(
      {required final String tokenName,
      required final String iconPath,
      final Money? fiatBalance,
      final Money? tokenBalance}) = _$DataImpl;

  @override
  String get tokenName;
  @override
  String get iconPath;
  Money? get fiatBalance;
  Money? get tokenBalance;
  @override
  @JsonKey(ignore: true)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscribeErrorImplCopyWith<$Res>
    implements $TonWalletAssetStateCopyWith<$Res> {
  factory _$$SubscribeErrorImplCopyWith(_$SubscribeErrorImpl value,
          $Res Function(_$SubscribeErrorImpl) then) =
      __$$SubscribeErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String tokenName, String iconPath, Object error, bool isLoading});
}

/// @nodoc
class __$$SubscribeErrorImplCopyWithImpl<$Res>
    extends _$TonWalletAssetStateCopyWithImpl<$Res, _$SubscribeErrorImpl>
    implements _$$SubscribeErrorImplCopyWith<$Res> {
  __$$SubscribeErrorImplCopyWithImpl(
      _$SubscribeErrorImpl _value, $Res Function(_$SubscribeErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tokenName = null,
    Object? iconPath = null,
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(_$SubscribeErrorImpl(
      tokenName: null == tokenName
          ? _value.tokenName
          : tokenName // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: null == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
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
      {required this.tokenName,
      required this.iconPath,
      required this.error,
      required this.isLoading});

  @override
  final String tokenName;
  @override
  final String iconPath;
  @override
  final Object error;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'TonWalletAssetState.subscribeError(tokenName: $tokenName, iconPath: $iconPath, error: $error, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscribeErrorImpl &&
            (identical(other.tokenName, tokenName) ||
                other.tokenName == tokenName) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tokenName, iconPath,
      const DeepCollectionEquality().hash(error), isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      __$$SubscribeErrorImplCopyWithImpl<_$SubscribeErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String tokenName, String iconPath,
            Money? fiatBalance, Money? tokenBalance)
        data,
    required TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)
        subscribeError,
  }) {
    return subscribeError(tokenName, iconPath, error, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult? Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
  }) {
    return subscribeError?.call(tokenName, iconPath, error, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String tokenName, String iconPath, Money? fiatBalance,
            Money? tokenBalance)?
        data,
    TResult Function(
            String tokenName, String iconPath, Object error, bool isLoading)?
        subscribeError,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(tokenName, iconPath, error, isLoading);
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

abstract class _SubscribeError implements TonWalletAssetState {
  const factory _SubscribeError(
      {required final String tokenName,
      required final String iconPath,
      required final Object error,
      required final bool isLoading}) = _$SubscribeErrorImpl;

  @override
  String get tokenName;
  @override
  String get iconPath;
  Object get error;
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
