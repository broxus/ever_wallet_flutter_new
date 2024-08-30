// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_removed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AccountRemovedEvent {
  AssetsList get account => throw _privateConstructorUsedError;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AccountRemovedEventCopyWith<AccountRemovedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AccountRemovedEventCopyWith<$Res> {
  factory $AccountRemovedEventCopyWith(
          AccountRemovedEvent value, $Res Function(AccountRemovedEvent) then) =
      _$AccountRemovedEventCopyWithImpl<$Res, AccountRemovedEvent>;
  @useResult
  $Res call({AssetsList account});

  $AssetsListCopyWith<$Res> get account;
}

/// @nodoc
class _$AccountRemovedEventCopyWithImpl<$Res, $Val extends AccountRemovedEvent>
    implements $AccountRemovedEventCopyWith<$Res> {
  _$AccountRemovedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
  }) {
    return _then(_value.copyWith(
      account: null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as AssetsList,
    ) as $Val);
  }

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AssetsListCopyWith<$Res> get account {
    return $AssetsListCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AccountRemovedEventImplCopyWith<$Res>
    implements $AccountRemovedEventCopyWith<$Res> {
  factory _$$AccountRemovedEventImplCopyWith(_$AccountRemovedEventImpl value,
          $Res Function(_$AccountRemovedEventImpl) then) =
      __$$AccountRemovedEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AssetsList account});

  @override
  $AssetsListCopyWith<$Res> get account;
}

/// @nodoc
class __$$AccountRemovedEventImplCopyWithImpl<$Res>
    extends _$AccountRemovedEventCopyWithImpl<$Res, _$AccountRemovedEventImpl>
    implements _$$AccountRemovedEventImplCopyWith<$Res> {
  __$$AccountRemovedEventImplCopyWithImpl(_$AccountRemovedEventImpl _value,
      $Res Function(_$AccountRemovedEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? account = null,
  }) {
    return _then(_$AccountRemovedEventImpl(
      null == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as AssetsList,
    ));
  }
}

/// @nodoc

class _$AccountRemovedEventImpl implements _AccountRemovedEvent {
  const _$AccountRemovedEventImpl(this.account);

  @override
  final AssetsList account;

  @override
  String toString() {
    return 'AccountRemovedEvent(account: $account)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountRemovedEventImpl &&
            (identical(other.account, account) || other.account == account));
  }

  @override
  int get hashCode => Object.hash(runtimeType, account);

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountRemovedEventImplCopyWith<_$AccountRemovedEventImpl> get copyWith =>
      __$$AccountRemovedEventImplCopyWithImpl<_$AccountRemovedEventImpl>(
          this, _$identity);
}

abstract class _AccountRemovedEvent implements AccountRemovedEvent {
  const factory _AccountRemovedEvent(final AssetsList account) =
      _$AccountRemovedEventImpl;

  @override
  AssetsList get account;

  /// Create a copy of AccountRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountRemovedEventImplCopyWith<_$AccountRemovedEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
