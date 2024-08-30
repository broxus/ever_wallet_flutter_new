// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_wallet_asset_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TokenWalletAssetState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Money? fiatBalance, Money? tokenBalance) data,
    required TResult Function(Object error, bool isLoading) subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Money? fiatBalance, Money? tokenBalance)? data,
    TResult? Function(Object error, bool isLoading)? subscribeError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Money? fiatBalance, Money? tokenBalance)? data,
    TResult Function(Object error, bool isLoading)? subscribeError,
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
}

/// @nodoc
abstract class $TokenWalletAssetStateCopyWith<$Res> {
  factory $TokenWalletAssetStateCopyWith(TokenWalletAssetState value,
          $Res Function(TokenWalletAssetState) then) =
      _$TokenWalletAssetStateCopyWithImpl<$Res, TokenWalletAssetState>;
}

/// @nodoc
class _$TokenWalletAssetStateCopyWithImpl<$Res,
        $Val extends TokenWalletAssetState>
    implements $TokenWalletAssetStateCopyWith<$Res> {
  _$TokenWalletAssetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Money? fiatBalance, Money? tokenBalance});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$TokenWalletAssetStateCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fiatBalance = freezed,
    Object? tokenBalance = freezed,
  }) {
    return _then(_$DataImpl(
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
  const _$DataImpl({this.fiatBalance, this.tokenBalance});

  @override
  final Money? fiatBalance;
  @override
  final Money? tokenBalance;

  @override
  String toString() {
    return 'TokenWalletAssetState.data(fiatBalance: $fiatBalance, tokenBalance: $tokenBalance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.fiatBalance, fiatBalance) ||
                other.fiatBalance == fiatBalance) &&
            (identical(other.tokenBalance, tokenBalance) ||
                other.tokenBalance == tokenBalance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fiatBalance, tokenBalance);

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Money? fiatBalance, Money? tokenBalance) data,
    required TResult Function(Object error, bool isLoading) subscribeError,
  }) {
    return data(fiatBalance, tokenBalance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Money? fiatBalance, Money? tokenBalance)? data,
    TResult? Function(Object error, bool isLoading)? subscribeError,
  }) {
    return data?.call(fiatBalance, tokenBalance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Money? fiatBalance, Money? tokenBalance)? data,
    TResult Function(Object error, bool isLoading)? subscribeError,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(fiatBalance, tokenBalance);
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

abstract class _Data implements TokenWalletAssetState {
  const factory _Data({final Money? fiatBalance, final Money? tokenBalance}) =
      _$DataImpl;

  Money? get fiatBalance;
  Money? get tokenBalance;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubscribeErrorImplCopyWith<$Res> {
  factory _$$SubscribeErrorImplCopyWith(_$SubscribeErrorImpl value,
          $Res Function(_$SubscribeErrorImpl) then) =
      __$$SubscribeErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object error, bool isLoading});
}

/// @nodoc
class __$$SubscribeErrorImplCopyWithImpl<$Res>
    extends _$TokenWalletAssetStateCopyWithImpl<$Res, _$SubscribeErrorImpl>
    implements _$$SubscribeErrorImplCopyWith<$Res> {
  __$$SubscribeErrorImplCopyWithImpl(
      _$SubscribeErrorImpl _value, $Res Function(_$SubscribeErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? isLoading = null,
  }) {
    return _then(_$SubscribeErrorImpl(
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
  const _$SubscribeErrorImpl({required this.error, required this.isLoading});

  @override
  final Object error;
  @override
  final bool isLoading;

  @override
  String toString() {
    return 'TokenWalletAssetState.subscribeError(error: $error, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscribeErrorImpl &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(error), isLoading);

  /// Create a copy of TokenWalletAssetState
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
    required TResult Function(Money? fiatBalance, Money? tokenBalance) data,
    required TResult Function(Object error, bool isLoading) subscribeError,
  }) {
    return subscribeError(error, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Money? fiatBalance, Money? tokenBalance)? data,
    TResult? Function(Object error, bool isLoading)? subscribeError,
  }) {
    return subscribeError?.call(error, isLoading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Money? fiatBalance, Money? tokenBalance)? data,
    TResult Function(Object error, bool isLoading)? subscribeError,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(error, isLoading);
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

abstract class _SubscribeError implements TokenWalletAssetState {
  const factory _SubscribeError(
      {required final Object error,
      required final bool isLoading}) = _$SubscribeErrorImpl;

  Object get error;
  bool get isLoading;

  /// Create a copy of TokenWalletAssetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
