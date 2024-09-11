import 'package:nekoton_repository/nekoton_repository.dart';

class WalletPageData {
  WalletPageData({required this.isShowingBadge, this.currentAccount});

  final KeyAccount? currentAccount;
  final bool isShowingBadge;
}
