import 'package:app/data/models/models.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:flutter/foundation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Model that describes asset during PrepareTransfer step.
@immutable
class WalletPrepareTransferAsset extends AmountInputAsset {
  const WalletPrepareTransferAsset({
    required super.rootTokenContract,
    required super.isNative,
    required super.balance,
    required super.logoURI,
    required super.title,
    required super.tokenSymbol,
    super.version,
    super.currency,
  });

  /// Copy asset with new balance
  WalletPrepareTransferAsset copyWith({
    Money? balance,
    CustomCurrency? currency,
  }) =>
      WalletPrepareTransferAsset(
        title: title,
        rootTokenContract: rootTokenContract,
        balance: balance ?? this.balance,
        isNative: isNative,
        logoURI: logoURI,
        version: version,
        tokenSymbol: tokenSymbol,
        currency: currency ?? this.currency,
      );
}
