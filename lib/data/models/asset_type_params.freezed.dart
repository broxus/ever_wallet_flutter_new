// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'asset_type_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AssetTypeParams _$AssetTypeParamsFromJson(Map<String, dynamic> json) {
  return _AssetTypeParams.fromJson(json);
}

/// @nodoc
mixin _$AssetTypeParams {
  String get rootContract => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AssetTypeParamsCopyWith<AssetTypeParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AssetTypeParamsCopyWith<$Res> {
  factory $AssetTypeParamsCopyWith(
          AssetTypeParams value, $Res Function(AssetTypeParams) then) =
      _$AssetTypeParamsCopyWithImpl<$Res, AssetTypeParams>;
  @useResult
  $Res call({String rootContract});
}

/// @nodoc
class _$AssetTypeParamsCopyWithImpl<$Res, $Val extends AssetTypeParams>
    implements $AssetTypeParamsCopyWith<$Res> {
  _$AssetTypeParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootContract = null,
  }) {
    return _then(_value.copyWith(
      rootContract: null == rootContract
          ? _value.rootContract
          : rootContract // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AssetTypeParamsImplCopyWith<$Res>
    implements $AssetTypeParamsCopyWith<$Res> {
  factory _$$AssetTypeParamsImplCopyWith(_$AssetTypeParamsImpl value,
          $Res Function(_$AssetTypeParamsImpl) then) =
      __$$AssetTypeParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String rootContract});
}

/// @nodoc
class __$$AssetTypeParamsImplCopyWithImpl<$Res>
    extends _$AssetTypeParamsCopyWithImpl<$Res, _$AssetTypeParamsImpl>
    implements _$$AssetTypeParamsImplCopyWith<$Res> {
  __$$AssetTypeParamsImplCopyWithImpl(
      _$AssetTypeParamsImpl _value, $Res Function(_$AssetTypeParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rootContract = null,
  }) {
    return _then(_$AssetTypeParamsImpl(
      rootContract: null == rootContract
          ? _value.rootContract
          : rootContract // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AssetTypeParamsImpl implements _AssetTypeParams {
  const _$AssetTypeParamsImpl({required this.rootContract});

  factory _$AssetTypeParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AssetTypeParamsImplFromJson(json);

  @override
  final String rootContract;

  @override
  String toString() {
    return 'AssetTypeParams(rootContract: $rootContract)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AssetTypeParamsImpl &&
            (identical(other.rootContract, rootContract) ||
                other.rootContract == rootContract));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, rootContract);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AssetTypeParamsImplCopyWith<_$AssetTypeParamsImpl> get copyWith =>
      __$$AssetTypeParamsImplCopyWithImpl<_$AssetTypeParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AssetTypeParamsImplToJson(
      this,
    );
  }
}

abstract class _AssetTypeParams implements AssetTypeParams {
  const factory _AssetTypeParams({required final String rootContract}) =
      _$AssetTypeParamsImpl;

  factory _AssetTypeParams.fromJson(Map<String, dynamic> json) =
      _$AssetTypeParamsImpl.fromJson;

  @override
  String get rootContract;
  @override
  @JsonKey(ignore: true)
  _$$AssetTypeParamsImplCopyWith<_$AssetTypeParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
