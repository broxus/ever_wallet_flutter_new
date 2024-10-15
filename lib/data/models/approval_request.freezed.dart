// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ApprovalRequest {
  Uri get origin => throw _privateConstructorUsedError;
  Completer<void> get completer => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApprovalRequestCopyWith<ApprovalRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalRequestCopyWith<$Res> {
  factory $ApprovalRequestCopyWith(
          ApprovalRequest value, $Res Function(ApprovalRequest) then) =
      _$ApprovalRequestCopyWithImpl<$Res, ApprovalRequest>;
  @useResult
  $Res call({Uri origin});
}

/// @nodoc
class _$ApprovalRequestCopyWithImpl<$Res, $Val extends ApprovalRequest>
    implements $ApprovalRequestCopyWith<$Res> {
  _$ApprovalRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RequestPermissionsImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$RequestPermissionsImplCopyWith(_$RequestPermissionsImpl value,
          $Res Function(_$RequestPermissionsImpl) then) =
      __$$RequestPermissionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      List<Permission> permissions,
      Completer<Permissions> completer});
}

/// @nodoc
class __$$RequestPermissionsImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$RequestPermissionsImpl>
    implements _$$RequestPermissionsImplCopyWith<$Res> {
  __$$RequestPermissionsImplCopyWithImpl(_$RequestPermissionsImpl _value,
      $Res Function(_$RequestPermissionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? permissions = null,
    Object? completer = null,
  }) {
    return _then(_$RequestPermissionsImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<Permission>,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<Permissions>,
    ));
  }
}

/// @nodoc

class _$RequestPermissionsImpl implements _RequestPermissions {
  const _$RequestPermissionsImpl(
      {required this.origin,
      required final List<Permission> permissions,
      required this.completer})
      : _permissions = permissions;

  @override
  final Uri origin;
  final List<Permission> _permissions;
  @override
  List<Permission> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final Completer<Permissions> completer;

  @override
  String toString() {
    return 'ApprovalRequest.requestPermissions(origin: $origin, permissions: $permissions, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestPermissionsImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin,
      const DeepCollectionEquality().hash(_permissions), completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestPermissionsImplCopyWith<_$RequestPermissionsImpl> get copyWith =>
      __$$RequestPermissionsImplCopyWithImpl<_$RequestPermissionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return requestPermissions(origin, permissions, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return requestPermissions?.call(origin, permissions, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (requestPermissions != null) {
      return requestPermissions(origin, permissions, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return requestPermissions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return requestPermissions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (requestPermissions != null) {
      return requestPermissions(this);
    }
    return orElse();
  }
}

abstract class _RequestPermissions implements ApprovalRequest {
  const factory _RequestPermissions(
          {required final Uri origin,
          required final List<Permission> permissions,
          required final Completer<Permissions> completer}) =
      _$RequestPermissionsImpl;

  @override
  Uri get origin;
  List<Permission> get permissions;
  @override
  Completer<Permissions> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestPermissionsImplCopyWith<_$RequestPermissionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ChangeAccountImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$ChangeAccountImplCopyWith(
          _$ChangeAccountImpl value, $Res Function(_$ChangeAccountImpl) then) =
      __$$ChangeAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      List<Permission> permissions,
      Address? previousSelectedAccount,
      Completer<Permissions> completer});
}

/// @nodoc
class __$$ChangeAccountImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$ChangeAccountImpl>
    implements _$$ChangeAccountImplCopyWith<$Res> {
  __$$ChangeAccountImplCopyWithImpl(
      _$ChangeAccountImpl _value, $Res Function(_$ChangeAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? permissions = null,
    Object? previousSelectedAccount = freezed,
    Object? completer = null,
  }) {
    return _then(_$ChangeAccountImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      permissions: null == permissions
          ? _value._permissions
          : permissions // ignore: cast_nullable_to_non_nullable
              as List<Permission>,
      previousSelectedAccount: freezed == previousSelectedAccount
          ? _value.previousSelectedAccount
          : previousSelectedAccount // ignore: cast_nullable_to_non_nullable
              as Address?,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<Permissions>,
    ));
  }
}

/// @nodoc

class _$ChangeAccountImpl implements _ChangeAccount {
  const _$ChangeAccountImpl(
      {required this.origin,
      required final List<Permission> permissions,
      required this.previousSelectedAccount,
      required this.completer})
      : _permissions = permissions;

  @override
  final Uri origin;
  final List<Permission> _permissions;
  @override
  List<Permission> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  final Address? previousSelectedAccount;
  @override
  final Completer<Permissions> completer;

  @override
  String toString() {
    return 'ApprovalRequest.changeAccount(origin: $origin, permissions: $permissions, previousSelectedAccount: $previousSelectedAccount, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChangeAccountImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality()
                .equals(other._permissions, _permissions) &&
            const DeepCollectionEquality().equals(
                other.previousSelectedAccount, previousSelectedAccount) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(_permissions),
      const DeepCollectionEquality().hash(previousSelectedAccount),
      completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChangeAccountImplCopyWith<_$ChangeAccountImpl> get copyWith =>
      __$$ChangeAccountImplCopyWithImpl<_$ChangeAccountImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return changeAccount(
        origin, permissions, previousSelectedAccount, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return changeAccount?.call(
        origin, permissions, previousSelectedAccount, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (changeAccount != null) {
      return changeAccount(
          origin, permissions, previousSelectedAccount, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return changeAccount(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return changeAccount?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (changeAccount != null) {
      return changeAccount(this);
    }
    return orElse();
  }
}

abstract class _ChangeAccount implements ApprovalRequest {
  const factory _ChangeAccount(
      {required final Uri origin,
      required final List<Permission> permissions,
      required final Address? previousSelectedAccount,
      required final Completer<Permissions> completer}) = _$ChangeAccountImpl;

  @override
  Uri get origin;
  List<Permission> get permissions;
  Address? get previousSelectedAccount;
  @override
  Completer<Permissions> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChangeAccountImplCopyWith<_$ChangeAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AddTip3TokenImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$AddTip3TokenImplCopyWith(
          _$AddTip3TokenImpl value, $Res Function(_$AddTip3TokenImpl) then) =
      __$$AddTip3TokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      TokenContractAsset details,
      Completer<void> completer});

  $TokenContractAssetCopyWith<$Res> get details;
}

/// @nodoc
class __$$AddTip3TokenImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$AddTip3TokenImpl>
    implements _$$AddTip3TokenImplCopyWith<$Res> {
  __$$AddTip3TokenImplCopyWithImpl(
      _$AddTip3TokenImpl _value, $Res Function(_$AddTip3TokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? account = freezed,
    Object? details = null,
    Object? completer = null,
  }) {
    return _then(_$AddTip3TokenImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      details: null == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as TokenContractAsset,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<void>,
    ));
  }

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TokenContractAssetCopyWith<$Res> get details {
    return $TokenContractAssetCopyWith<$Res>(_value.details, (value) {
      return _then(_value.copyWith(details: value));
    });
  }
}

/// @nodoc

class _$AddTip3TokenImpl implements _AddTip3Token {
  const _$AddTip3TokenImpl(
      {required this.origin,
      required this.account,
      required this.details,
      required this.completer});

  @override
  final Uri origin;
  @override
  final Address account;
  @override
  final TokenContractAsset details;
  @override
  final Completer<void> completer;

  @override
  String toString() {
    return 'ApprovalRequest.addTip3Token(origin: $origin, account: $account, details: $details, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTip3TokenImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, origin,
      const DeepCollectionEquality().hash(account), details, completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTip3TokenImplCopyWith<_$AddTip3TokenImpl> get copyWith =>
      __$$AddTip3TokenImplCopyWithImpl<_$AddTip3TokenImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return addTip3Token(origin, account, details, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return addTip3Token?.call(origin, account, details, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (addTip3Token != null) {
      return addTip3Token(origin, account, details, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return addTip3Token(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return addTip3Token?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (addTip3Token != null) {
      return addTip3Token(this);
    }
    return orElse();
  }
}

abstract class _AddTip3Token implements ApprovalRequest {
  const factory _AddTip3Token(
      {required final Uri origin,
      required final Address account,
      required final TokenContractAsset details,
      required final Completer<void> completer}) = _$AddTip3TokenImpl;

  @override
  Uri get origin;
  Address get account;
  TokenContractAsset get details;
  @override
  Completer<void> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTip3TokenImplCopyWith<_$AddTip3TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SignDataImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$SignDataImplCopyWith(
          _$SignDataImpl value, $Res Function(_$SignDataImpl) then) =
      __$$SignDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey publicKey,
      String data,
      Completer<String> completer});
}

/// @nodoc
class __$$SignDataImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$SignDataImpl>
    implements _$$SignDataImplCopyWith<$Res> {
  __$$SignDataImplCopyWithImpl(
      _$SignDataImpl _value, $Res Function(_$SignDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? account = freezed,
    Object? publicKey = freezed,
    Object? data = null,
    Object? completer = null,
  }) {
    return _then(_$SignDataImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: freezed == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<String>,
    ));
  }
}

/// @nodoc

class _$SignDataImpl implements _SignData {
  const _$SignDataImpl(
      {required this.origin,
      required this.account,
      required this.publicKey,
      required this.data,
      required this.completer});

  @override
  final Uri origin;
  @override
  final Address account;
  @override
  final PublicKey publicKey;
  @override
  final String data;
  @override
  final Completer<String> completer;

  @override
  String toString() {
    return 'ApprovalRequest.signData(origin: $origin, account: $account, publicKey: $publicKey, data: $data, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignDataImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(account),
      const DeepCollectionEquality().hash(publicKey),
      data,
      completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignDataImplCopyWith<_$SignDataImpl> get copyWith =>
      __$$SignDataImplCopyWithImpl<_$SignDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return signData(origin, account, publicKey, data, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return signData?.call(origin, account, publicKey, data, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (signData != null) {
      return signData(origin, account, publicKey, data, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return signData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return signData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (signData != null) {
      return signData(this);
    }
    return orElse();
  }
}

abstract class _SignData implements ApprovalRequest {
  const factory _SignData(
      {required final Uri origin,
      required final Address account,
      required final PublicKey publicKey,
      required final String data,
      required final Completer<String> completer}) = _$SignDataImpl;

  @override
  Uri get origin;
  Address get account;
  PublicKey get publicKey;
  String get data;
  @override
  Completer<String> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignDataImplCopyWith<_$SignDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EncryptDataImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$EncryptDataImplCopyWith(
          _$EncryptDataImpl value, $Res Function(_$EncryptDataImpl) then) =
      __$$EncryptDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey publicKey,
      String data,
      Completer<String> completer});
}

/// @nodoc
class __$$EncryptDataImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$EncryptDataImpl>
    implements _$$EncryptDataImplCopyWith<$Res> {
  __$$EncryptDataImplCopyWithImpl(
      _$EncryptDataImpl _value, $Res Function(_$EncryptDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? account = freezed,
    Object? publicKey = freezed,
    Object? data = null,
    Object? completer = null,
  }) {
    return _then(_$EncryptDataImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: freezed == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<String>,
    ));
  }
}

/// @nodoc

class _$EncryptDataImpl implements _EncryptData {
  const _$EncryptDataImpl(
      {required this.origin,
      required this.account,
      required this.publicKey,
      required this.data,
      required this.completer});

  @override
  final Uri origin;
  @override
  final Address account;
  @override
  final PublicKey publicKey;
  @override
  final String data;
  @override
  final Completer<String> completer;

  @override
  String toString() {
    return 'ApprovalRequest.encryptData(origin: $origin, account: $account, publicKey: $publicKey, data: $data, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EncryptDataImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(account),
      const DeepCollectionEquality().hash(publicKey),
      data,
      completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EncryptDataImplCopyWith<_$EncryptDataImpl> get copyWith =>
      __$$EncryptDataImplCopyWithImpl<_$EncryptDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return encryptData(origin, account, publicKey, data, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return encryptData?.call(origin, account, publicKey, data, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (encryptData != null) {
      return encryptData(origin, account, publicKey, data, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return encryptData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return encryptData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (encryptData != null) {
      return encryptData(this);
    }
    return orElse();
  }
}

abstract class _EncryptData implements ApprovalRequest {
  const factory _EncryptData(
      {required final Uri origin,
      required final Address account,
      required final PublicKey publicKey,
      required final String data,
      required final Completer<String> completer}) = _$EncryptDataImpl;

  @override
  Uri get origin;
  Address get account;
  PublicKey get publicKey;
  String get data;
  @override
  Completer<String> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EncryptDataImplCopyWith<_$EncryptDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DecryptDataImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$DecryptDataImplCopyWith(
          _$DecryptDataImpl value, $Res Function(_$DecryptDataImpl) then) =
      __$$DecryptDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey recipientPublicKey,
      PublicKey sourcePublicKey,
      Completer<String> completer});
}

/// @nodoc
class __$$DecryptDataImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$DecryptDataImpl>
    implements _$$DecryptDataImplCopyWith<$Res> {
  __$$DecryptDataImplCopyWithImpl(
      _$DecryptDataImpl _value, $Res Function(_$DecryptDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? account = freezed,
    Object? recipientPublicKey = freezed,
    Object? sourcePublicKey = freezed,
    Object? completer = null,
  }) {
    return _then(_$DecryptDataImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      recipientPublicKey: freezed == recipientPublicKey
          ? _value.recipientPublicKey
          : recipientPublicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      sourcePublicKey: freezed == sourcePublicKey
          ? _value.sourcePublicKey
          : sourcePublicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<String>,
    ));
  }
}

/// @nodoc

class _$DecryptDataImpl implements _DecryptData {
  const _$DecryptDataImpl(
      {required this.origin,
      required this.account,
      required this.recipientPublicKey,
      required this.sourcePublicKey,
      required this.completer});

  @override
  final Uri origin;
  @override
  final Address account;
  @override
  final PublicKey recipientPublicKey;
  @override
  final PublicKey sourcePublicKey;
  @override
  final Completer<String> completer;

  @override
  String toString() {
    return 'ApprovalRequest.decryptData(origin: $origin, account: $account, recipientPublicKey: $recipientPublicKey, sourcePublicKey: $sourcePublicKey, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DecryptDataImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality()
                .equals(other.recipientPublicKey, recipientPublicKey) &&
            const DeepCollectionEquality()
                .equals(other.sourcePublicKey, sourcePublicKey) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(account),
      const DeepCollectionEquality().hash(recipientPublicKey),
      const DeepCollectionEquality().hash(sourcePublicKey),
      completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DecryptDataImplCopyWith<_$DecryptDataImpl> get copyWith =>
      __$$DecryptDataImplCopyWithImpl<_$DecryptDataImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return decryptData(
        origin, account, recipientPublicKey, sourcePublicKey, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return decryptData?.call(
        origin, account, recipientPublicKey, sourcePublicKey, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (decryptData != null) {
      return decryptData(
          origin, account, recipientPublicKey, sourcePublicKey, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return decryptData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return decryptData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (decryptData != null) {
      return decryptData(this);
    }
    return orElse();
  }
}

abstract class _DecryptData implements ApprovalRequest {
  const factory _DecryptData(
      {required final Uri origin,
      required final Address account,
      required final PublicKey recipientPublicKey,
      required final PublicKey sourcePublicKey,
      required final Completer<String> completer}) = _$DecryptDataImpl;

  @override
  Uri get origin;
  Address get account;
  PublicKey get recipientPublicKey;
  PublicKey get sourcePublicKey;
  @override
  Completer<String> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DecryptDataImplCopyWith<_$DecryptDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CallContractMethodImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$CallContractMethodImplCopyWith(_$CallContractMethodImpl value,
          $Res Function(_$CallContractMethodImpl) then) =
      __$$CallContractMethodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address account,
      PublicKey publicKey,
      Address recipient,
      FunctionCall payload,
      Completer<String> completer});
}

/// @nodoc
class __$$CallContractMethodImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$CallContractMethodImpl>
    implements _$$CallContractMethodImplCopyWith<$Res> {
  __$$CallContractMethodImplCopyWithImpl(_$CallContractMethodImpl _value,
      $Res Function(_$CallContractMethodImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? account = freezed,
    Object? publicKey = freezed,
    Object? recipient = freezed,
    Object? payload = freezed,
    Object? completer = null,
  }) {
    return _then(_$CallContractMethodImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      account: freezed == account
          ? _value.account
          : account // ignore: cast_nullable_to_non_nullable
              as Address,
      publicKey: freezed == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as PublicKey,
      recipient: freezed == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as Address,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as FunctionCall,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<String>,
    ));
  }
}

/// @nodoc

class _$CallContractMethodImpl implements _CallContractMethod {
  const _$CallContractMethodImpl(
      {required this.origin,
      required this.account,
      required this.publicKey,
      required this.recipient,
      required this.payload,
      required this.completer});

  @override
  final Uri origin;
  @override
  final Address account;
  @override
  final PublicKey publicKey;
  @override
  final Address recipient;
  @override
  final FunctionCall payload;
  @override
  final Completer<String> completer;

  @override
  String toString() {
    return 'ApprovalRequest.callContractMethod(origin: $origin, account: $account, publicKey: $publicKey, recipient: $recipient, payload: $payload, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallContractMethodImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.account, account) &&
            const DeepCollectionEquality().equals(other.publicKey, publicKey) &&
            const DeepCollectionEquality().equals(other.recipient, recipient) &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(account),
      const DeepCollectionEquality().hash(publicKey),
      const DeepCollectionEquality().hash(recipient),
      const DeepCollectionEquality().hash(payload),
      completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallContractMethodImplCopyWith<_$CallContractMethodImpl> get copyWith =>
      __$$CallContractMethodImplCopyWithImpl<_$CallContractMethodImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return callContractMethod(
        origin, account, publicKey, recipient, payload, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return callContractMethod?.call(
        origin, account, publicKey, recipient, payload, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (callContractMethod != null) {
      return callContractMethod(
          origin, account, publicKey, recipient, payload, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return callContractMethod(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return callContractMethod?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (callContractMethod != null) {
      return callContractMethod(this);
    }
    return orElse();
  }
}

abstract class _CallContractMethod implements ApprovalRequest {
  const factory _CallContractMethod(
      {required final Uri origin,
      required final Address account,
      required final PublicKey publicKey,
      required final Address recipient,
      required final FunctionCall payload,
      required final Completer<String> completer}) = _$CallContractMethodImpl;

  @override
  Uri get origin;
  Address get account;
  PublicKey get publicKey;
  Address get recipient;
  FunctionCall get payload;
  @override
  Completer<String> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallContractMethodImplCopyWith<_$CallContractMethodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SendMessageImplCopyWith<$Res>
    implements $ApprovalRequestCopyWith<$Res> {
  factory _$$SendMessageImplCopyWith(
          _$SendMessageImpl value, $Res Function(_$SendMessageImpl) then) =
      __$$SendMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uri origin,
      Address sender,
      Address recipient,
      @amountJsonConverter BigInt amount,
      bool bounce,
      FunctionCall? payload,
      KnownPayload? knownPayload,
      Completer<(PublicKey, String)> completer});
}

/// @nodoc
class __$$SendMessageImplCopyWithImpl<$Res>
    extends _$ApprovalRequestCopyWithImpl<$Res, _$SendMessageImpl>
    implements _$$SendMessageImplCopyWith<$Res> {
  __$$SendMessageImplCopyWithImpl(
      _$SendMessageImpl _value, $Res Function(_$SendMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? sender = freezed,
    Object? recipient = freezed,
    Object? amount = null,
    Object? bounce = null,
    Object? payload = freezed,
    Object? knownPayload = freezed,
    Object? completer = null,
  }) {
    return _then(_$SendMessageImpl(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as Uri,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as Address,
      recipient: freezed == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as Address,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      bounce: null == bounce
          ? _value.bounce
          : bounce // ignore: cast_nullable_to_non_nullable
              as bool,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as FunctionCall?,
      knownPayload: freezed == knownPayload
          ? _value.knownPayload
          : knownPayload // ignore: cast_nullable_to_non_nullable
              as KnownPayload?,
      completer: null == completer
          ? _value.completer
          : completer // ignore: cast_nullable_to_non_nullable
              as Completer<(PublicKey, String)>,
    ));
  }
}

/// @nodoc

class _$SendMessageImpl implements _SendMessage {
  const _$SendMessageImpl(
      {required this.origin,
      required this.sender,
      required this.recipient,
      @amountJsonConverter required this.amount,
      required this.bounce,
      required this.payload,
      required this.knownPayload,
      required this.completer});

  @override
  final Uri origin;
  @override
  final Address sender;
  @override
  final Address recipient;
  @override
  @amountJsonConverter
  final BigInt amount;
  @override
  final bool bounce;
  @override
  final FunctionCall? payload;
  @override
  final KnownPayload? knownPayload;
  @override
  final Completer<(PublicKey, String)> completer;

  @override
  String toString() {
    return 'ApprovalRequest.sendMessage(origin: $origin, sender: $sender, recipient: $recipient, amount: $amount, bounce: $bounce, payload: $payload, knownPayload: $knownPayload, completer: $completer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageImpl &&
            (identical(other.origin, origin) || other.origin == origin) &&
            const DeepCollectionEquality().equals(other.sender, sender) &&
            const DeepCollectionEquality().equals(other.recipient, recipient) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bounce, bounce) || other.bounce == bounce) &&
            const DeepCollectionEquality().equals(other.payload, payload) &&
            const DeepCollectionEquality()
                .equals(other.knownPayload, knownPayload) &&
            (identical(other.completer, completer) ||
                other.completer == completer));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      origin,
      const DeepCollectionEquality().hash(sender),
      const DeepCollectionEquality().hash(recipient),
      amount,
      bounce,
      const DeepCollectionEquality().hash(payload),
      const DeepCollectionEquality().hash(knownPayload),
      completer);

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      __$$SendMessageImplCopyWithImpl<_$SendMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)
        requestPermissions,
    required TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)
        changeAccount,
    required TResult Function(Uri origin, Address account,
            TokenContractAsset details, Completer<void> completer)
        addTip3Token,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        signData,
    required TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)
        encryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey recipientPublicKey,
            PublicKey sourcePublicKey,
            Completer<String> completer)
        decryptData,
    required TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)
        callContractMethod,
    required TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)
        sendMessage,
  }) {
    return sendMessage(origin, sender, recipient, amount, bounce, payload,
        knownPayload, completer);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult? Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult? Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult? Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult? Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult? Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult? Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
  }) {
    return sendMessage?.call(origin, sender, recipient, amount, bounce, payload,
        knownPayload, completer);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uri origin, List<Permission> permissions,
            Completer<Permissions> completer)?
        requestPermissions,
    TResult Function(Uri origin, List<Permission> permissions,
            Address? previousSelectedAccount, Completer<Permissions> completer)?
        changeAccount,
    TResult Function(Uri origin, Address account, TokenContractAsset details,
            Completer<void> completer)?
        addTip3Token,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        signData,
    TResult Function(Uri origin, Address account, PublicKey publicKey,
            String data, Completer<String> completer)?
        encryptData,
    TResult Function(Uri origin, Address account, PublicKey recipientPublicKey,
            PublicKey sourcePublicKey, Completer<String> completer)?
        decryptData,
    TResult Function(
            Uri origin,
            Address account,
            PublicKey publicKey,
            Address recipient,
            FunctionCall payload,
            Completer<String> completer)?
        callContractMethod,
    TResult Function(
            Uri origin,
            Address sender,
            Address recipient,
            @amountJsonConverter BigInt amount,
            bool bounce,
            FunctionCall? payload,
            KnownPayload? knownPayload,
            Completer<(PublicKey, String)> completer)?
        sendMessage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(origin, sender, recipient, amount, bounce, payload,
          knownPayload, completer);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_RequestPermissions value) requestPermissions,
    required TResult Function(_ChangeAccount value) changeAccount,
    required TResult Function(_AddTip3Token value) addTip3Token,
    required TResult Function(_SignData value) signData,
    required TResult Function(_EncryptData value) encryptData,
    required TResult Function(_DecryptData value) decryptData,
    required TResult Function(_CallContractMethod value) callContractMethod,
    required TResult Function(_SendMessage value) sendMessage,
  }) {
    return sendMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_RequestPermissions value)? requestPermissions,
    TResult? Function(_ChangeAccount value)? changeAccount,
    TResult? Function(_AddTip3Token value)? addTip3Token,
    TResult? Function(_SignData value)? signData,
    TResult? Function(_EncryptData value)? encryptData,
    TResult? Function(_DecryptData value)? decryptData,
    TResult? Function(_CallContractMethod value)? callContractMethod,
    TResult? Function(_SendMessage value)? sendMessage,
  }) {
    return sendMessage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_RequestPermissions value)? requestPermissions,
    TResult Function(_ChangeAccount value)? changeAccount,
    TResult Function(_AddTip3Token value)? addTip3Token,
    TResult Function(_SignData value)? signData,
    TResult Function(_EncryptData value)? encryptData,
    TResult Function(_DecryptData value)? decryptData,
    TResult Function(_CallContractMethod value)? callContractMethod,
    TResult Function(_SendMessage value)? sendMessage,
    required TResult orElse(),
  }) {
    if (sendMessage != null) {
      return sendMessage(this);
    }
    return orElse();
  }
}

abstract class _SendMessage implements ApprovalRequest {
  const factory _SendMessage(
          {required final Uri origin,
          required final Address sender,
          required final Address recipient,
          @amountJsonConverter required final BigInt amount,
          required final bool bounce,
          required final FunctionCall? payload,
          required final KnownPayload? knownPayload,
          required final Completer<(PublicKey, String)> completer}) =
      _$SendMessageImpl;

  @override
  Uri get origin;
  Address get sender;
  Address get recipient;
  @amountJsonConverter
  BigInt get amount;
  bool get bounce;
  FunctionCall? get payload;
  KnownPayload? get knownPayload;
  @override
  Completer<(PublicKey, String)> get completer;

  /// Create a copy of ApprovalRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageImplCopyWith<_$SendMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
