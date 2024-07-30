import 'package:nekoton_repository/nekoton_repository.dart';

/// Default bounce flag for sending transaction
const defaultMessageBounce = false;

/// Default timeout for sending transaction
const defaultSendTimeout = Expiration.timeout(60);

/// Same as [defaultSendTimeout] but in other type
const defaultSendTimeoutDuration = Duration(seconds: 60);
