// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NavigationServiceState _$NavigationServiceStateFromJson(
    Map<String, dynamic> json) {
  return _NavigationServiceState.fromJson(json);
}

/// @nodoc
mixin _$NavigationServiceState {
  String get location => throw _privateConstructorUsedError;
  String get fullPath => throw _privateConstructorUsedError;

  /// Serializes this NavigationServiceState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NavigationServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavigationServiceStateCopyWith<NavigationServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationServiceStateCopyWith<$Res> {
  factory $NavigationServiceStateCopyWith(NavigationServiceState value,
          $Res Function(NavigationServiceState) then) =
      _$NavigationServiceStateCopyWithImpl<$Res, NavigationServiceState>;
  @useResult
  $Res call({String location, String fullPath});
}

/// @nodoc
class _$NavigationServiceStateCopyWithImpl<$Res,
        $Val extends NavigationServiceState>
    implements $NavigationServiceStateCopyWith<$Res> {
  _$NavigationServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavigationServiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? fullPath = null,
  }) {
    return _then(_value.copyWith(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      fullPath: null == fullPath
          ? _value.fullPath
          : fullPath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NavigationServiceStateImplCopyWith<$Res>
    implements $NavigationServiceStateCopyWith<$Res> {
  factory _$$NavigationServiceStateImplCopyWith(
          _$NavigationServiceStateImpl value,
          $Res Function(_$NavigationServiceStateImpl) then) =
      __$$NavigationServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String location, String fullPath});
}

/// @nodoc
class __$$NavigationServiceStateImplCopyWithImpl<$Res>
    extends _$NavigationServiceStateCopyWithImpl<$Res,
        _$NavigationServiceStateImpl>
    implements _$$NavigationServiceStateImplCopyWith<$Res> {
  __$$NavigationServiceStateImplCopyWithImpl(
      _$NavigationServiceStateImpl _value,
      $Res Function(_$NavigationServiceStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NavigationServiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = null,
    Object? fullPath = null,
  }) {
    return _then(_$NavigationServiceStateImpl(
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String,
      fullPath: null == fullPath
          ? _value.fullPath
          : fullPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NavigationServiceStateImpl implements _NavigationServiceState {
  const _$NavigationServiceStateImpl(
      {required this.location, required this.fullPath});

  factory _$NavigationServiceStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NavigationServiceStateImplFromJson(json);

  @override
  final String location;
  @override
  final String fullPath;

  @override
  String toString() {
    return 'NavigationServiceState(location: $location, fullPath: $fullPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavigationServiceStateImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.fullPath, fullPath) ||
                other.fullPath == fullPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, location, fullPath);

  /// Create a copy of NavigationServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavigationServiceStateImplCopyWith<_$NavigationServiceStateImpl>
      get copyWith => __$$NavigationServiceStateImplCopyWithImpl<
          _$NavigationServiceStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NavigationServiceStateImplToJson(
      this,
    );
  }
}

abstract class _NavigationServiceState implements NavigationServiceState {
  const factory _NavigationServiceState(
      {required final String location,
      required final String fullPath}) = _$NavigationServiceStateImpl;

  factory _NavigationServiceState.fromJson(Map<String, dynamic> json) =
      _$NavigationServiceStateImpl.fromJson;

  @override
  String get location;
  @override
  String get fullPath;

  /// Create a copy of NavigationServiceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavigationServiceStateImplCopyWith<_$NavigationServiceStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
