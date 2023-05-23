import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:nekoton_repository/nekoton_repository.dart';

/// Wrapper class around nekoton's account with additional logic.
@immutable
class KeyAccount extends Equatable {
  const KeyAccount({
    required this.account,
    required this.isExternal,
    required this.isHidden,
    required this.publicKey,
  });

  /// Nekoton's account
  final AssetsList account;

  /// Key for which this account specified.
  /// For external accounts this value can be different from account.publicKey
  /// but for internal usages this key is same as for key this account stores in
  final String publicKey;

  /// Flag that allows identify if this account is external.
  final bool isExternal;

  /// Flag that allows identify if this account is hidden.
  final bool isHidden;

  @override
  List<Object?> get props => [account, isExternal, isHidden];
}
