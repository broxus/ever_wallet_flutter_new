import 'package:app/data/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@immutable
class AmountInputAsset extends Equatable {
  const AmountInputAsset({
    required this.rootTokenContract,
    required this.isNative,
    required this.balance,
    required this.logoURI,
    required this.title,
    required this.tokenSymbol,
    this.version,
    this.currency,
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

  final CustomCurrency? currency;

  @override
  List<Object?> get props => [rootTokenContract, balance, tokenSymbol];

  (Address, String) get key => (rootTokenContract, tokenSymbol);
}
