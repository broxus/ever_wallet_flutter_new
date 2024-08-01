import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Model that describes asset during PrepareTransfer step.
@immutable
class WalletPrepareTransferAsset extends Equatable {
  const WalletPrepareTransferAsset({
    required this.rootTokenContract,
    required this.isNative,
    required this.balance,
    required this.logoURI,
    required this.title,
    required this.tokenSymbol,
    this.version,
  });

  /// Contract of token.
  /// For native token is specified, but [isNative] is true
  final Address rootTokenContract;

  /// If this asset is native token.
  /// If true, then [rootTokenContract] will be useless.
  final bool isNative;

  /// Balance of this token.
  final Money balance;

  /// Symbol of token (ticker), that is used for selection
  final String tokenSymbol;

  /// Svg path or network uri
  final String? logoURI;

  /// Title of token
  final String title;

  /// Version of TokenWallet.
  /// Null for native token
  final TokenWalletVersion? version;

  /// Copy asset with new balance
  WalletPrepareTransferAsset copyWith(Money balance) =>
      WalletPrepareTransferAsset(
        title: title,
        rootTokenContract: rootTokenContract,
        balance: balance,
        isNative: isNative,
        logoURI: logoURI,
        version: version,
        tokenSymbol: tokenSymbol,
      );

  @override
  List<Object?> get props => [rootTokenContract, balance, tokenSymbol];
}
