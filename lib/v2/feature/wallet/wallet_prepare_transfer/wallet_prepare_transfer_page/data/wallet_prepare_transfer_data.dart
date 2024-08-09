import 'package:app/v2/feature/wallet/wallet_prepare_transfer/wallet_prepare_transfer_page/data/wallet_prepare_transfer_asset.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPrepareTransferData {
  WalletPrepareTransferData({
    this.walletName,
    this.account,
    this.selectedCustodian,
    this.localCustodians,
    this.selectedAsset,
    this.assets,
  });

  final String? walletName;
  final KeyAccount? account;
  final PublicKey? selectedCustodian;
  final List<PublicKey>? localCustodians;
  final WalletPrepareTransferAsset? selectedAsset;
  final List<WalletPrepareTransferAsset>? assets;

  bool get isEmpty =>
      walletName == null &&
      account == null &&
      selectedCustodian == null &&
      localCustodians == null &&
      selectedAsset == null &&
      assets == null;

  WalletPrepareTransferData copyWith({
    String? walletName,
    KeyAccount? account,
    PublicKey? selectedCustodian,
    List<PublicKey>? localCustodians,
    WalletPrepareTransferAsset? selectedAsset,
    List<WalletPrepareTransferAsset>? assets,
  }) {
    return WalletPrepareTransferData(
      walletName: walletName ?? this.walletName,
      account: account ?? this.account,
      selectedCustodian: selectedCustodian ?? this.selectedCustodian,
      localCustodians: localCustodians ?? this.localCustodians,
      selectedAsset: selectedAsset ?? this.selectedAsset,
      assets: assets ?? this.assets,
    );
  }
}
