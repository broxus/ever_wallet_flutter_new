// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_asset_tab_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountAssetTabState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)
        accounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)?
        accounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(TonWalletAsset tonWallet, List<TokenContractAsset>? tokens,
            int? numberNewTokens)?
        accounts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Accounts value) accounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Accounts value)? accounts,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Accounts value)? accounts,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountAssetTabStateCopyWith<$Res> {
  factory $AccountAssetTabStateCopyWith(AccountAssetTabState value,
          $Res Function(AccountAssetTabState) then) =
      _$AccountAssetTabStateCopyWithImpl<$Res, AccountAssetTabState>;
}

/// @nodoc
class _$AccountAssetTabStateCopyWithImpl<$Res,
        $Val extends AccountAssetTabState>
    implements $AccountAssetTabStateCopyWith<$Res> {
  _$AccountAssetTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EmptyImplCopyWith<$Res> {
  factory _$$EmptyImplCopyWith(
          _$EmptyImpl value, $Res Function(_$EmptyImpl) then) =
      __$$EmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyImplCopyWithImpl<$Res>
    extends _$AccountAssetTabStateCopyWithImpl<$Res, _$EmptyImpl>
    implements _$$EmptyImplCopyWith<$Res> {
  __$$EmptyImplCopyWithImpl(
      _$EmptyImpl _value, $Res Function(_$EmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmptyImpl implements _Empty {
  const _$EmptyImpl();

  @override
  String toString() {
    return 'AccountAssetTabState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$EmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)
        accounts,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)?
        accounts,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(TonWalletAsset tonWallet, List<TokenContractAsset>? tokens,
            int? numberNewTokens)?
        accounts,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Accounts value) accounts,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Accounts value)? accounts,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Accounts value)? accounts,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements AccountAssetTabState {
  const factory _Empty() = _$EmptyImpl;
}

/// @nodoc
abstract class _$$AccountsImplCopyWith<$Res> {
  factory _$$AccountsImplCopyWith(
          _$AccountsImpl value, $Res Function(_$AccountsImpl) then) =
      __$$AccountsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {TonWalletAsset tonWallet,
      List<TokenContractAsset>? tokens,
      int? numberNewTokens});

  $TonWalletAssetCopyWith<$Res> get tonWallet;
}

/// @nodoc
class __$$AccountsImplCopyWithImpl<$Res>
    extends _$AccountAssetTabStateCopyWithImpl<$Res, _$AccountsImpl>
    implements _$$AccountsImplCopyWith<$Res> {
  __$$AccountsImplCopyWithImpl(
      _$AccountsImpl _value, $Res Function(_$AccountsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tonWallet = null,
    Object? tokens = freezed,
    Object? numberNewTokens = freezed,
  }) {
    return _then(_$AccountsImpl(
      null == tonWallet
          ? _value.tonWallet
          : tonWallet // ignore: cast_nullable_to_non_nullable
              as TonWalletAsset,
      freezed == tokens
          ? _value._tokens
          : tokens // ignore: cast_nullable_to_non_nullable
              as List<TokenContractAsset>?,
      freezed == numberNewTokens
          ? _value.numberNewTokens
          : numberNewTokens // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TonWalletAssetCopyWith<$Res> get tonWallet {
    return $TonWalletAssetCopyWith<$Res>(_value.tonWallet, (value) {
      return _then(_value.copyWith(tonWallet: value));
    });
  }
}

/// @nodoc

class _$AccountsImpl implements _Accounts {
  const _$AccountsImpl(this.tonWallet, final List<TokenContractAsset>? tokens,
      this.numberNewTokens)
      : _tokens = tokens;

  @override
  final TonWalletAsset tonWallet;
  final List<TokenContractAsset>? _tokens;
  @override
  List<TokenContractAsset>? get tokens {
    final value = _tokens;
    if (value == null) return null;
    if (_tokens is EqualUnmodifiableListView) return _tokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? numberNewTokens;

  @override
  String toString() {
    return 'AccountAssetTabState.accounts(tonWallet: $tonWallet, tokens: $tokens, numberNewTokens: $numberNewTokens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountsImpl &&
            (identical(other.tonWallet, tonWallet) ||
                other.tonWallet == tonWallet) &&
            const DeepCollectionEquality().equals(other._tokens, _tokens) &&
            (identical(other.numberNewTokens, numberNewTokens) ||
                other.numberNewTokens == numberNewTokens));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tonWallet,
      const DeepCollectionEquality().hash(_tokens), numberNewTokens);

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountsImplCopyWith<_$AccountsImpl> get copyWith =>
      __$$AccountsImplCopyWithImpl<_$AccountsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)
        accounts,
  }) {
    return accounts(tonWallet, tokens, numberNewTokens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function(TonWalletAsset tonWallet,
            List<TokenContractAsset>? tokens, int? numberNewTokens)?
        accounts,
  }) {
    return accounts?.call(tonWallet, tokens, numberNewTokens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function(TonWalletAsset tonWallet, List<TokenContractAsset>? tokens,
            int? numberNewTokens)?
        accounts,
    required TResult orElse(),
  }) {
    if (accounts != null) {
      return accounts(tonWallet, tokens, numberNewTokens);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Accounts value) accounts,
  }) {
    return accounts(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Accounts value)? accounts,
  }) {
    return accounts?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Accounts value)? accounts,
    required TResult orElse(),
  }) {
    if (accounts != null) {
      return accounts(this);
    }
    return orElse();
  }
}

abstract class _Accounts implements AccountAssetTabState {
  const factory _Accounts(
      final TonWalletAsset tonWallet,
      final List<TokenContractAsset>? tokens,
      final int? numberNewTokens) = _$AccountsImpl;

  TonWalletAsset get tonWallet;
  List<TokenContractAsset>? get tokens;
  int? get numberNewTokens;

  /// Create a copy of AccountAssetTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountsImplCopyWith<_$AccountsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
