// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'browser_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BrowserBasicAuthCreds {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrowserBasicAuthCredsCopyWith<BrowserBasicAuthCreds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserBasicAuthCredsCopyWith<$Res> {
  factory $BrowserBasicAuthCredsCopyWith(BrowserBasicAuthCreds value,
          $Res Function(BrowserBasicAuthCreds) then) =
      _$BrowserBasicAuthCredsCopyWithImpl<$Res, BrowserBasicAuthCreds>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$BrowserBasicAuthCredsCopyWithImpl<$Res,
        $Val extends BrowserBasicAuthCreds>
    implements $BrowserBasicAuthCredsCopyWith<$Res> {
  _$BrowserBasicAuthCredsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserBasicAuthCredsImplCopyWith<$Res>
    implements $BrowserBasicAuthCredsCopyWith<$Res> {
  factory _$$BrowserBasicAuthCredsImplCopyWith(
          _$BrowserBasicAuthCredsImpl value,
          $Res Function(_$BrowserBasicAuthCredsImpl) then) =
      __$$BrowserBasicAuthCredsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$BrowserBasicAuthCredsImplCopyWithImpl<$Res>
    extends _$BrowserBasicAuthCredsCopyWithImpl<$Res,
        _$BrowserBasicAuthCredsImpl>
    implements _$$BrowserBasicAuthCredsImplCopyWith<$Res> {
  __$$BrowserBasicAuthCredsImplCopyWithImpl(_$BrowserBasicAuthCredsImpl _value,
      $Res Function(_$BrowserBasicAuthCredsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$BrowserBasicAuthCredsImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$BrowserBasicAuthCredsImpl implements _BrowserBasicAuthCreds {
  const _$BrowserBasicAuthCredsImpl(
      {required this.username, required this.password});

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'BrowserBasicAuthCreds(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserBasicAuthCredsImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserBasicAuthCredsImplCopyWith<_$BrowserBasicAuthCredsImpl>
      get copyWith => __$$BrowserBasicAuthCredsImplCopyWithImpl<
          _$BrowserBasicAuthCredsImpl>(this, _$identity);
}

abstract class _BrowserBasicAuthCreds implements BrowserBasicAuthCreds {
  const factory _BrowserBasicAuthCreds(
      {required final String username,
      required final String password}) = _$BrowserBasicAuthCredsImpl;

  @override
  String get username;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$BrowserBasicAuthCredsImplCopyWith<_$BrowserBasicAuthCredsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$BrowserTabState {
  BrowserTabStateType get state => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  bool get canGoBack => throw _privateConstructorUsedError;
  bool get canGoForward => throw _privateConstructorUsedError;
  VoidCallback? get goBack => throw _privateConstructorUsedError;
  VoidCallback? get goForward => throw _privateConstructorUsedError;
  VoidCallback? get refresh => throw _privateConstructorUsedError;
  Map<String, BrowserBasicAuthCreds> get basicAuthCreds =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $BrowserTabStateCopyWith<BrowserTabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowserTabStateCopyWith<$Res> {
  factory $BrowserTabStateCopyWith(
          BrowserTabState value, $Res Function(BrowserTabState) then) =
      _$BrowserTabStateCopyWithImpl<$Res, BrowserTabState>;
  @useResult
  $Res call(
      {BrowserTabStateType state,
      int progress,
      String? errorMessage,
      String? title,
      bool canGoBack,
      bool canGoForward,
      VoidCallback? goBack,
      VoidCallback? goForward,
      VoidCallback? refresh,
      Map<String, BrowserBasicAuthCreds> basicAuthCreds});
}

/// @nodoc
class _$BrowserTabStateCopyWithImpl<$Res, $Val extends BrowserTabState>
    implements $BrowserTabStateCopyWith<$Res> {
  _$BrowserTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? progress = null,
    Object? errorMessage = freezed,
    Object? title = freezed,
    Object? canGoBack = null,
    Object? canGoForward = null,
    Object? goBack = freezed,
    Object? goForward = freezed,
    Object? refresh = freezed,
    Object? basicAuthCreds = null,
  }) {
    return _then(_value.copyWith(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as BrowserTabStateType,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      canGoBack: null == canGoBack
          ? _value.canGoBack
          : canGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      canGoForward: null == canGoForward
          ? _value.canGoForward
          : canGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
      goBack: freezed == goBack
          ? _value.goBack
          : goBack // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      goForward: freezed == goForward
          ? _value.goForward
          : goForward // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      refresh: freezed == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      basicAuthCreds: null == basicAuthCreds
          ? _value.basicAuthCreds
          : basicAuthCreds // ignore: cast_nullable_to_non_nullable
              as Map<String, BrowserBasicAuthCreds>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BrowserTabStateImplCopyWith<$Res>
    implements $BrowserTabStateCopyWith<$Res> {
  factory _$$BrowserTabStateImplCopyWith(_$BrowserTabStateImpl value,
          $Res Function(_$BrowserTabStateImpl) then) =
      __$$BrowserTabStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BrowserTabStateType state,
      int progress,
      String? errorMessage,
      String? title,
      bool canGoBack,
      bool canGoForward,
      VoidCallback? goBack,
      VoidCallback? goForward,
      VoidCallback? refresh,
      Map<String, BrowserBasicAuthCreds> basicAuthCreds});
}

/// @nodoc
class __$$BrowserTabStateImplCopyWithImpl<$Res>
    extends _$BrowserTabStateCopyWithImpl<$Res, _$BrowserTabStateImpl>
    implements _$$BrowserTabStateImplCopyWith<$Res> {
  __$$BrowserTabStateImplCopyWithImpl(
      _$BrowserTabStateImpl _value, $Res Function(_$BrowserTabStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? state = null,
    Object? progress = null,
    Object? errorMessage = freezed,
    Object? title = freezed,
    Object? canGoBack = null,
    Object? canGoForward = null,
    Object? goBack = freezed,
    Object? goForward = freezed,
    Object? refresh = freezed,
    Object? basicAuthCreds = null,
  }) {
    return _then(_$BrowserTabStateImpl(
      state: null == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as BrowserTabStateType,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      canGoBack: null == canGoBack
          ? _value.canGoBack
          : canGoBack // ignore: cast_nullable_to_non_nullable
              as bool,
      canGoForward: null == canGoForward
          ? _value.canGoForward
          : canGoForward // ignore: cast_nullable_to_non_nullable
              as bool,
      goBack: freezed == goBack
          ? _value.goBack
          : goBack // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      goForward: freezed == goForward
          ? _value.goForward
          : goForward // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      refresh: freezed == refresh
          ? _value.refresh
          : refresh // ignore: cast_nullable_to_non_nullable
              as VoidCallback?,
      basicAuthCreds: null == basicAuthCreds
          ? _value._basicAuthCreds
          : basicAuthCreds // ignore: cast_nullable_to_non_nullable
              as Map<String, BrowserBasicAuthCreds>,
    ));
  }
}

/// @nodoc

class _$BrowserTabStateImpl extends _BrowserTabState {
  const _$BrowserTabStateImpl(
      {this.state = BrowserTabStateType.initial,
      this.progress = 0,
      this.errorMessage = null,
      this.title = null,
      this.canGoBack = false,
      this.canGoForward = false,
      this.goBack = null,
      this.goForward = null,
      this.refresh = null,
      final Map<String, BrowserBasicAuthCreds> basicAuthCreds = const {}})
      : _basicAuthCreds = basicAuthCreds,
        super._();

  @override
  @JsonKey()
  final BrowserTabStateType state;
  @override
  @JsonKey()
  final int progress;
  @override
  @JsonKey()
  final String? errorMessage;
  @override
  @JsonKey()
  final String? title;
  @override
  @JsonKey()
  final bool canGoBack;
  @override
  @JsonKey()
  final bool canGoForward;
  @override
  @JsonKey()
  final VoidCallback? goBack;
  @override
  @JsonKey()
  final VoidCallback? goForward;
  @override
  @JsonKey()
  final VoidCallback? refresh;
  final Map<String, BrowserBasicAuthCreds> _basicAuthCreds;
  @override
  @JsonKey()
  Map<String, BrowserBasicAuthCreds> get basicAuthCreds {
    if (_basicAuthCreds is EqualUnmodifiableMapView) return _basicAuthCreds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_basicAuthCreds);
  }

  @override
  String toString() {
    return 'BrowserTabState(state: $state, progress: $progress, errorMessage: $errorMessage, title: $title, canGoBack: $canGoBack, canGoForward: $canGoForward, goBack: $goBack, goForward: $goForward, refresh: $refresh, basicAuthCreds: $basicAuthCreds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowserTabStateImpl &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.canGoBack, canGoBack) ||
                other.canGoBack == canGoBack) &&
            (identical(other.canGoForward, canGoForward) ||
                other.canGoForward == canGoForward) &&
            (identical(other.goBack, goBack) || other.goBack == goBack) &&
            (identical(other.goForward, goForward) ||
                other.goForward == goForward) &&
            (identical(other.refresh, refresh) || other.refresh == refresh) &&
            const DeepCollectionEquality()
                .equals(other._basicAuthCreds, _basicAuthCreds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      state,
      progress,
      errorMessage,
      title,
      canGoBack,
      canGoForward,
      goBack,
      goForward,
      refresh,
      const DeepCollectionEquality().hash(_basicAuthCreds));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowserTabStateImplCopyWith<_$BrowserTabStateImpl> get copyWith =>
      __$$BrowserTabStateImplCopyWithImpl<_$BrowserTabStateImpl>(
          this, _$identity);
}

abstract class _BrowserTabState extends BrowserTabState {
  const factory _BrowserTabState(
          {final BrowserTabStateType state,
          final int progress,
          final String? errorMessage,
          final String? title,
          final bool canGoBack,
          final bool canGoForward,
          final VoidCallback? goBack,
          final VoidCallback? goForward,
          final VoidCallback? refresh,
          final Map<String, BrowserBasicAuthCreds> basicAuthCreds}) =
      _$BrowserTabStateImpl;
  const _BrowserTabState._() : super._();

  @override
  BrowserTabStateType get state;
  @override
  int get progress;
  @override
  String? get errorMessage;
  @override
  String? get title;
  @override
  bool get canGoBack;
  @override
  bool get canGoForward;
  @override
  VoidCallback? get goBack;
  @override
  VoidCallback? get goForward;
  @override
  VoidCallback? get refresh;
  @override
  Map<String, BrowserBasicAuthCreds> get basicAuthCreds;
  @override
  @JsonKey(ignore: true)
  _$$BrowserTabStateImplCopyWith<_$BrowserTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
