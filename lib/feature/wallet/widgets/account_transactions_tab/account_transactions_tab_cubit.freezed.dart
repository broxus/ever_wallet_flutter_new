// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_transactions_tab_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountTransactionsTabState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function() loading,
    required TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)
        transactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function()? loading,
    TResult? Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function()? loading,
    TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Transactions value) transactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Transactions value)? transactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Loading value)? loading,
    TResult Function(_Transactions value)? transactions,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountTransactionsTabStateCopyWith<$Res> {
  factory $AccountTransactionsTabStateCopyWith(
          AccountTransactionsTabState value,
          $Res Function(AccountTransactionsTabState) then) =
      _$AccountTransactionsTabStateCopyWithImpl<$Res,
          AccountTransactionsTabState>;
}

/// @nodoc
class _$AccountTransactionsTabStateCopyWithImpl<$Res,
        $Val extends AccountTransactionsTabState>
    implements $AccountTransactionsTabStateCopyWith<$Res> {
  _$AccountTransactionsTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountTransactionsTabState
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
    extends _$AccountTransactionsTabStateCopyWithImpl<$Res, _$EmptyImpl>
    implements _$$EmptyImplCopyWith<$Res> {
  __$$EmptyImplCopyWithImpl(
      _$EmptyImpl _value, $Res Function(_$EmptyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmptyImpl implements _Empty {
  const _$EmptyImpl();

  @override
  String toString() {
    return 'AccountTransactionsTabState.empty()';
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
    required TResult Function() loading,
    required TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)
        transactions,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function()? loading,
    TResult? Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function()? loading,
    TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
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
    required TResult Function(_Loading value) loading,
    required TResult Function(_Transactions value) transactions,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Transactions value)? transactions,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Loading value)? loading,
    TResult Function(_Transactions value)? transactions,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class _Empty implements AccountTransactionsTabState {
  const factory _Empty() = _$EmptyImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$AccountTransactionsTabStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'AccountTransactionsTabState.loading()';
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
    required TResult Function() empty,
    required TResult Function() loading,
    required TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)
        transactions,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function()? loading,
    TResult? Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function()? loading,
    TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
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
    required TResult Function(_Empty value) empty,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Transactions value) transactions,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Transactions value)? transactions,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Loading value)? loading,
    TResult Function(_Transactions value)? transactions,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements AccountTransactionsTabState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$TransactionsImplCopyWith<$Res> {
  factory _$$TransactionsImplCopyWith(
          _$TransactionsImpl value, $Res Function(_$TransactionsImpl) then) =
      __$$TransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<AccountTransactionItem<Object>> transactions,
      bool isLoading,
      bool canLoadMore,
      Fixed price});
}

/// @nodoc
class __$$TransactionsImplCopyWithImpl<$Res>
    extends _$AccountTransactionsTabStateCopyWithImpl<$Res, _$TransactionsImpl>
    implements _$$TransactionsImplCopyWith<$Res> {
  __$$TransactionsImplCopyWithImpl(
      _$TransactionsImpl _value, $Res Function(_$TransactionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? isLoading = null,
    Object? canLoadMore = null,
    Object? price = null,
  }) {
    return _then(_$TransactionsImpl(
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<AccountTransactionItem<Object>>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      canLoadMore: null == canLoadMore
          ? _value.canLoadMore
          : canLoadMore // ignore: cast_nullable_to_non_nullable
              as bool,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as Fixed,
    ));
  }
}

/// @nodoc

class _$TransactionsImpl implements _Transactions {
  const _$TransactionsImpl(
      {required final List<AccountTransactionItem<Object>> transactions,
      required this.isLoading,
      required this.canLoadMore,
      required this.price})
      : _transactions = transactions;

  final List<AccountTransactionItem<Object>> _transactions;
  @override
  List<AccountTransactionItem<Object>> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final bool isLoading;
  @override
  final bool canLoadMore;
  @override
  final Fixed price;

  @override
  String toString() {
    return 'AccountTransactionsTabState.transactions(transactions: $transactions, isLoading: $isLoading, canLoadMore: $canLoadMore, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionsImpl &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.canLoadMore, canLoadMore) ||
                other.canLoadMore == canLoadMore) &&
            (identical(other.price, price) || other.price == price));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_transactions),
      isLoading,
      canLoadMore,
      price);

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionsImplCopyWith<_$TransactionsImpl> get copyWith =>
      __$$TransactionsImplCopyWithImpl<_$TransactionsImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() empty,
    required TResult Function() loading,
    required TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)
        transactions,
  }) {
    return transactions(this.transactions, isLoading, canLoadMore, price);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? empty,
    TResult? Function()? loading,
    TResult? Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
  }) {
    return transactions?.call(this.transactions, isLoading, canLoadMore, price);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? empty,
    TResult Function()? loading,
    TResult Function(List<AccountTransactionItem<Object>> transactions,
            bool isLoading, bool canLoadMore, Fixed price)?
        transactions,
    required TResult orElse(),
  }) {
    if (transactions != null) {
      return transactions(this.transactions, isLoading, canLoadMore, price);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Empty value) empty,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Transactions value) transactions,
  }) {
    return transactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Empty value)? empty,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Transactions value)? transactions,
  }) {
    return transactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Empty value)? empty,
    TResult Function(_Loading value)? loading,
    TResult Function(_Transactions value)? transactions,
    required TResult orElse(),
  }) {
    if (transactions != null) {
      return transactions(this);
    }
    return orElse();
  }
}

abstract class _Transactions implements AccountTransactionsTabState {
  const factory _Transactions(
      {required final List<AccountTransactionItem<Object>> transactions,
      required final bool isLoading,
      required final bool canLoadMore,
      required final Fixed price}) = _$TransactionsImpl;

  List<AccountTransactionItem<Object>> get transactions;
  bool get isLoading;
  bool get canLoadMore;
  Fixed get price;

  /// Create a copy of AccountTransactionsTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionsImplCopyWith<_$TransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
