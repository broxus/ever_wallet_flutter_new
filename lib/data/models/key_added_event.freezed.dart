// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'key_added_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$KeyAddedEvent {
  KeyStoreEntry get key => throw _privateConstructorUsedError;

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $KeyAddedEventCopyWith<KeyAddedEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KeyAddedEventCopyWith<$Res> {
  factory $KeyAddedEventCopyWith(
          KeyAddedEvent value, $Res Function(KeyAddedEvent) then) =
      _$KeyAddedEventCopyWithImpl<$Res, KeyAddedEvent>;
  @useResult
  $Res call({KeyStoreEntry key});

  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class _$KeyAddedEventCopyWithImpl<$Res, $Val extends KeyAddedEvent>
    implements $KeyAddedEventCopyWith<$Res> {
  _$KeyAddedEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of KeyAddedEvent
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

  /// Create a copy of KeyAddedEvent
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
abstract class _$$KeyAddedEventImplCopyWith<$Res>
    implements $KeyAddedEventCopyWith<$Res> {
  factory _$$KeyAddedEventImplCopyWith(
          _$KeyAddedEventImpl value, $Res Function(_$KeyAddedEventImpl) then) =
      __$$KeyAddedEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({KeyStoreEntry key});

  @override
  $KeyStoreEntryCopyWith<$Res> get key;
}

/// @nodoc
class __$$KeyAddedEventImplCopyWithImpl<$Res>
    extends _$KeyAddedEventCopyWithImpl<$Res, _$KeyAddedEventImpl>
    implements _$$KeyAddedEventImplCopyWith<$Res> {
  __$$KeyAddedEventImplCopyWithImpl(
      _$KeyAddedEventImpl _value, $Res Function(_$KeyAddedEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
  }) {
    return _then(_$KeyAddedEventImpl(
      null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as KeyStoreEntry,
    ));
  }
}

/// @nodoc

class _$KeyAddedEventImpl implements _KeyAddedEvent {
  const _$KeyAddedEventImpl(this.key);

  @override
  final KeyStoreEntry key;

  @override
  String toString() {
    return 'KeyAddedEvent(key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeyAddedEventImpl &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, key);

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$KeyAddedEventImplCopyWith<_$KeyAddedEventImpl> get copyWith =>
      __$$KeyAddedEventImplCopyWithImpl<_$KeyAddedEventImpl>(this, _$identity);
}

abstract class _KeyAddedEvent implements KeyAddedEvent {
  const factory _KeyAddedEvent(final KeyStoreEntry key) = _$KeyAddedEventImpl;

  @override
  KeyStoreEntry get key;

  /// Create a copy of KeyAddedEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$KeyAddedEventImplCopyWith<_$KeyAddedEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
