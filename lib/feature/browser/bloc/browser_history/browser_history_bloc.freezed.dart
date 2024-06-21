// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserHistoryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserHistoryEventCopyWith<$Res> {
  factory $BrowserHistoryEventCopyWith(
          BrowserHistoryEvent value, $Res Function(BrowserHistoryEvent) then) =
      _$BrowserHistoryEventCopyWithImpl<$Res, BrowserHistoryEvent>;
}

/// @nodoc
class _$BrowserHistoryEventCopyWithImpl<$Res, $Val extends BrowserHistoryEvent>
    implements $BrowserHistoryEventCopyWith<$Res> {
  _$BrowserHistoryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AddImplCopyWith<$Res> {
  factory _$$AddImplCopyWith(_$AddImpl value, $Res Function(_$AddImpl) then) =
      __$$AddImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BrowserHistoryItem item});

  $BrowserHistoryItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$AddImplCopyWithImpl<$Res>
    extends _$BrowserHistoryEventCopyWithImpl<$Res, _$AddImpl>
    implements _$$AddImplCopyWith<$Res> {
  __$$AddImplCopyWithImpl(_$AddImpl _value, $Res Function(_$AddImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$AddImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as BrowserHistoryItem,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $BrowserHistoryItemCopyWith<$Res> get item {
    return $BrowserHistoryItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$AddImpl implements _Add {
  const _$AddImpl({required this.item});

  @override
  final BrowserHistoryItem item;

  @override
  String toString() {
    return 'BrowserHistoryEvent.add(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddImplCopyWith<_$AddImpl> get copyWith =>
      __$$AddImplCopyWithImpl<_$AddImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return add(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return add?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return add(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return add?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (add != null) {
      return add(this);
    }
    return orElse();
  }
}

abstract class _Add implements BrowserHistoryEvent {
  const factory _Add({required final BrowserHistoryItem item}) = _$AddImpl;

  BrowserHistoryItem get item;
  @JsonKey(ignore: true)
  _$$AddImplCopyWith<_$AddImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveImplCopyWith<$Res> {
  factory _$$RemoveImplCopyWith(
          _$RemoveImpl value, $Res Function(_$RemoveImpl) then) =
      __$$RemoveImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RemoveImplCopyWithImpl<$Res>
    extends _$BrowserHistoryEventCopyWithImpl<$Res, _$RemoveImpl>
    implements _$$RemoveImplCopyWith<$Res> {
  __$$RemoveImplCopyWithImpl(
      _$RemoveImpl _value, $Res Function(_$RemoveImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RemoveImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveImpl implements _Remove {
  const _$RemoveImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'BrowserHistoryEvent.remove(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveImplCopyWith<_$RemoveImpl> get copyWith =>
      __$$RemoveImplCopyWithImpl<_$RemoveImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return remove(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return remove?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return remove(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return remove?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (remove != null) {
      return remove(this);
    }
    return orElse();
  }
}

abstract class _Remove implements BrowserHistoryEvent {
  const factory _Remove({required final String id}) = _$RemoveImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$RemoveImplCopyWith<_$RemoveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClearImplCopyWith<$Res> {
  factory _$$ClearImplCopyWith(
          _$ClearImpl value, $Res Function(_$ClearImpl) then) =
      __$$ClearImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClearImplCopyWithImpl<$Res>
    extends _$BrowserHistoryEventCopyWithImpl<$Res, _$ClearImpl>
    implements _$$ClearImplCopyWith<$Res> {
  __$$ClearImplCopyWithImpl(
      _$ClearImpl _value, $Res Function(_$ClearImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ClearImpl implements _Clear {
  const _$ClearImpl();

  @override
  String toString() {
    return 'BrowserHistoryEvent.clear()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClearImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return clear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return clear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return clear(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return clear?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (clear != null) {
      return clear(this);
    }
    return orElse();
  }
}

abstract class _Clear implements BrowserHistoryEvent {
  const factory _Clear() = _$ClearImpl;
}

/// @nodoc
abstract class _$$SetImplCopyWith<$Res> {
  factory _$$SetImplCopyWith(_$SetImpl value, $Res Function(_$SetImpl) then) =
      __$$SetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BrowserHistoryItem> items});
}

/// @nodoc
class __$$SetImplCopyWithImpl<$Res>
    extends _$BrowserHistoryEventCopyWithImpl<$Res, _$SetImpl>
    implements _$$SetImplCopyWith<$Res> {
  __$$SetImplCopyWithImpl(_$SetImpl _value, $Res Function(_$SetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
  }) {
    return _then(_$SetImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BrowserHistoryItem>,
    ));
  }
}

/// @nodoc

class _$SetImpl implements _Set {
  const _$SetImpl({required final List<BrowserHistoryItem> items})
      : _items = items;

  final List<BrowserHistoryItem> _items;
  @override
  List<BrowserHistoryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'BrowserHistoryEvent.set(items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetImpl &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetImplCopyWith<_$SetImpl> get copyWith =>
      __$$SetImplCopyWithImpl<_$SetImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return set(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return set?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (set != null) {
      return set(items);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return set(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return set?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (set != null) {
      return set(this);
    }
    return orElse();
  }
}

abstract class _Set implements BrowserHistoryEvent {
  const factory _Set({required final List<BrowserHistoryItem> items}) =
      _$SetImpl;

  List<BrowserHistoryItem> get items;
  @JsonKey(ignore: true)
  _$$SetImplCopyWith<_$SetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetSearchStringImplCopyWith<$Res> {
  factory _$$SetSearchStringImplCopyWith(_$SetSearchStringImpl value,
          $Res Function(_$SetSearchStringImpl) then) =
      __$$SetSearchStringImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$SetSearchStringImplCopyWithImpl<$Res>
    extends _$BrowserHistoryEventCopyWithImpl<$Res, _$SetSearchStringImpl>
    implements _$$SetSearchStringImplCopyWith<$Res> {
  __$$SetSearchStringImplCopyWithImpl(
      _$SetSearchStringImpl _value, $Res Function(_$SetSearchStringImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SetSearchStringImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SetSearchStringImpl implements _SetSearchString {
  const _$SetSearchStringImpl({required this.value});

  @override
  final String value;

  @override
  String toString() {
    return 'BrowserHistoryEvent.setSearchString(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetSearchStringImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetSearchStringImplCopyWith<_$SetSearchStringImpl> get copyWith =>
      __$$SetSearchStringImplCopyWithImpl<_$SetSearchStringImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return setSearchString(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return setSearchString?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (setSearchString != null) {
      return setSearchString(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return setSearchString(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return setSearchString?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (setSearchString != null) {
      return setSearchString(this);
    }
    return orElse();
  }
}

abstract class _SetSearchString implements BrowserHistoryEvent {
  const factory _SetSearchString({required final String value}) =
      _$SetSearchStringImpl;

  String get value;
  @JsonKey(ignore: true)
  _$$SetSearchStringImplCopyWith<_$SetSearchStringImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SetIsEditingImplCopyWith<$Res> {
  factory _$$SetIsEditingImplCopyWith(
          _$SetIsEditingImpl value, $Res Function(_$SetIsEditingImpl) then) =
      __$$SetIsEditingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool value});
}

/// @nodoc
class __$$SetIsEditingImplCopyWithImpl<$Res>
    extends _$BrowserHistoryEventCopyWithImpl<$Res, _$SetIsEditingImpl>
    implements _$$SetIsEditingImplCopyWith<$Res> {
  __$$SetIsEditingImplCopyWithImpl(
      _$SetIsEditingImpl _value, $Res Function(_$SetIsEditingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$SetIsEditingImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SetIsEditingImpl implements _SetIsEditing {
  const _$SetIsEditingImpl({required this.value});

  @override
  final bool value;

  @override
  String toString() {
    return 'BrowserHistoryEvent.setIsEditing(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetIsEditingImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetIsEditingImplCopyWith<_$SetIsEditingImpl> get copyWith =>
      __$$SetIsEditingImplCopyWithImpl<_$SetIsEditingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserHistoryItem item) add,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserHistoryItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return setIsEditing(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserHistoryItem item)? add,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserHistoryItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return setIsEditing?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserHistoryItem item)? add,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserHistoryItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (setIsEditing != null) {
      return setIsEditing(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Add value) add,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return setIsEditing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Add value)? add,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return setIsEditing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Add value)? add,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (setIsEditing != null) {
      return setIsEditing(this);
    }
    return orElse();
  }
}

abstract class _SetIsEditing implements BrowserHistoryEvent {
  const factory _SetIsEditing({required final bool value}) = _$SetIsEditingImpl;

  bool get value;
  @JsonKey(ignore: true)
  _$$SetIsEditingImplCopyWith<_$SetIsEditingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrowserHistoryState {
  List<BrowserHistoryItem> get items => throw _privateConstructorUsedError;
  String get searchString => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrowserHistoryStateCopyWith<BrowserHistoryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserHistoryStateCopyWith<$Res> {
  factory $BrowserHistoryStateCopyWith(
          BrowserHistoryState value, $Res Function(BrowserHistoryState) then) =
      _$BrowserHistoryStateCopyWithImpl<$Res, BrowserHistoryState>;
  @useResult
  $Res call(
      {List<BrowserHistoryItem> items, String searchString, bool isEditing});
}

/// @nodoc
class _$BrowserHistoryStateCopyWithImpl<$Res, $Val extends BrowserHistoryState>
    implements $BrowserHistoryStateCopyWith<$Res> {
  _$BrowserHistoryStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? searchString = null,
    Object? isEditing = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BrowserHistoryItem>,
      searchString: null == searchString
          ? _value.searchString
          : searchString // ignore: cast_nullable_to_non_nullable
              as String,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserHistoryStateImplCopyWith<$Res>
    implements $BrowserHistoryStateCopyWith<$Res> {
  factory _$$BrowserHistoryStateImplCopyWith(_$BrowserHistoryStateImpl value,
          $Res Function(_$BrowserHistoryStateImpl) then) =
      __$$BrowserHistoryStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<BrowserHistoryItem> items, String searchString, bool isEditing});
}

/// @nodoc
class __$$BrowserHistoryStateImplCopyWithImpl<$Res>
    extends _$BrowserHistoryStateCopyWithImpl<$Res, _$BrowserHistoryStateImpl>
    implements _$$BrowserHistoryStateImplCopyWith<$Res> {
  __$$BrowserHistoryStateImplCopyWithImpl(_$BrowserHistoryStateImpl _value,
      $Res Function(_$BrowserHistoryStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? searchString = null,
    Object? isEditing = null,
  }) {
    return _then(_$BrowserHistoryStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BrowserHistoryItem>,
      searchString: null == searchString
          ? _value.searchString
          : searchString // ignore: cast_nullable_to_non_nullable
              as String,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BrowserHistoryStateImpl implements _BrowserHistoryState {
  const _$BrowserHistoryStateImpl(
      {required final List<BrowserHistoryItem> items,
      required this.searchString,
      required this.isEditing})
      : _items = items;

  final List<BrowserHistoryItem> _items;
  @override
  List<BrowserHistoryItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final String searchString;
  @override
  final bool isEditing;

  @override
  String toString() {
    return 'BrowserHistoryState(items: $items, searchString: $searchString, isEditing: $isEditing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserHistoryStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.searchString, searchString) ||
                other.searchString == searchString) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), searchString, isEditing);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserHistoryStateImplCopyWith<_$BrowserHistoryStateImpl> get copyWith =>
      __$$BrowserHistoryStateImplCopyWithImpl<_$BrowserHistoryStateImpl>(
          this, _$identity);
}

abstract class _BrowserHistoryState implements BrowserHistoryState {
  const factory _BrowserHistoryState(
      {required final List<BrowserHistoryItem> items,
      required final String searchString,
      required final bool isEditing}) = _$BrowserHistoryStateImpl;

  @override
  List<BrowserHistoryItem> get items;
  @override
  String get searchString;
  @override
  bool get isEditing;
  @override
  @JsonKey(ignore: true)
  _$$BrowserHistoryStateImplCopyWith<_$BrowserHistoryStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
