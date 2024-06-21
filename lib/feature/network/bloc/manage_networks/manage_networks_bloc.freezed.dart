// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'manage_networks_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ManageNetworksEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageNetworksEventCopyWith<$Res> {
  factory $ManageNetworksEventCopyWith(
          ManageNetworksEvent value, $Res Function(ManageNetworksEvent) then) =
      _$ManageNetworksEventCopyWithImpl<$Res, ManageNetworksEvent>;
}

/// @nodoc
class _$ManageNetworksEventCopyWithImpl<$Res, $Val extends ManageNetworksEvent>
    implements $ManageNetworksEventCopyWith<$Res> {
  _$ManageNetworksEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$setCurrentConnectionIdImplCopyWith<$Res> {
  factory _$$setCurrentConnectionIdImplCopyWith(
          _$setCurrentConnectionIdImpl value,
          $Res Function(_$setCurrentConnectionIdImpl) then) =
      __$$setCurrentConnectionIdImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$setCurrentConnectionIdImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res,
        _$setCurrentConnectionIdImpl>
    implements _$$setCurrentConnectionIdImplCopyWith<$Res> {
  __$$setCurrentConnectionIdImplCopyWithImpl(
      _$setCurrentConnectionIdImpl _value,
      $Res Function(_$setCurrentConnectionIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$setCurrentConnectionIdImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$setCurrentConnectionIdImpl implements _setCurrentConnectionId {
  const _$setCurrentConnectionIdImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'ManageNetworksEvent.setCurrentConnectionId(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$setCurrentConnectionIdImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$setCurrentConnectionIdImplCopyWith<_$setCurrentConnectionIdImpl>
      get copyWith => __$$setCurrentConnectionIdImplCopyWithImpl<
          _$setCurrentConnectionIdImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return setCurrentConnectionId(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return setCurrentConnectionId?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (setCurrentConnectionId != null) {
      return setCurrentConnectionId(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return setCurrentConnectionId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return setCurrentConnectionId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (setCurrentConnectionId != null) {
      return setCurrentConnectionId(this);
    }
    return orElse();
  }
}

abstract class _setCurrentConnectionId implements ManageNetworksEvent {
  const factory _setCurrentConnectionId({required final String id}) =
      _$setCurrentConnectionIdImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$setCurrentConnectionIdImplCopyWith<_$setCurrentConnectionIdImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$setConnectionsImplCopyWith<$Res> {
  factory _$$setConnectionsImplCopyWith(_$setConnectionsImpl value,
          $Res Function(_$setConnectionsImpl) then) =
      __$$setConnectionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ConnectionData> connections});
}

/// @nodoc
class __$$setConnectionsImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res, _$setConnectionsImpl>
    implements _$$setConnectionsImplCopyWith<$Res> {
  __$$setConnectionsImplCopyWithImpl(
      _$setConnectionsImpl _value, $Res Function(_$setConnectionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connections = null,
  }) {
    return _then(_$setConnectionsImpl(
      connections: null == connections
          ? _value._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<ConnectionData>,
    ));
  }
}

/// @nodoc

class _$setConnectionsImpl implements _setConnections {
  const _$setConnectionsImpl({required final List<ConnectionData> connections})
      : _connections = connections;

  final List<ConnectionData> _connections;
  @override
  List<ConnectionData> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  @override
  String toString() {
    return 'ManageNetworksEvent.setConnections(connections: $connections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$setConnectionsImpl &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_connections));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$setConnectionsImplCopyWith<_$setConnectionsImpl> get copyWith =>
      __$$setConnectionsImplCopyWithImpl<_$setConnectionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return setConnections(connections);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return setConnections?.call(connections);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (setConnections != null) {
      return setConnections(connections);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return setConnections(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return setConnections?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (setConnections != null) {
      return setConnections(this);
    }
    return orElse();
  }
}

abstract class _setConnections implements ManageNetworksEvent {
  const factory _setConnections(
      {required final List<ConnectionData> connections}) = _$setConnectionsImpl;

  List<ConnectionData> get connections;
  @JsonKey(ignore: true)
  _$$setConnectionsImplCopyWith<_$setConnectionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$updateCurrentConnectionIdImplCopyWith<$Res> {
  factory _$$updateCurrentConnectionIdImplCopyWith(
          _$updateCurrentConnectionIdImpl value,
          $Res Function(_$updateCurrentConnectionIdImpl) then) =
      __$$updateCurrentConnectionIdImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$updateCurrentConnectionIdImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res,
        _$updateCurrentConnectionIdImpl>
    implements _$$updateCurrentConnectionIdImplCopyWith<$Res> {
  __$$updateCurrentConnectionIdImplCopyWithImpl(
      _$updateCurrentConnectionIdImpl _value,
      $Res Function(_$updateCurrentConnectionIdImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$updateCurrentConnectionIdImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$updateCurrentConnectionIdImpl implements _updateCurrentConnectionId {
  const _$updateCurrentConnectionIdImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'ManageNetworksEvent.updateCurrentConnectionId(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$updateCurrentConnectionIdImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$updateCurrentConnectionIdImplCopyWith<_$updateCurrentConnectionIdImpl>
      get copyWith => __$$updateCurrentConnectionIdImplCopyWithImpl<
          _$updateCurrentConnectionIdImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return updateCurrentConnectionId(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return updateCurrentConnectionId?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (updateCurrentConnectionId != null) {
      return updateCurrentConnectionId(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return updateCurrentConnectionId(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return updateCurrentConnectionId?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (updateCurrentConnectionId != null) {
      return updateCurrentConnectionId(this);
    }
    return orElse();
  }
}

abstract class _updateCurrentConnectionId implements ManageNetworksEvent {
  const factory _updateCurrentConnectionId({required final String id}) =
      _$updateCurrentConnectionIdImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$updateCurrentConnectionIdImplCopyWith<_$updateCurrentConnectionIdImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$addConnectionImplCopyWith<$Res> {
  factory _$$addConnectionImplCopyWith(
          _$addConnectionImpl value, $Res Function(_$addConnectionImpl) then) =
      __$$addConnectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionData connection});

  $ConnectionDataCopyWith<$Res> get connection;
}

/// @nodoc
class __$$addConnectionImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res, _$addConnectionImpl>
    implements _$$addConnectionImplCopyWith<$Res> {
  __$$addConnectionImplCopyWithImpl(
      _$addConnectionImpl _value, $Res Function(_$addConnectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connection = null,
  }) {
    return _then(_$addConnectionImpl(
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as ConnectionData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionDataCopyWith<$Res> get connection {
    return $ConnectionDataCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value));
    });
  }
}

/// @nodoc

class _$addConnectionImpl implements _addConnection {
  const _$addConnectionImpl({required this.connection});

  @override
  final ConnectionData connection;

  @override
  String toString() {
    return 'ManageNetworksEvent.addConnection(connection: $connection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$addConnectionImpl &&
            (identical(other.connection, connection) ||
                other.connection == connection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$addConnectionImplCopyWith<_$addConnectionImpl> get copyWith =>
      __$$addConnectionImplCopyWithImpl<_$addConnectionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return addConnection(connection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return addConnection?.call(connection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (addConnection != null) {
      return addConnection(connection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return addConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return addConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (addConnection != null) {
      return addConnection(this);
    }
    return orElse();
  }
}

abstract class _addConnection implements ManageNetworksEvent {
  const factory _addConnection({required final ConnectionData connection}) =
      _$addConnectionImpl;

  ConnectionData get connection;
  @JsonKey(ignore: true)
  _$$addConnectionImplCopyWith<_$addConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$updateConnectionImplCopyWith<$Res> {
  factory _$$updateConnectionImplCopyWith(_$updateConnectionImpl value,
          $Res Function(_$updateConnectionImpl) then) =
      __$$updateConnectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ConnectionData connection});

  $ConnectionDataCopyWith<$Res> get connection;
}

/// @nodoc
class __$$updateConnectionImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res, _$updateConnectionImpl>
    implements _$$updateConnectionImplCopyWith<$Res> {
  __$$updateConnectionImplCopyWithImpl(_$updateConnectionImpl _value,
      $Res Function(_$updateConnectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connection = null,
  }) {
    return _then(_$updateConnectionImpl(
      connection: null == connection
          ? _value.connection
          : connection // ignore: cast_nullable_to_non_nullable
              as ConnectionData,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionDataCopyWith<$Res> get connection {
    return $ConnectionDataCopyWith<$Res>(_value.connection, (value) {
      return _then(_value.copyWith(connection: value));
    });
  }
}

/// @nodoc

class _$updateConnectionImpl implements _updateConnection {
  const _$updateConnectionImpl({required this.connection});

  @override
  final ConnectionData connection;

  @override
  String toString() {
    return 'ManageNetworksEvent.updateConnection(connection: $connection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$updateConnectionImpl &&
            (identical(other.connection, connection) ||
                other.connection == connection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, connection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$updateConnectionImplCopyWith<_$updateConnectionImpl> get copyWith =>
      __$$updateConnectionImplCopyWithImpl<_$updateConnectionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return updateConnection(connection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return updateConnection?.call(connection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (updateConnection != null) {
      return updateConnection(connection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return updateConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return updateConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (updateConnection != null) {
      return updateConnection(this);
    }
    return orElse();
  }
}

abstract class _updateConnection implements ManageNetworksEvent {
  const factory _updateConnection({required final ConnectionData connection}) =
      _$updateConnectionImpl;

  ConnectionData get connection;
  @JsonKey(ignore: true)
  _$$updateConnectionImplCopyWith<_$updateConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$removeConnectionImplCopyWith<$Res> {
  factory _$$removeConnectionImplCopyWith(_$removeConnectionImpl value,
          $Res Function(_$removeConnectionImpl) then) =
      __$$removeConnectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$removeConnectionImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res, _$removeConnectionImpl>
    implements _$$removeConnectionImplCopyWith<$Res> {
  __$$removeConnectionImplCopyWithImpl(_$removeConnectionImpl _value,
      $Res Function(_$removeConnectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$removeConnectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$removeConnectionImpl implements _removeConnection {
  const _$removeConnectionImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'ManageNetworksEvent.removeConnection(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$removeConnectionImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$removeConnectionImplCopyWith<_$removeConnectionImpl> get copyWith =>
      __$$removeConnectionImplCopyWithImpl<_$removeConnectionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return removeConnection(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return removeConnection?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (removeConnection != null) {
      return removeConnection(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return removeConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return removeConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (removeConnection != null) {
      return removeConnection(this);
    }
    return orElse();
  }
}

abstract class _removeConnection implements ManageNetworksEvent {
  const factory _removeConnection({required final String id}) =
      _$removeConnectionImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$removeConnectionImplCopyWith<_$removeConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$revertConnectionImplCopyWith<$Res> {
  factory _$$revertConnectionImplCopyWith(_$revertConnectionImpl value,
          $Res Function(_$revertConnectionImpl) then) =
      __$$revertConnectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$revertConnectionImplCopyWithImpl<$Res>
    extends _$ManageNetworksEventCopyWithImpl<$Res, _$revertConnectionImpl>
    implements _$$revertConnectionImplCopyWith<$Res> {
  __$$revertConnectionImplCopyWithImpl(_$revertConnectionImpl _value,
      $Res Function(_$revertConnectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$revertConnectionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$revertConnectionImpl implements _revertConnection {
  const _$revertConnectionImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'ManageNetworksEvent.revertConnection(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$revertConnectionImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$revertConnectionImplCopyWith<_$revertConnectionImpl> get copyWith =>
      __$$revertConnectionImplCopyWithImpl<_$revertConnectionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id) setCurrentConnectionId,
    required TResult Function(List<ConnectionData> connections) setConnections,
    required TResult Function(String id) updateCurrentConnectionId,
    required TResult Function(ConnectionData connection) addConnection,
    required TResult Function(ConnectionData connection) updateConnection,
    required TResult Function(String id) removeConnection,
    required TResult Function(String id) revertConnection,
  }) {
    return revertConnection(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id)? setCurrentConnectionId,
    TResult? Function(List<ConnectionData> connections)? setConnections,
    TResult? Function(String id)? updateCurrentConnectionId,
    TResult? Function(ConnectionData connection)? addConnection,
    TResult? Function(ConnectionData connection)? updateConnection,
    TResult? Function(String id)? removeConnection,
    TResult? Function(String id)? revertConnection,
  }) {
    return revertConnection?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id)? setCurrentConnectionId,
    TResult Function(List<ConnectionData> connections)? setConnections,
    TResult Function(String id)? updateCurrentConnectionId,
    TResult Function(ConnectionData connection)? addConnection,
    TResult Function(ConnectionData connection)? updateConnection,
    TResult Function(String id)? removeConnection,
    TResult Function(String id)? revertConnection,
    required TResult orElse(),
  }) {
    if (revertConnection != null) {
      return revertConnection(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_setCurrentConnectionId value)
        setCurrentConnectionId,
    required TResult Function(_setConnections value) setConnections,
    required TResult Function(_updateCurrentConnectionId value)
        updateCurrentConnectionId,
    required TResult Function(_addConnection value) addConnection,
    required TResult Function(_updateConnection value) updateConnection,
    required TResult Function(_removeConnection value) removeConnection,
    required TResult Function(_revertConnection value) revertConnection,
  }) {
    return revertConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult? Function(_setConnections value)? setConnections,
    TResult? Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult? Function(_addConnection value)? addConnection,
    TResult? Function(_updateConnection value)? updateConnection,
    TResult? Function(_removeConnection value)? removeConnection,
    TResult? Function(_revertConnection value)? revertConnection,
  }) {
    return revertConnection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_setCurrentConnectionId value)? setCurrentConnectionId,
    TResult Function(_setConnections value)? setConnections,
    TResult Function(_updateCurrentConnectionId value)?
        updateCurrentConnectionId,
    TResult Function(_addConnection value)? addConnection,
    TResult Function(_updateConnection value)? updateConnection,
    TResult Function(_removeConnection value)? removeConnection,
    TResult Function(_revertConnection value)? revertConnection,
    required TResult orElse(),
  }) {
    if (revertConnection != null) {
      return revertConnection(this);
    }
    return orElse();
  }
}

abstract class _revertConnection implements ManageNetworksEvent {
  const factory _revertConnection({required final String id}) =
      _$revertConnectionImpl;

  String get id;
  @JsonKey(ignore: true)
  _$$revertConnectionImplCopyWith<_$revertConnectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ManageNetworksState {
  String get currentConnectionId => throw _privateConstructorUsedError;
  List<ConnectionData> get connections => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ManageNetworksStateCopyWith<ManageNetworksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ManageNetworksStateCopyWith<$Res> {
  factory $ManageNetworksStateCopyWith(
          ManageNetworksState value, $Res Function(ManageNetworksState) then) =
      _$ManageNetworksStateCopyWithImpl<$Res, ManageNetworksState>;
  @useResult
  $Res call({String currentConnectionId, List<ConnectionData> connections});
}

/// @nodoc
class _$ManageNetworksStateCopyWithImpl<$Res, $Val extends ManageNetworksState>
    implements $ManageNetworksStateCopyWith<$Res> {
  _$ManageNetworksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentConnectionId = null,
    Object? connections = null,
  }) {
    return _then(_value.copyWith(
      currentConnectionId: null == currentConnectionId
          ? _value.currentConnectionId
          : currentConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      connections: null == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<ConnectionData>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ManageNetworksStateImplCopyWith<$Res>
    implements $ManageNetworksStateCopyWith<$Res> {
  factory _$$ManageNetworksStateImplCopyWith(_$ManageNetworksStateImpl value,
          $Res Function(_$ManageNetworksStateImpl) then) =
      __$$ManageNetworksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String currentConnectionId, List<ConnectionData> connections});
}

/// @nodoc
class __$$ManageNetworksStateImplCopyWithImpl<$Res>
    extends _$ManageNetworksStateCopyWithImpl<$Res, _$ManageNetworksStateImpl>
    implements _$$ManageNetworksStateImplCopyWith<$Res> {
  __$$ManageNetworksStateImplCopyWithImpl(_$ManageNetworksStateImpl _value,
      $Res Function(_$ManageNetworksStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentConnectionId = null,
    Object? connections = null,
  }) {
    return _then(_$ManageNetworksStateImpl(
      currentConnectionId: null == currentConnectionId
          ? _value.currentConnectionId
          : currentConnectionId // ignore: cast_nullable_to_non_nullable
              as String,
      connections: null == connections
          ? _value._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<ConnectionData>,
    ));
  }
}

/// @nodoc

class _$ManageNetworksStateImpl implements _ManageNetworksState {
  const _$ManageNetworksStateImpl(
      {required this.currentConnectionId,
      required final List<ConnectionData> connections})
      : _connections = connections;

  @override
  final String currentConnectionId;
  final List<ConnectionData> _connections;
  @override
  List<ConnectionData> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  @override
  String toString() {
    return 'ManageNetworksState(currentConnectionId: $currentConnectionId, connections: $connections)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ManageNetworksStateImpl &&
            (identical(other.currentConnectionId, currentConnectionId) ||
                other.currentConnectionId == currentConnectionId) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections));
  }

  @override
  int get hashCode => Object.hash(runtimeType, currentConnectionId,
      const DeepCollectionEquality().hash(_connections));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ManageNetworksStateImplCopyWith<_$ManageNetworksStateImpl> get copyWith =>
      __$$ManageNetworksStateImplCopyWithImpl<_$ManageNetworksStateImpl>(
          this, _$identity);
}

abstract class _ManageNetworksState implements ManageNetworksState {
  const factory _ManageNetworksState(
          {required final String currentConnectionId,
          required final List<ConnectionData> connections}) =
      _$ManageNetworksStateImpl;

  @override
  String get currentConnectionId;
  @override
  List<ConnectionData> get connections;
  @override
  @JsonKey(ignore: true)
  _$$ManageNetworksStateImplCopyWith<_$ManageNetworksStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
