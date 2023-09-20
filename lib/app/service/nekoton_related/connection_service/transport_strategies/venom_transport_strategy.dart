import 'package:app/app/service/nekoton_related/connection_service/transport_strategies/utils.dart';
import 'package:app/generated/generated.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// Transport strategy for venom network
class VenomTransportStrategy extends TransportStrategy {
  VenomTransportStrategy({required this.transport});

  @override
  final Transport transport;

  @override
  String accountExplorerLink(Address accountAddress) =>
      'https://venomscan.com/accounts/${accountAddress.address}';

  @override
  final availableWalletTypes = const [
    WalletType.everWallet(),
    WalletType.multisig(MultisigType.multisig2_1),
  ];

  @override
  String currencyUrl(String currencyAddress) =>
      'https://testnetapi.web3.world/v1/currencies/$currencyAddress';

  @override
  String defaultAccountName(WalletType walletType) =>
      getDefaultAccountName(walletType);

  @override
  final defaultWalletType = const WalletType.everWallet();

  @override
  final manifestUrl =
      'https://raw.githubusercontent.com/BVFDT/venom-assets/master/manifest.json';

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
      'https://venomscan.com/transactions/$transactionHash';

  @override
  // ignore: no-magic-number
  int get defaultNativeCurrencyDecimal => 9;

  @override
  StakingInformation? get stakeInformation => null;
}
