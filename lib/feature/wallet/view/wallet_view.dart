import 'dart:ui';

import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class WalletView extends StatelessWidget {
  const WalletView({
    required this.currentAccount,
    required this.scrollController,
    required this.isShowingBadge,
    required this.isShowingNewTokens,
    required this.finishedBackupCallback,
    required this.confirmImportCallback,
    required this.manifestUrl,
    super.key,
  });

  final KeyAccount? currentAccount;
  final ScrollController scrollController;
  final bool isShowingBadge;
  final bool isShowingNewTokens;
  final VoidCallback finishedBackupCallback;
  final VoidCallback confirmImportCallback;
  final String manifestUrl;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return SafeArea(
      child: Stack(
        children: [
          _Background(scrollController: scrollController),
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
  });

  final ScrollController scrollController;

  @override
  State<_Background> createState() => _BackgroundState();
}

class _BackgroundState extends State<_Background> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 1,
      left: 1,
      right: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: DimensSizeV2.d40),
            child: SvgPicture.asset(Assets.images.bgMain.path),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 55,
              sigmaY: 55,
            ),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
