// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messenger_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MessengerState {
  List<Message> get messagesToShow => throw _privateConstructorUsedError;
  Map<String, DateTime> get messagesTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MessengerStateCopyWith<MessengerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessengerStateCopyWith<$Res> {
  factory $MessengerStateCopyWith(
          MessengerState value, $Res Function(MessengerState) then) =
      _$MessengerStateCopyWithImpl<$Res, MessengerState>;
  @useResult
  $Res call({List<Message> messagesToShow, Map<String, DateTime> messagesTime});
}

/// @nodoc
class _$MessengerStateCopyWithImpl<$Res, $Val extends MessengerState>
    implements $MessengerStateCopyWith<$Res> {
  _$MessengerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messagesToShow = null,
    Object? messagesTime = null,
  }) {
    return _then(_value.copyWith(
      messagesToShow: null == messagesToShow
          ? _value.messagesToShow
          : messagesToShow // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      messagesTime: null == messagesTime
          ? _value.messagesTime
          : messagesTime // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessengerStateImplCopyWith<$Res>
    implements $MessengerStateCopyWith<$Res> {
  factory _$$MessengerStateImplCopyWith(_$MessengerStateImpl value,
          $Res Function(_$MessengerStateImpl) then) =
      __$$MessengerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Message> messagesToShow, Map<String, DateTime> messagesTime});
}

/// @nodoc
class __$$MessengerStateImplCopyWithImpl<$Res>
    extends _$MessengerStateCopyWithImpl<$Res, _$MessengerStateImpl>
    implements _$$MessengerStateImplCopyWith<$Res> {
  __$$MessengerStateImplCopyWithImpl(
      _$MessengerStateImpl _value, $Res Function(_$MessengerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messagesToShow = null,
    Object? messagesTime = null,
  }) {
    return _then(_$MessengerStateImpl(
      messagesToShow: null == messagesToShow
          ? _value._messagesToShow
          : messagesToShow // ignore: cast_nullable_to_non_nullable
              as List<Message>,
      messagesTime: null == messagesTime
          ? _value._messagesTime
          : messagesTime // ignore: cast_nullable_to_non_nullable
              as Map<String, DateTime>,
    ));
  }
}

/// @nodoc

class _$MessengerStateImpl implements _MessengerState {
  const _$MessengerStateImpl(
      {required final List<Message> messagesToShow,
      required final Map<String, DateTime> messagesTime})
      : _messagesToShow = messagesToShow,
        _messagesTime = messagesTime;

  final List<Message> _messagesToShow;
  @override
  List<Message> get messagesToShow {
    if (_messagesToShow is EqualUnmodifiableListView) return _messagesToShow;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messagesToShow);
  }

  final Map<String, DateTime> _messagesTime;
  @override
  Map<String, DateTime> get messagesTime {
    if (_messagesTime is EqualUnmodifiableMapView) return _messagesTime;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_messagesTime);
  }

  @override
  String toString() {
    return 'MessengerState(messagesToShow: $messagesToShow, messagesTime: $messagesTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessengerStateImpl &&
            const DeepCollectionEquality()
                .equals(other._messagesToShow, _messagesToShow) &&
            const DeepCollectionEquality()
                .equals(other._messagesTime, _messagesTime));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messagesToShow),
      const DeepCollectionEquality().hash(_messagesTime));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MessengerStateImplCopyWith<_$MessengerStateImpl> get copyWith =>
      __$$MessengerStateImplCopyWithImpl<_$MessengerStateImpl>(
          this, _$identity);
}

abstract class _MessengerState implements MessengerState {
  const factory _MessengerState(
          {required final List<Message> messagesToShow,
          required final Map<String, DateTime> messagesTime}) =
      _$MessengerStateImpl;

  @override
  List<Message> get messagesToShow;
  @override
  Map<String, DateTime> get messagesTime;
  @override
  @JsonKey(ignore: true)
  _$$MessengerStateImplCopyWith<_$MessengerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
