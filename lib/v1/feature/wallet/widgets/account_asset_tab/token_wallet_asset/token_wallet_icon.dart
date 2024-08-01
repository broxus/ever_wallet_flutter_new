import 'package:app/v1/feature/wallet/wallet.dart';
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
            child: logoURI != null
                ? TonWalletIconWidget(path: logoURI!, size: size)
                : CustomPaint(painter: _AvatarPainter(address.address)),
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

const _avatarCircleRadius = 7.0;

class _AvatarPainter extends CustomPainter {
  const _AvatarPainter(this.address);

  final String address;

  @override
  // ignore: long-method
  void paint(Canvas canvas, Size size) {
    final hash = address.split(':').last;

    final colors = List.generate(
      16,
      (index) => '#${hash[0]}${hash[index * 4]}${hash[index * 4 + 1]}'
          '${hash[index * 4 + 2]}${hash[63]}${hash[index * 4 + 3]}',
    );

    canvas
      ..drawCircle(
        const Offset(3, 3),
        _avatarCircleRadius,
        Paint()..color = colors[0].toColor(),
      )
      ..drawCircle(
        const Offset(3, 13),
        _avatarCircleRadius,
        Paint()..color = colors[4].toColor(),
      )
      ..drawCircle(
        const Offset(3, 23),
        _avatarCircleRadius,
        Paint()..color = colors[8].toColor(),
      )
      ..drawCircle(
        const Offset(3, 33),
        _avatarCircleRadius,
        Paint()..color = colors[12].toColor(),
      )
      ..drawCircle(
        const Offset(13, 3),
        _avatarCircleRadius,
        Paint()..color = colors[1].toColor(),
      )
      ..drawCircle(
        const Offset(13, 13),
        _avatarCircleRadius,
        Paint()..color = colors[5].toColor(),
      )
      ..drawCircle(
        const Offset(13, 23),
        _avatarCircleRadius,
        Paint()..color = colors[9].toColor(),
      )
      ..drawCircle(
        const Offset(13, 33),
        _avatarCircleRadius,
        Paint()..color = colors[13].toColor(),
      )
      ..drawCircle(
        const Offset(23, 3),
        _avatarCircleRadius,
        Paint()..color = colors[2].toColor(),
      )
      ..drawCircle(
        const Offset(23, 13),
        _avatarCircleRadius,
        Paint()..color = colors[6].toColor(),
      )
      ..drawCircle(
        const Offset(23, 23),
        _avatarCircleRadius,
        Paint()..color = colors[10].toColor(),
      )
      ..drawCircle(
        const Offset(23, 33),
        _avatarCircleRadius,
        Paint()..color = colors[14].toColor(),
      )
      ..drawCircle(
        const Offset(33, 3),
        _avatarCircleRadius,
        Paint()..color = colors[3].toColor(),
      )
      ..drawCircle(
        const Offset(33, 13),
        _avatarCircleRadius,
        Paint()..color = colors[7].toColor(),
      )
      ..drawCircle(
        const Offset(33, 23),
        _avatarCircleRadius,
        Paint()..color = colors[11].toColor(),
      )
      ..drawCircle(
        const Offset(33, 33),
        _avatarCircleRadius,
        Paint()..color = colors[15].toColor(),
      );
  }

  @override
  bool shouldRepaint(_AvatarPainter oldDelegate) => false;
}

extension on String {
  Color toColor() {
    var hexColor = replaceAll('#', '');

    // ignore: no-magic-number
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }

    // ignore: no-magic-number
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }

    throw Exception('Invalid color format');
  }
}
