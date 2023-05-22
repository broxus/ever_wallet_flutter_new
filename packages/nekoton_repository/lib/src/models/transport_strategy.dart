import 'package:nekoton_repository/nekoton_repository.dart';

/// This is a strategy for [Transport] that adds additional logic.
/// There are 3 default strategies that can be used in application.
/// 1) Ever network
/// 2) Venom network
/// 3) Custom network
abstract class TransportStrategy {
  /// Getter for transport that is used to make network calls.
  Transport get transport;

  /// Returns list with numbers of available words.
  /// For example, for ever this returns [12, 24].
  /// This list is used during adding new seed phrase and order of items saves
  /// for building interface.
  List<int> get seedPhraseAvailableWords;

  /// This type of wallet is used for creating default account for any publicKey
  WalletType get defaultWalletType;

  /// This returns list of all wallet types that can be used for creating
  /// account.
  List<WalletType> get availableWalletTypes;

  /// This returns name of native token in network,
  /// For example, EVER.
  String get nativeTokenTicker;

  /// !!! This is like ID for specified network !!!
  ///
  /// This returns name of the network.
  /// Also this name can be used to identify network params to create transport
  /// or strategy or token saving/restoring.
  String get networkName;

  /// This returns asset/network path for the icon.
  /// Widget must be able to load icon from asset and network.
  String get nativeTokenIcon;

  /// This must return URL link to network explorer specified to
  /// [accountAddress].
  String accountExplorerLink(String accountAddress);

  /// This must return URL link to transaction explorer specified to
  /// [transactionHash].
  String transactionExplorerLink(String transactionHash);

  /// This must return URL link to load manifest of network assets.
  String get manifestUrl;

  /// This must return URL link to load information about currency and its
  /// prices by [currencyAddress].
  String currencyUrl(String currencyAddress);

  /// This must return default name of account for specified [walletType].
  /// Method depends on transport because this same [walletType] may has
  /// different names in different networks.
  String defaultAccountName(WalletType walletType);
}
