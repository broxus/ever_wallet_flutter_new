// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConnectionData _$ConnectionDataFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'gql':
      return _ConnectionDataGql.fromJson(json);
    case 'proto':
      return _ConnectionDataProto.fromJson(json);
    case 'jrpc':
      return _ConnectionDataJrpc.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'ConnectionData',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$ConnectionData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get group => throw _privateConstructorUsedError;
  String get networkType => throw _privateConstructorUsedError;
  String get blockExplorerUrl => throw _privateConstructorUsedError;
  String get nativeTokenTicker => throw _privateConstructorUsedError;
  bool get isPreset => throw _privateConstructorUsedError;
  bool get canBeEdited => throw _privateConstructorUsedError;
  double get sortingOrder => throw _privateConstructorUsedError;
  bool get isUsedOnStart => throw _privateConstructorUsedError;
  String get manifestUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)
        gql,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        proto,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        jrpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionDataGql value) gql,
    required TResult Function(_ConnectionDataProto value) proto,
    required TResult Function(_ConnectionDataJrpc value) jrpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionDataGql value)? gql,
    TResult? Function(_ConnectionDataProto value)? proto,
    TResult? Function(_ConnectionDataJrpc value)? jrpc,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionDataGql value)? gql,
    TResult Function(_ConnectionDataProto value)? proto,
    TResult Function(_ConnectionDataJrpc value)? jrpc,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this ConnectionData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionDataCopyWith<ConnectionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionDataCopyWith<$Res> {
  factory $ConnectionDataCopyWith(
          ConnectionData value, $Res Function(ConnectionData) then) =
      _$ConnectionDataCopyWithImpl<$Res, ConnectionData>;
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      String networkType,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl});
}

/// @nodoc
class _$ConnectionDataCopyWithImpl<$Res, $Val extends ConnectionData>
    implements $ConnectionDataCopyWith<$Res> {
  _$ConnectionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? networkType = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      blockExplorerUrl: null == blockExplorerUrl
          ? _value.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _value.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _value.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _value.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _value.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionDataGqlImplCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory _$$ConnectionDataGqlImplCopyWith(_$ConnectionDataGqlImpl value,
          $Res Function(_$ConnectionDataGqlImpl) then) =
      __$$ConnectionDataGqlImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      List<String> endpoints,
      String networkType,
      bool isLocal,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl,
      int? latencyDetectionInterval,
      int? maxLatency,
      int? endpointSelectionRetryCount});
}

/// @nodoc
class __$$ConnectionDataGqlImplCopyWithImpl<$Res>
    extends _$ConnectionDataCopyWithImpl<$Res, _$ConnectionDataGqlImpl>
    implements _$$ConnectionDataGqlImplCopyWith<$Res> {
  __$$ConnectionDataGqlImplCopyWithImpl(_$ConnectionDataGqlImpl _value,
      $Res Function(_$ConnectionDataGqlImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? endpoints = null,
    Object? networkType = null,
    Object? isLocal = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
    Object? latencyDetectionInterval = freezed,
    Object? maxLatency = freezed,
    Object? endpointSelectionRetryCount = freezed,
  }) {
    return _then(_$ConnectionDataGqlImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      endpoints: null == endpoints
          ? _value._endpoints
          : endpoints // ignore: cast_nullable_to_non_nullable
              as List<String>,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      isLocal: null == isLocal
          ? _value.isLocal
          : isLocal // ignore: cast_nullable_to_non_nullable
              as bool,
      blockExplorerUrl: null == blockExplorerUrl
          ? _value.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _value.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _value.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _value.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _value.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
      latencyDetectionInterval: freezed == latencyDetectionInterval
          ? _value.latencyDetectionInterval
          : latencyDetectionInterval // ignore: cast_nullable_to_non_nullable
              as int?,
      maxLatency: freezed == maxLatency
          ? _value.maxLatency
          : maxLatency // ignore: cast_nullable_to_non_nullable
              as int?,
      endpointSelectionRetryCount: freezed == endpointSelectionRetryCount
          ? _value.endpointSelectionRetryCount
          : endpointSelectionRetryCount // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionDataGqlImpl implements _ConnectionDataGql {
  const _$ConnectionDataGqlImpl(
      {required this.id,
      required this.name,
      required this.group,
      required final List<String> endpoints,
      required this.networkType,
      required this.isLocal,
      required this.blockExplorerUrl,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.sortingOrder,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      this.latencyDetectionInterval,
      this.maxLatency,
      this.endpointSelectionRetryCount,
      final String? $type})
      : _endpoints = endpoints,
        $type = $type ?? 'gql';

  factory _$ConnectionDataGqlImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionDataGqlImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String group;
  final List<String> _endpoints;
  @override
  List<String> get endpoints {
    if (_endpoints is EqualUnmodifiableListView) return _endpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_endpoints);
  }

  @override
  final String networkType;
  @override
  final bool isLocal;
  @override
  final String blockExplorerUrl;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;
  @override
  final int? latencyDetectionInterval;
  @override
  final int? maxLatency;
  @override
  final int? endpointSelectionRetryCount;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConnectionData.gql(id: $id, name: $name, group: $group, endpoints: $endpoints, networkType: $networkType, isLocal: $isLocal, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl, latencyDetectionInterval: $latencyDetectionInterval, maxLatency: $maxLatency, endpointSelectionRetryCount: $endpointSelectionRetryCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionDataGqlImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            const DeepCollectionEquality()
                .equals(other._endpoints, _endpoints) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.isLocal, isLocal) || other.isLocal == isLocal) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl) &&
            (identical(
                    other.latencyDetectionInterval, latencyDetectionInterval) ||
                other.latencyDetectionInterval == latencyDetectionInterval) &&
            (identical(other.maxLatency, maxLatency) ||
                other.maxLatency == maxLatency) &&
            (identical(other.endpointSelectionRetryCount,
                    endpointSelectionRetryCount) ||
                other.endpointSelectionRetryCount ==
                    endpointSelectionRetryCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      const DeepCollectionEquality().hash(_endpoints),
      networkType,
      isLocal,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl,
      latencyDetectionInterval,
      maxLatency,
      endpointSelectionRetryCount);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionDataGqlImplCopyWith<_$ConnectionDataGqlImpl> get copyWith =>
      __$$ConnectionDataGqlImplCopyWithImpl<_$ConnectionDataGqlImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)
        gql,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        proto,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        jrpc,
  }) {
    return gql(
        id,
        name,
        group,
        endpoints,
        networkType,
        isLocal,
        blockExplorerUrl,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        sortingOrder,
        isUsedOnStart,
        manifestUrl,
        latencyDetectionInterval,
        maxLatency,
        endpointSelectionRetryCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
  }) {
    return gql?.call(
        id,
        name,
        group,
        endpoints,
        networkType,
        isLocal,
        blockExplorerUrl,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        sortingOrder,
        isUsedOnStart,
        manifestUrl,
        latencyDetectionInterval,
        maxLatency,
        endpointSelectionRetryCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
    required TResult orElse(),
  }) {
    if (gql != null) {
      return gql(
          id,
          name,
          group,
          endpoints,
          networkType,
          isLocal,
          blockExplorerUrl,
          nativeTokenTicker,
          isPreset,
          canBeEdited,
          sortingOrder,
          isUsedOnStart,
          manifestUrl,
          latencyDetectionInterval,
          maxLatency,
          endpointSelectionRetryCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionDataGql value) gql,
    required TResult Function(_ConnectionDataProto value) proto,
    required TResult Function(_ConnectionDataJrpc value) jrpc,
  }) {
    return gql(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionDataGql value)? gql,
    TResult? Function(_ConnectionDataProto value)? proto,
    TResult? Function(_ConnectionDataJrpc value)? jrpc,
  }) {
    return gql?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionDataGql value)? gql,
    TResult Function(_ConnectionDataProto value)? proto,
    TResult Function(_ConnectionDataJrpc value)? jrpc,
    required TResult orElse(),
  }) {
    if (gql != null) {
      return gql(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionDataGqlImplToJson(
      this,
    );
  }
}

abstract class _ConnectionDataGql implements ConnectionData {
  const factory _ConnectionDataGql(
      {required final String id,
      required final String name,
      required final String group,
      required final List<String> endpoints,
      required final String networkType,
      required final bool isLocal,
      required final String blockExplorerUrl,
      required final String nativeTokenTicker,
      required final bool isPreset,
      required final bool canBeEdited,
      required final double sortingOrder,
      final bool isUsedOnStart,
      final String manifestUrl,
      final int? latencyDetectionInterval,
      final int? maxLatency,
      final int? endpointSelectionRetryCount}) = _$ConnectionDataGqlImpl;

  factory _ConnectionDataGql.fromJson(Map<String, dynamic> json) =
      _$ConnectionDataGqlImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get group;
  List<String> get endpoints;
  @override
  String get networkType;
  bool get isLocal;
  @override
  String get blockExplorerUrl;
  @override
  String get nativeTokenTicker;
  @override
  bool get isPreset;
  @override
  bool get canBeEdited;
  @override
  double get sortingOrder;
  @override
  bool get isUsedOnStart;
  @override
  String get manifestUrl;
  int? get latencyDetectionInterval;
  int? get maxLatency;
  int? get endpointSelectionRetryCount;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionDataGqlImplCopyWith<_$ConnectionDataGqlImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionDataProtoImplCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory _$$ConnectionDataProtoImplCopyWith(_$ConnectionDataProtoImpl value,
          $Res Function(_$ConnectionDataProtoImpl) then) =
      __$$ConnectionDataProtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      String endpoint,
      String networkType,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl});
}

/// @nodoc
class __$$ConnectionDataProtoImplCopyWithImpl<$Res>
    extends _$ConnectionDataCopyWithImpl<$Res, _$ConnectionDataProtoImpl>
    implements _$$ConnectionDataProtoImplCopyWith<$Res> {
  __$$ConnectionDataProtoImplCopyWithImpl(_$ConnectionDataProtoImpl _value,
      $Res Function(_$ConnectionDataProtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? endpoint = null,
    Object? networkType = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
  }) {
    return _then(_$ConnectionDataProtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      blockExplorerUrl: null == blockExplorerUrl
          ? _value.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _value.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _value.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _value.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _value.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionDataProtoImpl implements _ConnectionDataProto {
  const _$ConnectionDataProtoImpl(
      {required this.id,
      required this.name,
      required this.group,
      required this.endpoint,
      required this.networkType,
      required this.blockExplorerUrl,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.sortingOrder,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      final String? $type})
      : $type = $type ?? 'proto';

  factory _$ConnectionDataProtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionDataProtoImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String group;
  @override
  final String endpoint;
  @override
  final String networkType;
  @override
  final String blockExplorerUrl;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConnectionData.proto(id: $id, name: $name, group: $group, endpoint: $endpoint, networkType: $networkType, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionDataProtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      endpoint,
      networkType,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionDataProtoImplCopyWith<_$ConnectionDataProtoImpl> get copyWith =>
      __$$ConnectionDataProtoImplCopyWithImpl<_$ConnectionDataProtoImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)
        gql,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        proto,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        jrpc,
  }) {
    return proto(
        id,
        name,
        group,
        endpoint,
        networkType,
        blockExplorerUrl,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        sortingOrder,
        isUsedOnStart,
        manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
  }) {
    return proto?.call(
        id,
        name,
        group,
        endpoint,
        networkType,
        blockExplorerUrl,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        sortingOrder,
        isUsedOnStart,
        manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
    required TResult orElse(),
  }) {
    if (proto != null) {
      return proto(
          id,
          name,
          group,
          endpoint,
          networkType,
          blockExplorerUrl,
          nativeTokenTicker,
          isPreset,
          canBeEdited,
          sortingOrder,
          isUsedOnStart,
          manifestUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionDataGql value) gql,
    required TResult Function(_ConnectionDataProto value) proto,
    required TResult Function(_ConnectionDataJrpc value) jrpc,
  }) {
    return proto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionDataGql value)? gql,
    TResult? Function(_ConnectionDataProto value)? proto,
    TResult? Function(_ConnectionDataJrpc value)? jrpc,
  }) {
    return proto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionDataGql value)? gql,
    TResult Function(_ConnectionDataProto value)? proto,
    TResult Function(_ConnectionDataJrpc value)? jrpc,
    required TResult orElse(),
  }) {
    if (proto != null) {
      return proto(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionDataProtoImplToJson(
      this,
    );
  }
}

abstract class _ConnectionDataProto implements ConnectionData {
  const factory _ConnectionDataProto(
      {required final String id,
      required final String name,
      required final String group,
      required final String endpoint,
      required final String networkType,
      required final String blockExplorerUrl,
      required final String nativeTokenTicker,
      required final bool isPreset,
      required final bool canBeEdited,
      required final double sortingOrder,
      final bool isUsedOnStart,
      final String manifestUrl}) = _$ConnectionDataProtoImpl;

  factory _ConnectionDataProto.fromJson(Map<String, dynamic> json) =
      _$ConnectionDataProtoImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get group;
  String get endpoint;
  @override
  String get networkType;
  @override
  String get blockExplorerUrl;
  @override
  String get nativeTokenTicker;
  @override
  bool get isPreset;
  @override
  bool get canBeEdited;
  @override
  double get sortingOrder;
  @override
  bool get isUsedOnStart;
  @override
  String get manifestUrl;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionDataProtoImplCopyWith<_$ConnectionDataProtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConnectionDataJrpcImplCopyWith<$Res>
    implements $ConnectionDataCopyWith<$Res> {
  factory _$$ConnectionDataJrpcImplCopyWith(_$ConnectionDataJrpcImpl value,
          $Res Function(_$ConnectionDataJrpcImpl) then) =
      __$$ConnectionDataJrpcImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String group,
      String endpoint,
      String networkType,
      String blockExplorerUrl,
      String nativeTokenTicker,
      bool isPreset,
      bool canBeEdited,
      double sortingOrder,
      bool isUsedOnStart,
      String manifestUrl});
}

/// @nodoc
class __$$ConnectionDataJrpcImplCopyWithImpl<$Res>
    extends _$ConnectionDataCopyWithImpl<$Res, _$ConnectionDataJrpcImpl>
    implements _$$ConnectionDataJrpcImplCopyWith<$Res> {
  __$$ConnectionDataJrpcImplCopyWithImpl(_$ConnectionDataJrpcImpl _value,
      $Res Function(_$ConnectionDataJrpcImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? group = null,
    Object? endpoint = null,
    Object? networkType = null,
    Object? blockExplorerUrl = null,
    Object? nativeTokenTicker = null,
    Object? isPreset = null,
    Object? canBeEdited = null,
    Object? sortingOrder = null,
    Object? isUsedOnStart = null,
    Object? manifestUrl = null,
  }) {
    return _then(_$ConnectionDataJrpcImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as String,
      endpoint: null == endpoint
          ? _value.endpoint
          : endpoint // ignore: cast_nullable_to_non_nullable
              as String,
      networkType: null == networkType
          ? _value.networkType
          : networkType // ignore: cast_nullable_to_non_nullable
              as String,
      blockExplorerUrl: null == blockExplorerUrl
          ? _value.blockExplorerUrl
          : blockExplorerUrl // ignore: cast_nullable_to_non_nullable
              as String,
      nativeTokenTicker: null == nativeTokenTicker
          ? _value.nativeTokenTicker
          : nativeTokenTicker // ignore: cast_nullable_to_non_nullable
              as String,
      isPreset: null == isPreset
          ? _value.isPreset
          : isPreset // ignore: cast_nullable_to_non_nullable
              as bool,
      canBeEdited: null == canBeEdited
          ? _value.canBeEdited
          : canBeEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      sortingOrder: null == sortingOrder
          ? _value.sortingOrder
          : sortingOrder // ignore: cast_nullable_to_non_nullable
              as double,
      isUsedOnStart: null == isUsedOnStart
          ? _value.isUsedOnStart
          : isUsedOnStart // ignore: cast_nullable_to_non_nullable
              as bool,
      manifestUrl: null == manifestUrl
          ? _value.manifestUrl
          : manifestUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionDataJrpcImpl implements _ConnectionDataJrpc {
  const _$ConnectionDataJrpcImpl(
      {required this.id,
      required this.name,
      required this.group,
      required this.endpoint,
      required this.networkType,
      required this.blockExplorerUrl,
      required this.nativeTokenTicker,
      required this.isPreset,
      required this.canBeEdited,
      required this.sortingOrder,
      this.isUsedOnStart = true,
      this.manifestUrl = '',
      final String? $type})
      : $type = $type ?? 'jrpc';

  factory _$ConnectionDataJrpcImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionDataJrpcImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String group;
  @override
  final String endpoint;
  @override
  final String networkType;
  @override
  final String blockExplorerUrl;
  @override
  final String nativeTokenTicker;
  @override
  final bool isPreset;
  @override
  final bool canBeEdited;
  @override
  final double sortingOrder;
  @override
  @JsonKey()
  final bool isUsedOnStart;
  @override
  @JsonKey()
  final String manifestUrl;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'ConnectionData.jrpc(id: $id, name: $name, group: $group, endpoint: $endpoint, networkType: $networkType, blockExplorerUrl: $blockExplorerUrl, nativeTokenTicker: $nativeTokenTicker, isPreset: $isPreset, canBeEdited: $canBeEdited, sortingOrder: $sortingOrder, isUsedOnStart: $isUsedOnStart, manifestUrl: $manifestUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionDataJrpcImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint) &&
            (identical(other.networkType, networkType) ||
                other.networkType == networkType) &&
            (identical(other.blockExplorerUrl, blockExplorerUrl) ||
                other.blockExplorerUrl == blockExplorerUrl) &&
            (identical(other.nativeTokenTicker, nativeTokenTicker) ||
                other.nativeTokenTicker == nativeTokenTicker) &&
            (identical(other.isPreset, isPreset) ||
                other.isPreset == isPreset) &&
            (identical(other.canBeEdited, canBeEdited) ||
                other.canBeEdited == canBeEdited) &&
            (identical(other.sortingOrder, sortingOrder) ||
                other.sortingOrder == sortingOrder) &&
            (identical(other.isUsedOnStart, isUsedOnStart) ||
                other.isUsedOnStart == isUsedOnStart) &&
            (identical(other.manifestUrl, manifestUrl) ||
                other.manifestUrl == manifestUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      group,
      endpoint,
      networkType,
      blockExplorerUrl,
      nativeTokenTicker,
      isPreset,
      canBeEdited,
      sortingOrder,
      isUsedOnStart,
      manifestUrl);

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionDataJrpcImplCopyWith<_$ConnectionDataJrpcImpl> get copyWith =>
      __$$ConnectionDataJrpcImplCopyWithImpl<_$ConnectionDataJrpcImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)
        gql,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        proto,
    required TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)
        jrpc,
  }) {
    return jrpc(
        id,
        name,
        group,
        endpoint,
        networkType,
        blockExplorerUrl,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        sortingOrder,
        isUsedOnStart,
        manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult? Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
  }) {
    return jrpc?.call(
        id,
        name,
        group,
        endpoint,
        networkType,
        blockExplorerUrl,
        nativeTokenTicker,
        isPreset,
        canBeEdited,
        sortingOrder,
        isUsedOnStart,
        manifestUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String name,
            String group,
            List<String> endpoints,
            String networkType,
            bool isLocal,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl,
            int? latencyDetectionInterval,
            int? maxLatency,
            int? endpointSelectionRetryCount)?
        gql,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        proto,
    TResult Function(
            String id,
            String name,
            String group,
            String endpoint,
            String networkType,
            String blockExplorerUrl,
            String nativeTokenTicker,
            bool isPreset,
            bool canBeEdited,
            double sortingOrder,
            bool isUsedOnStart,
            String manifestUrl)?
        jrpc,
    required TResult orElse(),
  }) {
    if (jrpc != null) {
      return jrpc(
          id,
          name,
          group,
          endpoint,
          networkType,
          blockExplorerUrl,
          nativeTokenTicker,
          isPreset,
          canBeEdited,
          sortingOrder,
          isUsedOnStart,
          manifestUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ConnectionDataGql value) gql,
    required TResult Function(_ConnectionDataProto value) proto,
    required TResult Function(_ConnectionDataJrpc value) jrpc,
  }) {
    return jrpc(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ConnectionDataGql value)? gql,
    TResult? Function(_ConnectionDataProto value)? proto,
    TResult? Function(_ConnectionDataJrpc value)? jrpc,
  }) {
    return jrpc?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ConnectionDataGql value)? gql,
    TResult Function(_ConnectionDataProto value)? proto,
    TResult Function(_ConnectionDataJrpc value)? jrpc,
    required TResult orElse(),
  }) {
    if (jrpc != null) {
      return jrpc(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionDataJrpcImplToJson(
      this,
    );
  }
}

abstract class _ConnectionDataJrpc implements ConnectionData {
  const factory _ConnectionDataJrpc(
      {required final String id,
      required final String name,
      required final String group,
      required final String endpoint,
      required final String networkType,
      required final String blockExplorerUrl,
      required final String nativeTokenTicker,
      required final bool isPreset,
      required final bool canBeEdited,
      required final double sortingOrder,
      final bool isUsedOnStart,
      final String manifestUrl}) = _$ConnectionDataJrpcImpl;

  factory _ConnectionDataJrpc.fromJson(Map<String, dynamic> json) =
      _$ConnectionDataJrpcImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get group;
  String get endpoint;
  @override
  String get networkType;
  @override
  String get blockExplorerUrl;
  @override
  String get nativeTokenTicker;
  @override
  bool get isPreset;
  @override
  bool get canBeEdited;
  @override
  double get sortingOrder;
  @override
  bool get isUsedOnStart;
  @override
  String get manifestUrl;

  /// Create a copy of ConnectionData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionDataJrpcImplCopyWith<_$ConnectionDataJrpcImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
