import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatelessWidget {
  const WalletView({
    required this.currentAccount,
    required this.scrollController,
    super.key,
  });

  final KeyAccount? currentAccount;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: Stack(
        children: [
          _Background(scrollController: scrollController),
          CustomScrollView(
            controller: scrollController,
            slivers: [
              const SliverToBoxAdapter(
                child: WalletAppBarWidget(),
              ),
              WalletAccountsBody(account: currentAccount),
              WalletBottomPanel(
                currentAccount: currentAccount!,
                scrollController: scrollController,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(color: theme.colors.background1),
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
  });

  final ScrollController scrollController;

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

    return Positioned(
      top: -widget.scrollController.offset,
      left: 0,
      width: size.width,
      child: Image.asset(
        Assets.images.homescreenBg.homescreenBg.path,
        height: size.width,
        width: size.width,
        fit: BoxFit.contain,
        alignment: Alignment.topCenter,
      ),
    );
  }

  void _listener() => setState(() {});
}
