// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_seeds_accounts_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageSeedsAccountsState {
  Seed? get currentSeed => throw _privateConstructorUsedError;
  List<Seed> get seeds => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Seed? currentSeed, List<Seed> seeds) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Seed? currentSeed, List<Seed> seeds)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Seed? currentSeed, List<Seed> seeds)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ManageSeedsAccountsStateCopyWith<ManageSeedsAccountsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageSeedsAccountsStateCopyWith<$Res> {
  factory $ManageSeedsAccountsStateCopyWith(ManageSeedsAccountsState value,
          $Res Function(ManageSeedsAccountsState) then) =
      _$ManageSeedsAccountsStateCopyWithImpl<$Res, ManageSeedsAccountsState>;
  @useResult
  $Res call({Seed? currentSeed, List<Seed> seeds});
}

/// @nodoc
class _$ManageSeedsAccountsStateCopyWithImpl<$Res,
        $Val extends ManageSeedsAccountsState>
    implements $ManageSeedsAccountsStateCopyWith<$Res> {
  _$ManageSeedsAccountsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSeed = freezed,
    Object? seeds = null,
  }) {
    return _then(_value.copyWith(
      currentSeed: freezed == currentSeed
          ? _value.currentSeed
          : currentSeed // ignore: cast_nullable_to_non_nullable
              as Seed?,
      seeds: null == seeds
          ? _value.seeds
          : seeds // ignore: cast_nullable_to_non_nullable
              as List<Seed>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res>
    implements $ManageSeedsAccountsStateCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Seed? currentSeed, List<Seed> seeds});
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$ManageSeedsAccountsStateCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentSeed = freezed,
    Object? seeds = null,
  }) {
    return _then(_$DataImpl(
      currentSeed: freezed == currentSeed
          ? _value.currentSeed
          : currentSeed // ignore: cast_nullable_to_non_nullable
              as Seed?,
      seeds: null == seeds
          ? _value._seeds
          : seeds // ignore: cast_nullable_to_non_nullable
              as List<Seed>,
    ));
  }
}

/// @nodoc

class _$DataImpl implements _Data {
  const _$DataImpl({required this.currentSeed, required final List<Seed> seeds})
      : _seeds = seeds;

  @override
  final Seed? currentSeed;
  final List<Seed> _seeds;
  @override
  List<Seed> get seeds {
    if (_seeds is EqualUnmodifiableListView) return _seeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seeds);
  }

  @override
  String toString() {
    return 'ManageSeedsAccountsState.data(currentSeed: $currentSeed, seeds: $seeds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.currentSeed, currentSeed) ||
                other.currentSeed == currentSeed) &&
            const DeepCollectionEquality().equals(other._seeds, _seeds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, currentSeed, const DeepCollectionEquality().hash(_seeds));

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Seed? currentSeed, List<Seed> seeds) data,
  }) {
    return data(currentSeed, seeds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Seed? currentSeed, List<Seed> seeds)? data,
  }) {
    return data?.call(currentSeed, seeds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Seed? currentSeed, List<Seed> seeds)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(currentSeed, seeds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Data value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Data value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Data value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _Data implements ManageSeedsAccountsState {
  const factory _Data(
      {required final Seed? currentSeed,
      required final List<Seed> seeds}) = _$DataImpl;

  @override
  Seed? get currentSeed;
  @override
  List<Seed> get seeds;

  /// Create a copy of ManageSeedsAccountsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
