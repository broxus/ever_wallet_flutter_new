// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_prepare_transfer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletPrepareTransferState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)
        data,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)
        goNext,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Object error)? subscribeError,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Data value) data,
    required TResult Function(_GoNext value) goNext,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Data value)? data,
    TResult? Function(_GoNext value)? goNext,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Data value)? data,
    TResult Function(_GoNext value)? goNext,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletPrepareTransferStateCopyWith<$Res> {
  factory $WalletPrepareTransferStateCopyWith(WalletPrepareTransferState value,
          $Res Function(WalletPrepareTransferState) then) =
      _$WalletPrepareTransferStateCopyWithImpl<$Res,
          WalletPrepareTransferState>;
}

/// @nodoc
class _$WalletPrepareTransferStateCopyWithImpl<$Res,
        $Val extends WalletPrepareTransferState>
    implements $WalletPrepareTransferStateCopyWith<$Res> {
  _$WalletPrepareTransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WalletPrepareTransferState
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
    extends _$WalletPrepareTransferStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'WalletPrepareTransferState.loading()';
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
    required TResult Function() empty,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)
        data,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)
        goNext,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Object error)? subscribeError,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
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
    required TResult Function(_Empty value) empty,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Data value) data,
    required TResult Function(_GoNext value) goNext,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Data value)? data,
    TResult? Function(_GoNext value)? goNext,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Data value)? data,
    TResult Function(_GoNext value)? goNext,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements WalletPrepareTransferState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$EmptyImplCopyWith<$Res> {
  factory _$$EmptyImplCopyWith(
          _$EmptyImpl value, $Res Function(_$EmptyImpl) then) =
      __$$EmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmptyImplCopyWithImpl<$Res>
    extends _$WalletPrepareTransferStateCopyWithImpl<$Res, _$EmptyImpl>
    implements _$$EmptyImplCopyWith<$Res> {
  __$$EmptyImplCopyWithImpl(
      _$EmptyImpl _value, $Res Function(_$EmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmptyImpl implements _Empty {
  const _$EmptyImpl();

  @override
  String toString() {
    return 'WalletPrepareTransferState.empty()';
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
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)
        data,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)
        goNext,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Object error)? subscribeError,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Data value) data,
    required TResult Function(_GoNext value) goNext,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Data value)? data,
    TResult? Function(_GoNext value)? goNext,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Data value)? data,
    TResult Function(_GoNext value)? goNext,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements WalletPrepareTransferState {
  const factory _Empty() = _$EmptyImpl;
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
    extends _$WalletPrepareTransferStateCopyWithImpl<$Res, _$SubscribeErrorImpl>
    implements _$$SubscribeErrorImplCopyWith<$Res> {
  __$$SubscribeErrorImplCopyWithImpl(
      _$SubscribeErrorImpl _value, $Res Function(_$SubscribeErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferState
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
    return 'WalletPrepareTransferState.subscribeError(error: $error)';
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

  /// Create a copy of WalletPrepareTransferState
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
    required TResult Function() empty,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)
        data,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)
        goNext,
  }) {
    return subscribeError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
  }) {
    return subscribeError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Object error)? subscribeError,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
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
    required TResult Function(_Empty value) empty,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Data value) data,
    required TResult Function(_GoNext value) goNext,
  }) {
    return subscribeError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Data value)? data,
    TResult? Function(_GoNext value)? goNext,
  }) {
    return subscribeError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Data value)? data,
    TResult Function(_GoNext value)? goNext,
    required TResult orElse(),
  }) {
    if (subscribeError != null) {
      return subscribeError(this);
    }
    return orElse();
  }
}

abstract class _SubscribeError implements WalletPrepareTransferState {
  const factory _SubscribeError(final Object error) = _$SubscribeErrorImpl;

  Object get error;

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeErrorImplCopyWith<_$SubscribeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String walletName,
      KeyAccount account,
      PublicKey selectedCustodian,
      List<PublicKey> localCustodians,
      WalletPrepareTransferAsset selectedAsset,
      List<WalletPrepareTransferAsset> assets});

  $PublicKeyCopyWith<$Res> get selectedCustodian;
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$WalletPrepareTransferStateCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletName = null,
    Object? account = null,
    Object? selectedCustodian = null,
    Object? localCustodians = null,
    Object? selectedAsset = null,
    Object? assets = null,
  }) {
    return _then(_$DataImpl(
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      selectedCustodian: null == selectedCustodian
          ? _value.selectedCustodian
          : selectedCustodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      localCustodians: null == localCustodians
          ? _value._localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      selectedAsset: null == selectedAsset
          ? _value.selectedAsset
          : selectedAsset // ignore: cast_nullable_to_non_nullable
              as WalletPrepareTransferAsset,
      assets: null == assets
          ? _value._assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<WalletPrepareTransferAsset>,
    ));
  }

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get selectedCustodian {
    return $PublicKeyCopyWith<$Res>(_value.selectedCustodian, (value) {
      return _then(_value.copyWith(selectedCustodian: value));
    });
  }
}

/// @nodoc

class _$DataImpl implements _Data {
  const _$DataImpl(
      {required this.walletName,
      required this.account,
      required this.selectedCustodian,
      required final List<PublicKey> localCustodians,
      required this.selectedAsset,
      required final List<WalletPrepareTransferAsset> assets})
      : _localCustodians = localCustodians,
        _assets = assets;

  @override
  final String walletName;
  @override
  final KeyAccount account;
  @override
  final PublicKey selectedCustodian;
  final List<PublicKey> _localCustodians;
  @override
  List<PublicKey> get localCustodians {
    if (_localCustodians is EqualUnmodifiableListView) return _localCustodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localCustodians);
  }

  @override
  final WalletPrepareTransferAsset selectedAsset;
  final List<WalletPrepareTransferAsset> _assets;
  @override
  List<WalletPrepareTransferAsset> get assets {
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assets);
  }

  @override
  String toString() {
    return 'WalletPrepareTransferState.data(walletName: $walletName, account: $account, selectedCustodian: $selectedCustodian, localCustodians: $localCustodians, selectedAsset: $selectedAsset, assets: $assets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.selectedCustodian, selectedCustodian) ||
                other.selectedCustodian == selectedCustodian) &&
            const DeepCollectionEquality()
                .equals(other._localCustodians, _localCustodians) &&
            (identical(other.selectedAsset, selectedAsset) ||
                other.selectedAsset == selectedAsset) &&
            const DeepCollectionEquality().equals(other._assets, _assets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      walletName,
      account,
      selectedCustodian,
      const DeepCollectionEquality().hash(_localCustodians),
      selectedAsset,
      const DeepCollectionEquality().hash(_assets));

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)
        data,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)
        goNext,
  }) {
    return data(walletName, account, selectedCustodian, localCustodians,
        selectedAsset, assets);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
  }) {
    return data?.call(walletName, account, selectedCustodian, localCustodians,
        selectedAsset, assets);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Object error)? subscribeError,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(walletName, account, selectedCustodian, localCustodians,
          selectedAsset, assets);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Data value) data,
    required TResult Function(_GoNext value) goNext,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Data value)? data,
    TResult? Function(_GoNext value)? goNext,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Data value)? data,
    TResult Function(_GoNext value)? goNext,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data implements WalletPrepareTransferState {
  const factory _Data(
      {required final String walletName,
      required final KeyAccount account,
      required final PublicKey selectedCustodian,
      required final List<PublicKey> localCustodians,
      required final WalletPrepareTransferAsset selectedAsset,
      required final List<WalletPrepareTransferAsset> assets}) = _$DataImpl;

  String get walletName;
  KeyAccount get account;
  PublicKey get selectedCustodian;
  List<PublicKey> get localCustodians;
  WalletPrepareTransferAsset get selectedAsset;
  List<WalletPrepareTransferAsset> get assets;

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GoNextImplCopyWith<$Res> {
  factory _$$GoNextImplCopyWith(
          _$GoNextImpl value, $Res Function(_$GoNextImpl) then) =
      __$$GoNextImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String walletName,
      KeyAccount account,
      PublicKey selectedCustodian,
      List<PublicKey> localCustodians,
      WalletPrepareTransferAsset selectedAsset,
      List<WalletPrepareTransferAsset> assets,
      Address receiveAddress,
      Fixed amount,
      String? comment});

  $PublicKeyCopyWith<$Res> get selectedCustodian;
}

/// @nodoc
class __$$GoNextImplCopyWithImpl<$Res>
    extends _$WalletPrepareTransferStateCopyWithImpl<$Res, _$GoNextImpl>
    implements _$$GoNextImplCopyWith<$Res> {
  __$$GoNextImplCopyWithImpl(
      _$GoNextImpl _value, $Res Function(_$GoNextImpl) _then)
      : super(_value, _then);

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? walletName = null,
    Object? account = null,
    Object? selectedCustodian = null,
    Object? localCustodians = null,
    Object? selectedAsset = null,
    Object? assets = null,
    Object? receiveAddress = freezed,
    Object? amount = null,
    Object? comment = freezed,
  }) {
    return _then(_$GoNextImpl(
      walletName: null == walletName
          ? _value.walletName
          : walletName // ignore: cast_nullable_to_non_nullable
              as String,
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as KeyAccount,
      selectedCustodian: null == selectedCustodian
          ? _value.selectedCustodian
          : selectedCustodian // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      localCustodians: null == localCustodians
          ? _value._localCustodians
          : localCustodians // ignore: cast_nullable_to_non_nullable
              as List<PublicKey>,
      selectedAsset: null == selectedAsset
          ? _value.selectedAsset
          : selectedAsset // ignore: cast_nullable_to_non_nullable
              as WalletPrepareTransferAsset,
      assets: null == assets
          ? _value._assets
          : assets // ignore: cast_nullable_to_non_nullable
              as List<WalletPrepareTransferAsset>,
      receiveAddress: freezed == receiveAddress
          ? _value.receiveAddress
          : receiveAddress // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Fixed,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PublicKeyCopyWith<$Res> get selectedCustodian {
    return $PublicKeyCopyWith<$Res>(_value.selectedCustodian, (value) {
      return _then(_value.copyWith(selectedCustodian: value));
    });
  }
}

/// @nodoc

class _$GoNextImpl implements _GoNext {
  const _$GoNextImpl(
      {required this.walletName,
      required this.account,
      required this.selectedCustodian,
      required final List<PublicKey> localCustodians,
      required this.selectedAsset,
      required final List<WalletPrepareTransferAsset> assets,
      required this.receiveAddress,
      required this.amount,
      required this.comment})
      : _localCustodians = localCustodians,
        _assets = assets;

  @override
  final String walletName;
  @override
  final KeyAccount account;
  @override
  final PublicKey selectedCustodian;
  final List<PublicKey> _localCustodians;
  @override
  List<PublicKey> get localCustodians {
    if (_localCustodians is EqualUnmodifiableListView) return _localCustodians;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_localCustodians);
  }

  @override
  final WalletPrepareTransferAsset selectedAsset;
  final List<WalletPrepareTransferAsset> _assets;
  @override
  List<WalletPrepareTransferAsset> get assets {
    if (_assets is EqualUnmodifiableListView) return _assets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assets);
  }

  @override
  final Address receiveAddress;
  @override
  final Fixed amount;
  @override
  final String? comment;

  @override
  String toString() {
    return 'WalletPrepareTransferState.goNext(walletName: $walletName, account: $account, selectedCustodian: $selectedCustodian, localCustodians: $localCustodians, selectedAsset: $selectedAsset, assets: $assets, receiveAddress: $receiveAddress, amount: $amount, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoNextImpl &&
            (identical(other.walletName, walletName) ||
                other.walletName == walletName) &&
            (identical(other.account, account) || other.account == account) &&
            (identical(other.selectedCustodian, selectedCustodian) ||
                other.selectedCustodian == selectedCustodian) &&
            const DeepCollectionEquality()
                .equals(other._localCustodians, _localCustodians) &&
            (identical(other.selectedAsset, selectedAsset) ||
                other.selectedAsset == selectedAsset) &&
            const DeepCollectionEquality().equals(other._assets, _assets) &&
            const DeepCollectionEquality()
                .equals(other.receiveAddress, receiveAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      walletName,
      account,
      selectedCustodian,
      const DeepCollectionEquality().hash(_localCustodians),
      selectedAsset,
      const DeepCollectionEquality().hash(_assets),
      const DeepCollectionEquality().hash(receiveAddress),
      amount,
      comment);

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoNextImplCopyWith<_$GoNextImpl> get copyWith =>
      __$$GoNextImplCopyWithImpl<_$GoNextImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function() empty,
    required TResult Function(Object error) subscribeError,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)
        data,
    required TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)
        goNext,
  }) {
    return goNext(walletName, account, selectedCustodian, localCustodians,
        selectedAsset, assets, receiveAddress, amount, comment);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function()? empty,
    TResult? Function(Object error)? subscribeError,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult? Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
  }) {
    return goNext?.call(walletName, account, selectedCustodian, localCustodians,
        selectedAsset, assets, receiveAddress, amount, comment);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function()? empty,
    TResult Function(Object error)? subscribeError,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets)?
        data,
    TResult Function(
            String walletName,
            KeyAccount account,
            PublicKey selectedCustodian,
            List<PublicKey> localCustodians,
            WalletPrepareTransferAsset selectedAsset,
            List<WalletPrepareTransferAsset> assets,
            Address receiveAddress,
            Fixed amount,
            String? comment)?
        goNext,
    required TResult orElse(),
  }) {
    if (goNext != null) {
      return goNext(walletName, account, selectedCustodian, localCustodians,
          selectedAsset, assets, receiveAddress, amount, comment);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Empty value) empty,
    required TResult Function(_SubscribeError value) subscribeError,
    required TResult Function(_Data value) data,
    required TResult Function(_GoNext value) goNext,
  }) {
    return goNext(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Empty value)? empty,
    TResult? Function(_SubscribeError value)? subscribeError,
    TResult? Function(_Data value)? data,
    TResult? Function(_GoNext value)? goNext,
  }) {
    return goNext?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Empty value)? empty,
    TResult Function(_SubscribeError value)? subscribeError,
    TResult Function(_Data value)? data,
    TResult Function(_GoNext value)? goNext,
    required TResult orElse(),
  }) {
    if (goNext != null) {
      return goNext(this);
    }
    return orElse();
  }
}

abstract class _GoNext implements WalletPrepareTransferState {
  const factory _GoNext(
      {required final String walletName,
      required final KeyAccount account,
      required final PublicKey selectedCustodian,
      required final List<PublicKey> localCustodians,
      required final WalletPrepareTransferAsset selectedAsset,
      required final List<WalletPrepareTransferAsset> assets,
      required final Address receiveAddress,
      required final Fixed amount,
      required final String? comment}) = _$GoNextImpl;

  String get walletName;
  KeyAccount get account;
  PublicKey get selectedCustodian;
  List<PublicKey> get localCustodians;
  WalletPrepareTransferAsset get selectedAsset;
  List<WalletPrepareTransferAsset> get assets;
  Address get receiveAddress;
  Fixed get amount;
  String? get comment;

  /// Create a copy of WalletPrepareTransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoNextImplCopyWith<_$GoNextImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
