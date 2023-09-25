import 'package:app/app/service/nekoton_related/connection_service/transport_strategies/utils.dart';
import 'package:app/data/models/models.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for venom network
class VenomTransportStrategy extends TransportStrategy {
  VenomTransportStrategy({
    required this.transport,
    required this.connection,
  });

  @override
  final Transport transport;

  final ConnectionData connection;

  @override
  String accountExplorerLink(Address accountAddress) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/accounts/${accountAddress.address}'
          : '';

  @override
  final availableWalletTypes = const [
    WalletType.everWallet(),
    WalletType.multisig(MultisigType.multisig2_1),
  ];

  @override
  String currencyUrl(String currencyAddress) =>
      'https://testnetapi.web3.world/v1/currencies/$currencyAddress';

  @override
  String defaultAccountName(WalletType walletType) => getDefaultAccountName(
        walletType,
        overrides: {
          const WalletType.everWallet(): 'Default',
          const WalletType.walletV3(): 'Legacy',
        },
      );

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  String get manifestUrl => connection.manifestUrl;

  @override
  String get nativeTokenIcon => Assets.images.venom.path;

  @override
  final nativeTokenTicker = 'VENOM';

  @override
  final nativeTokenAddress = const Address(
    address:
        '0:28237a5d5abb32413a79b5f98573074d3b39b72121305d9c9c97912fc06d843c',
  );

  @override
  final networkName = 'Venom';

  @override
  final seedPhraseWordsCount = [12];

  @override
  String transactionExplorerLink(String transactionHash) =>
      connection.blockExplorerUrl.isNotEmpty
          ? '${connection.blockExplorerUrl}/transactions/$transactionHash'
          : '';

  @override
  // ignore: no-magic-number
  int get defaultNativeCurrencyDecimal => 9;

  @override
  StakingInformation? get stakeInformation => null;
}
