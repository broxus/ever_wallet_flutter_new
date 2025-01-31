import 'package:app/generated/generated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Widget that is able to display icon for TonWallet
class TonWalletIconWidget extends StatefulWidget {
  const TonWalletIconWidget({
    required this.path,
    this.size = DimensSize.d40,
    super.key,
  });

  /// Can be asset path or network url
  final String path;
  final double size;

  @override
  State<TonWalletIconWidget> createState() => _TonWalletIconWidgetState();
}

class _TonWalletIconWidgetState extends State<TonWalletIconWidget> {
  // Hack that allows you to draw problematic icons
  bool _isRender = false;

  String get _path => widget.path;

  double get _size => widget.size;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isRender = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final uri = Uri.parse(_path);
    if (!_isRender) {
      return _Placeholder(size: _size);
    }
    if (uri.hasScheme) {
      if (uri.path.endsWith('.svg')) {
        return SvgPicture.network(
          _path,
          placeholderBuilder: (_) => _Placeholder(size: _size),
          width: _size,
          height: _size,
        );
      } else {
        return CachedNetworkImage(
          height: _size,
          width: _size,
          imageUrl: _path,
          placeholder: (_, __) => _Placeholder(size: _size),
          errorWidget: (_, __, ___) => SvgPicture.asset(
            Assets.images.tokenDefaultIcon.path,
            width: _size,
          ),
        );
      }
    }

    return SvgPicture.asset(
      _path,
      placeholderBuilder: (_) => _Placeholder(size: _size),
      width: _size,
      height: _size,
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.size,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return CommonLoader(
      width: size,
      height: size,
      borderRadius: DimensRadius.max,
    );
  }
}
