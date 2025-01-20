import 'package:app/feature/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatelessWidget {
  const WalletView({
    required this.currentAccount,
    required this.scrollController,
    required this.isShowingBadge,
    required this.isShowingNewTokens,
    required this.hasUnconfirmedTransactions,
    required this.finishedBackupCallback,
    required this.confirmImportCallback,
    required this.manifestUrl,
    required this.imageUrl,
    super.key,
  });

  final KeyAccount? currentAccount;
  final ScrollController scrollController;
  final bool isShowingBadge;
  final bool isShowingNewTokens;
  final bool hasUnconfirmedTransactions;
  final VoidCallback finishedBackupCallback;
  final VoidCallback confirmImportCallback;
  final String manifestUrl;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: Stack(
        children: [
          _Background(imageUrl: imageUrl, scrollController: scrollController),
          CustomScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            slivers: [
              const SliverToBoxAdapter(
                child: WalletAppBarWidget(),
              ),
              WalletAccountsBody(
                account: currentAccount,
                isShowingBadge: isShowingBadge,
                finishedBackupCallback: finishedBackupCallback,
              ),
              WalletBottomPanel(
                currentAccount: currentAccount!,
                scrollController: scrollController,
                isShowingNewTokens: isShowingNewTokens,
                confirmImportCallback: confirmImportCallback,
                manifestUrl: manifestUrl,
                hasUnconfirmedTransactions: hasUnconfirmedTransactions,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(color: theme.colors.background0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Background extends StatefulWidget {
  const _Background({
    required this.scrollController,
    required this.imageUrl,
  });

  final ScrollController scrollController;
  final String imageUrl;

  @override
  State<_Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<_Background> {
  @override
  void initState() {
    widget.scrollController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final offset = widget.scrollController.hasClients
        ? widget.scrollController.offset
        : 0.0;

    return Positioned(
      top: -offset,
      left: 0,
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: DimensSizeV2.d32),
        child: Image.asset(
          widget.imageUrl,
          height: size.width,
          width: size.width,
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }

  void _listener() => setState(() {});
}
