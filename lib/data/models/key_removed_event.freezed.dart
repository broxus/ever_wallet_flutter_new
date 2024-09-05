// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_removed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KeyRemovedEvent {
  KeyStoreEntry get key => throw _privateConstructorUsedError;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyRemovedEventCopyWith<KeyRemovedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyRemovedEventCopyWith<$Res> {
  factory $KeyRemovedEventCopyWith(
          KeyRemovedEvent value, $Res Function(KeyRemovedEvent) then) =
      _$KeyRemovedEventCopyWithImpl<$Res, KeyRemovedEvent>;
  @useResult
  $Res call({KeyStoreEntry key});

  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class _$KeyRemovedEventCopyWithImpl<$Res, $Val extends KeyRemovedEvent>
    implements $KeyRemovedEventCopyWith<$Res> {
  _$KeyRemovedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as KeyStoreEntry,
    ) as $Val);
  }

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $KeyStoreEntryCopyWith<$Res> get key {
    return $KeyStoreEntryCopyWith<$Res>(_value.key, (value) {
      return _then(_value.copyWith(key: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$KeyRemovedEventImplCopyWith<$Res>
    implements $KeyRemovedEventCopyWith<$Res> {
  factory _$$KeyRemovedEventImplCopyWith(_$KeyRemovedEventImpl value,
          $Res Function(_$KeyRemovedEventImpl) then) =
      __$$KeyRemovedEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({KeyStoreEntry key});

  @override
  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class __$$KeyRemovedEventImplCopyWithImpl<$Res>
    extends _$KeyRemovedEventCopyWithImpl<$Res, _$KeyRemovedEventImpl>
    implements _$$KeyRemovedEventImplCopyWith<$Res> {
  __$$KeyRemovedEventImplCopyWithImpl(
      _$KeyRemovedEventImpl _value, $Res Function(_$KeyRemovedEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$KeyRemovedEventImpl(
      null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as KeyStoreEntry,
    ));
  }
}

/// @nodoc

class _$KeyRemovedEventImpl implements _KeyRemovedEvent {
  const _$KeyRemovedEventImpl(this.key);

  @override
  final KeyStoreEntry key;

  @override
  String toString() {
    return 'KeyRemovedEvent(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyRemovedEventImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyRemovedEventImplCopyWith<_$KeyRemovedEventImpl> get copyWith =>
      __$$KeyRemovedEventImplCopyWithImpl<_$KeyRemovedEventImpl>(
          this, _$identity);
}

abstract class _KeyRemovedEvent implements KeyRemovedEvent {
  const factory _KeyRemovedEvent(final KeyStoreEntry key) =
      _$KeyRemovedEventImpl;

  @override
  KeyStoreEntry get key;

  /// Create a copy of KeyRemovedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyRemovedEventImplCopyWith<_$KeyRemovedEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
