import 'package:nekoton_repository/nekoton_repository.dart';

/// Default attach amount to transaction in native tokens (for example, 3 EVER)
final defaultAttachAmount = BigInt.parse('3000000000');

/// Default bounce flag for sending transaction
const defaultMessageBounce = false;

/// Default timeout for sending transaction
const defaultSendTimeout = Expiration.timeout(60);

/// Same as [defaultSendTimeout] but in other type
const defaultSendTimeoutDuration = Duration(seconds: 60);
