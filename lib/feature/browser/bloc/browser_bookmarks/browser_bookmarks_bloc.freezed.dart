// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_bookmarks_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserBookmarksEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetItem value) setItem,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetItem value)? setItem,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetItem value)? setItem,
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
abstract class $BrowserBookmarksEventCopyWith<$Res> {
  factory $BrowserBookmarksEventCopyWith(BrowserBookmarksEvent value,
          $Res Function(BrowserBookmarksEvent) then) =
      _$BrowserBookmarksEventCopyWithImpl<$Res, BrowserBookmarksEvent>;
}

/// @nodoc
class _$BrowserBookmarksEventCopyWithImpl<$Res,
        $Val extends BrowserBookmarksEvent>
    implements $BrowserBookmarksEventCopyWith<$Res> {
  _$BrowserBookmarksEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SetItemImplCopyWith<$Res> {
  factory _$$SetItemImplCopyWith(
          _$SetItemImpl value, $Res Function(_$SetItemImpl) then) =
      __$$SetItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({BrowserBookmarkItem item});

  $BrowserBookmarkItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$SetItemImplCopyWithImpl<$Res>
    extends _$BrowserBookmarksEventCopyWithImpl<$Res, _$SetItemImpl>
    implements _$$SetItemImplCopyWith<$Res> {
  __$$SetItemImplCopyWithImpl(
      _$SetItemImpl _value, $Res Function(_$SetItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$SetItemImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as BrowserBookmarkItem,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $BrowserBookmarkItemCopyWith<$Res> get item {
    return $BrowserBookmarkItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value));
    });
  }
}

/// @nodoc

class _$SetItemImpl implements _SetItem {
  const _$SetItemImpl({required this.item});

  @override
  final BrowserBookmarkItem item;

  @override
  String toString() {
    return 'BrowserBookmarksEvent.setItem(item: $item)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetItemImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SetItemImplCopyWith<_$SetItemImpl> get copyWith =>
      __$$SetItemImplCopyWithImpl<_$SetItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return setItem(item);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return setItem?.call(item);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
    TResult Function(String value)? setSearchString,
    TResult Function(bool value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (setItem != null) {
      return setItem(item);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SetItem value) setItem,
    required TResult Function(_Remove value) remove,
    required TResult Function(_Clear value) clear,
    required TResult Function(_Set value) set,
    required TResult Function(_SetSearchString value) setSearchString,
    required TResult Function(_SetIsEditing value) setIsEditing,
  }) {
    return setItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SetItem value)? setItem,
    TResult? Function(_Remove value)? remove,
    TResult? Function(_Clear value)? clear,
    TResult? Function(_Set value)? set,
    TResult? Function(_SetSearchString value)? setSearchString,
    TResult? Function(_SetIsEditing value)? setIsEditing,
  }) {
    return setItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SetItem value)? setItem,
    TResult Function(_Remove value)? remove,
    TResult Function(_Clear value)? clear,
    TResult Function(_Set value)? set,
    TResult Function(_SetSearchString value)? setSearchString,
    TResult Function(_SetIsEditing value)? setIsEditing,
    required TResult orElse(),
  }) {
    if (setItem != null) {
      return setItem(this);
    }
    return orElse();
  }
}

abstract class _SetItem implements BrowserBookmarksEvent {
  const factory _SetItem({required final BrowserBookmarkItem item}) =
      _$SetItemImpl;

  BrowserBookmarkItem get item;
  @JsonKey(ignore: true)
  _$$SetItemImplCopyWith<_$SetItemImpl> get copyWith =>
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
    extends _$BrowserBookmarksEventCopyWithImpl<$Res, _$RemoveImpl>
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
    return 'BrowserBookmarksEvent.remove(id: $id)';
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
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return remove(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return remove?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
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
    required TResult Function(_SetItem value) setItem,
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
    TResult? Function(_SetItem value)? setItem,
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
    TResult Function(_SetItem value)? setItem,
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

abstract class _Remove implements BrowserBookmarksEvent {
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
    extends _$BrowserBookmarksEventCopyWithImpl<$Res, _$ClearImpl>
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
    return 'BrowserBookmarksEvent.clear()';
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
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return clear();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return clear?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
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
    required TResult Function(_SetItem value) setItem,
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
    TResult? Function(_SetItem value)? setItem,
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
    TResult Function(_SetItem value)? setItem,
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

abstract class _Clear implements BrowserBookmarksEvent {
  const factory _Clear() = _$ClearImpl;
}

/// @nodoc
abstract class _$$SetImplCopyWith<$Res> {
  factory _$$SetImplCopyWith(_$SetImpl value, $Res Function(_$SetImpl) then) =
      __$$SetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BrowserBookmarkItem> items});
}

/// @nodoc
class __$$SetImplCopyWithImpl<$Res>
    extends _$BrowserBookmarksEventCopyWithImpl<$Res, _$SetImpl>
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
              as List<BrowserBookmarkItem>,
    ));
  }
}

/// @nodoc

class _$SetImpl implements _Set {
  const _$SetImpl({required final List<BrowserBookmarkItem> items})
      : _items = items;

  final List<BrowserBookmarkItem> _items;
  @override
  List<BrowserBookmarkItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'BrowserBookmarksEvent.set(items: $items)';
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
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return set(items);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return set?.call(items);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
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
    required TResult Function(_SetItem value) setItem,
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
    TResult? Function(_SetItem value)? setItem,
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
    TResult Function(_SetItem value)? setItem,
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

abstract class _Set implements BrowserBookmarksEvent {
  const factory _Set({required final List<BrowserBookmarkItem> items}) =
      _$SetImpl;

  List<BrowserBookmarkItem> get items;
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
    extends _$BrowserBookmarksEventCopyWithImpl<$Res, _$SetSearchStringImpl>
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
    return 'BrowserBookmarksEvent.setSearchString(value: $value)';
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
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return setSearchString(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return setSearchString?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
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
    required TResult Function(_SetItem value) setItem,
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
    TResult? Function(_SetItem value)? setItem,
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
    TResult Function(_SetItem value)? setItem,
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

abstract class _SetSearchString implements BrowserBookmarksEvent {
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
    extends _$BrowserBookmarksEventCopyWithImpl<$Res, _$SetIsEditingImpl>
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
    return 'BrowserBookmarksEvent.setIsEditing(value: $value)';
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
    required TResult Function(BrowserBookmarkItem item) setItem,
    required TResult Function(String id) remove,
    required TResult Function() clear,
    required TResult Function(List<BrowserBookmarkItem> items) set,
    required TResult Function(String value) setSearchString,
    required TResult Function(bool value) setIsEditing,
  }) {
    return setIsEditing(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BrowserBookmarkItem item)? setItem,
    TResult? Function(String id)? remove,
    TResult? Function()? clear,
    TResult? Function(List<BrowserBookmarkItem> items)? set,
    TResult? Function(String value)? setSearchString,
    TResult? Function(bool value)? setIsEditing,
  }) {
    return setIsEditing?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BrowserBookmarkItem item)? setItem,
    TResult Function(String id)? remove,
    TResult Function()? clear,
    TResult Function(List<BrowserBookmarkItem> items)? set,
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
    required TResult Function(_SetItem value) setItem,
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
    TResult? Function(_SetItem value)? setItem,
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
    TResult Function(_SetItem value)? setItem,
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

abstract class _SetIsEditing implements BrowserBookmarksEvent {
  const factory _SetIsEditing({required final bool value}) = _$SetIsEditingImpl;

  bool get value;
  @JsonKey(ignore: true)
  _$$SetIsEditingImplCopyWith<_$SetIsEditingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrowserBookmarksState {
  List<BrowserBookmarkItem> get items => throw _privateConstructorUsedError;
  bool get isEditing => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrowserBookmarksStateCopyWith<BrowserBookmarksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserBookmarksStateCopyWith<$Res> {
  factory $BrowserBookmarksStateCopyWith(BrowserBookmarksState value,
          $Res Function(BrowserBookmarksState) then) =
      _$BrowserBookmarksStateCopyWithImpl<$Res, BrowserBookmarksState>;
  @useResult
  $Res call({List<BrowserBookmarkItem> items, bool isEditing});
}

/// @nodoc
class _$BrowserBookmarksStateCopyWithImpl<$Res,
        $Val extends BrowserBookmarksState>
    implements $BrowserBookmarksStateCopyWith<$Res> {
  _$BrowserBookmarksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isEditing = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BrowserBookmarkItem>,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserBookmarksStateImplCopyWith<$Res>
    implements $BrowserBookmarksStateCopyWith<$Res> {
  factory _$$BrowserBookmarksStateImplCopyWith(
          _$BrowserBookmarksStateImpl value,
          $Res Function(_$BrowserBookmarksStateImpl) then) =
      __$$BrowserBookmarksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BrowserBookmarkItem> items, bool isEditing});
}

/// @nodoc
class __$$BrowserBookmarksStateImplCopyWithImpl<$Res>
    extends _$BrowserBookmarksStateCopyWithImpl<$Res,
        _$BrowserBookmarksStateImpl>
    implements _$$BrowserBookmarksStateImplCopyWith<$Res> {
  __$$BrowserBookmarksStateImplCopyWithImpl(_$BrowserBookmarksStateImpl _value,
      $Res Function(_$BrowserBookmarksStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isEditing = null,
  }) {
    return _then(_$BrowserBookmarksStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<BrowserBookmarkItem>,
      isEditing: null == isEditing
          ? _value.isEditing
          : isEditing // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$BrowserBookmarksStateImpl implements _BrowserBookmarksState {
  const _$BrowserBookmarksStateImpl(
      {required final List<BrowserBookmarkItem> items, required this.isEditing})
      : _items = items;

  final List<BrowserBookmarkItem> _items;
  @override
  List<BrowserBookmarkItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isEditing;

  @override
  String toString() {
    return 'BrowserBookmarksState(items: $items, isEditing: $isEditing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserBookmarksStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isEditing, isEditing) ||
                other.isEditing == isEditing));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), isEditing);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserBookmarksStateImplCopyWith<_$BrowserBookmarksStateImpl>
      get copyWith => __$$BrowserBookmarksStateImplCopyWithImpl<
          _$BrowserBookmarksStateImpl>(this, _$identity);
}

abstract class _BrowserBookmarksState implements BrowserBookmarksState {
  const factory _BrowserBookmarksState(
      {required final List<BrowserBookmarkItem> items,
      required final bool isEditing}) = _$BrowserBookmarksStateImpl;

  @override
  List<BrowserBookmarkItem> get items;
  @override
  bool get isEditing;
  @override
  @JsonKey(ignore: true)
  _$$BrowserBookmarksStateImplCopyWith<_$BrowserBookmarksStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
