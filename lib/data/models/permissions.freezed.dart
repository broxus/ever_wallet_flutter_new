// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Permissions _$PermissionsFromJson(Map<String, dynamic> json) {
  return _Permissions.fromJson(json);
}

/// @nodoc
mixin _$Permissions {
  @JsonKey(includeIfNull: false)
  bool? get basic => throw _privateConstructorUsedError;
  @JsonKey(includeIfNull: false)
  AccountInteraction? get accountInteraction =>
      throw _privateConstructorUsedError;

  /// Serializes this Permissions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PermissionsCopyWith<Permissions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionsCopyWith<$Res> {
  factory $PermissionsCopyWith(
          Permissions value, $Res Function(Permissions) then) =
      _$PermissionsCopyWithImpl<$Res, Permissions>;
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) bool? basic,
      @JsonKey(includeIfNull: false) AccountInteraction? accountInteraction});

  $AccountInteractionCopyWith<$Res>? get accountInteraction;
}

/// @nodoc
class _$PermissionsCopyWithImpl<$Res, $Val extends Permissions>
    implements $PermissionsCopyWith<$Res> {
  _$PermissionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basic = freezed,
    Object? accountInteraction = freezed,
  }) {
    return _then(_value.copyWith(
      basic: freezed == basic
          ? _value.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as bool?,
      accountInteraction: freezed == accountInteraction
          ? _value.accountInteraction
          : accountInteraction // ignore: cast_nullable_to_non_nullable
              as AccountInteraction?,
    ) as $Val);
  }

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AccountInteractionCopyWith<$Res>? get accountInteraction {
    if (_value.accountInteraction == null) {
      return null;
    }

    return $AccountInteractionCopyWith<$Res>(_value.accountInteraction!,
        (value) {
      return _then(_value.copyWith(accountInteraction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PermissionsImplCopyWith<$Res>
    implements $PermissionsCopyWith<$Res> {
  factory _$$PermissionsImplCopyWith(
          _$PermissionsImpl value, $Res Function(_$PermissionsImpl) then) =
      __$$PermissionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeIfNull: false) bool? basic,
      @JsonKey(includeIfNull: false) AccountInteraction? accountInteraction});

  @override
  $AccountInteractionCopyWith<$Res>? get accountInteraction;
}

/// @nodoc
class __$$PermissionsImplCopyWithImpl<$Res>
    extends _$PermissionsCopyWithImpl<$Res, _$PermissionsImpl>
    implements _$$PermissionsImplCopyWith<$Res> {
  __$$PermissionsImplCopyWithImpl(
      _$PermissionsImpl _value, $Res Function(_$PermissionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basic = freezed,
    Object? accountInteraction = freezed,
  }) {
    return _then(_$PermissionsImpl(
      basic: freezed == basic
          ? _value.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as bool?,
      accountInteraction: freezed == accountInteraction
          ? _value.accountInteraction
          : accountInteraction // ignore: cast_nullable_to_non_nullable
              as AccountInteraction?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PermissionsImpl extends _Permissions {
  const _$PermissionsImpl(
      {@JsonKey(includeIfNull: false) this.basic,
      @JsonKey(includeIfNull: false) this.accountInteraction})
      : super._();

  factory _$PermissionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PermissionsImplFromJson(json);

  @override
  @JsonKey(includeIfNull: false)
  final bool? basic;
  @override
  @JsonKey(includeIfNull: false)
  final AccountInteraction? accountInteraction;

  @override
  String toString() {
    return 'Permissions(basic: $basic, accountInteraction: $accountInteraction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionsImpl &&
            (identical(other.basic, basic) || other.basic == basic) &&
            (identical(other.accountInteraction, accountInteraction) ||
                other.accountInteraction == accountInteraction));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, basic, accountInteraction);

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionsImplCopyWith<_$PermissionsImpl> get copyWith =>
      __$$PermissionsImplCopyWithImpl<_$PermissionsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PermissionsImplToJson(
      this,
    );
  }
}

abstract class _Permissions extends Permissions {
  const factory _Permissions(
      {@JsonKey(includeIfNull: false) final bool? basic,
      @JsonKey(includeIfNull: false)
      final AccountInteraction? accountInteraction}) = _$PermissionsImpl;
  const _Permissions._() : super._();

  factory _Permissions.fromJson(Map<String, dynamic> json) =
      _$PermissionsImpl.fromJson;

  @override
  @JsonKey(includeIfNull: false)
  bool? get basic;
  @override
  @JsonKey(includeIfNull: false)
  AccountInteraction? get accountInteraction;

  /// Create a copy of Permissions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionsImplCopyWith<_$PermissionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
