import 'package:app/feature/wallet/wallet.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that is able to display icon for TokenWallet
class TokenWalletIconWidget extends StatelessWidget {
  const TokenWalletIconWidget({
    required this.address,
    required this.logoURI,
    required this.version,
    this.size = DimensSize.d40,
    super.key,
  });

  final Address address;
  final TokenWalletVersion version;
  final String? logoURI;

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        children: [
          ClipOval(
            child: logoURI != null && logoURI!.isNotEmpty
                ? TonWalletIconWidget(path: logoURI!, size: size)
                : SvgPicture.asset(
                    Assets.images.tokenDefaultIcon.path,
                    width: size,
                  ),
          ),
          if (version == TokenWalletVersion.oldTip3v4)
            const Positioned(
              right: 0,
              bottom: 0,
              child: TokenAssetOldLabel(),
            ),
        ],
      ),
    );
  }
}

class TokenAssetOldLabel extends StatelessWidget {
  const TokenAssetOldLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DimensRadius.small),
        color: colors.alert,
      ),
      padding: const EdgeInsets.all(DimensSize.d4),
      child: Text(
        LocaleKeys.oldWord.tr(),
        style: StyleRes.addRegular.copyWith(
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
