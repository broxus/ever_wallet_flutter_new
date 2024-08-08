// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PermissionsDto {
  @HiveField(0)
  bool? get basic => throw _privateConstructorUsedError;
  @HiveField(1)
  AccountInteractionDto? get accountInteraction =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PermissionsDtoCopyWith<PermissionsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermissionsDtoCopyWith<$Res> {
  factory $PermissionsDtoCopyWith(
          PermissionsDto value, $Res Function(PermissionsDto) then) =
      _$PermissionsDtoCopyWithImpl<$Res, PermissionsDto>;
  @useResult
  $Res call(
      {@HiveField(0) bool? basic,
      @HiveField(1) AccountInteractionDto? accountInteraction});

  $AccountInteractionDtoCopyWith<$Res>? get accountInteraction;
}

/// @nodoc
class _$PermissionsDtoCopyWithImpl<$Res, $Val extends PermissionsDto>
    implements $PermissionsDtoCopyWith<$Res> {
  _$PermissionsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
              as AccountInteractionDto?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AccountInteractionDtoCopyWith<$Res>? get accountInteraction {
    if (_value.accountInteraction == null) {
      return null;
    }

    return $AccountInteractionDtoCopyWith<$Res>(_value.accountInteraction!,
        (value) {
      return _then(_value.copyWith(accountInteraction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PermissionsDtoImplCopyWith<$Res>
    implements $PermissionsDtoCopyWith<$Res> {
  factory _$$PermissionsDtoImplCopyWith(_$PermissionsDtoImpl value,
          $Res Function(_$PermissionsDtoImpl) then) =
      __$$PermissionsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) bool? basic,
      @HiveField(1) AccountInteractionDto? accountInteraction});

  @override
  $AccountInteractionDtoCopyWith<$Res>? get accountInteraction;
}

/// @nodoc
class __$$PermissionsDtoImplCopyWithImpl<$Res>
    extends _$PermissionsDtoCopyWithImpl<$Res, _$PermissionsDtoImpl>
    implements _$$PermissionsDtoImplCopyWith<$Res> {
  __$$PermissionsDtoImplCopyWithImpl(
      _$PermissionsDtoImpl _value, $Res Function(_$PermissionsDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? basic = freezed,
    Object? accountInteraction = freezed,
  }) {
    return _then(_$PermissionsDtoImpl(
      basic: freezed == basic
          ? _value.basic
          : basic // ignore: cast_nullable_to_non_nullable
              as bool?,
      accountInteraction: freezed == accountInteraction
          ? _value.accountInteraction
          : accountInteraction // ignore: cast_nullable_to_non_nullable
              as AccountInteractionDto?,
    ));
  }
}

/// @nodoc

@HiveType(typeId: 223)
class _$PermissionsDtoImpl implements _PermissionsDto {
  const _$PermissionsDtoImpl(
      {@HiveField(0) this.basic, @HiveField(1) this.accountInteraction});

  @override
  @HiveField(0)
  final bool? basic;
  @override
  @HiveField(1)
  final AccountInteractionDto? accountInteraction;

  @override
  String toString() {
    return 'PermissionsDto(basic: $basic, accountInteraction: $accountInteraction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionsDtoImpl &&
            (identical(other.basic, basic) || other.basic == basic) &&
            (identical(other.accountInteraction, accountInteraction) ||
                other.accountInteraction == accountInteraction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, basic, accountInteraction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionsDtoImplCopyWith<_$PermissionsDtoImpl> get copyWith =>
      __$$PermissionsDtoImplCopyWithImpl<_$PermissionsDtoImpl>(
          this, _$identity);
}

abstract class _PermissionsDto implements PermissionsDto {
  const factory _PermissionsDto(
          {@HiveField(0) final bool? basic,
          @HiveField(1) final AccountInteractionDto? accountInteraction}) =
      _$PermissionsDtoImpl;

  @override
  @HiveField(0)
  bool? get basic;
  @override
  @HiveField(1)
  AccountInteractionDto? get accountInteraction;
  @override
  @JsonKey(ignore: true)
  _$$PermissionsDtoImplCopyWith<_$PermissionsDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
