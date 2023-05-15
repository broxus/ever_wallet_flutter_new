import 'dart:async';

import 'package:app/app/utils/iterable_extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visibility_detector/visibility_detector.dart';

const _doubleRowsPadding = 8.0;
const _tripleRowsPadding = 16.0;

/// Panel of sliding block chains on main screen of onboarding
class SlidingBlockChains extends StatefulWidget {
  const SlidingBlockChains({super.key});

  @override
  State<SlidingBlockChains> createState() => _SlidingBlockChainsState();
}

class _SlidingBlockChainsState extends State<SlidingBlockChains> {
  Timer? timer;
  final List<ScrollController> controllers = [];

  /// [_images] separated by count of [controllers]
  final List<List<String>> controllerImages = [];
  static const _images = <String>[
    'layer1/btc.svg',
    'layer1/eth.svg',
    'layer1/usdt.svg',
    'layer1/DOGE.svg',
    'layer1/dot.svg',
    'layer1/MATIC.svg',
    'layer1/dai.svg',
    'layer1/QUBE.svg',
    'layer1/EVER.svg',
    'layer1/bridge.svg',
    //
    'layer2/usdc.svg',
    'layer2/AVAX.svg',
    'layer2/xrp.svg',
    'layer2/bnb.svg',
    'layer2/ADA.svg',
    'layer2/SOL.svg',
    'layer2/SHIB.svg',
    'layer2/LUNA.svg',
    'layer2/NEAR.svg',
    'layer2/CRO.svg',
    //
    'layer3/atom.svg',
    'layer3/ltc.svg',
    'layer3/trx.svg',
    'layer3/xlm.svg',
    'layer3/link.svg',
    'layer3/mana.svg',
    'layer3/FTM.svg',
    'layer3/HBAR.svg',
    'layer3/AXS.svg',
    'layer3/AAVE.svg',
  ];
  double _paddingBetweenRows = 0;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  @override
  void dispose() {
    controllers.clear();
    timer?.cancel();
    super.dispose();
  }

  void _initTimer() => timer = Timer.periodic(
        const Duration(milliseconds: 30),
        (timer) => _scrollLists(),
      );

  void _stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void _scrollLists() {
    for (final c in controllers) {
      if (c.hasClients) {
        c.jumpTo(c.offset + 0.5);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('SlidingBlockChains'),
      onVisibilityChanged: (info) {
        final isVisible = info.visibleBounds != Rect.zero;
        if (isVisible && timer == null) {
          _initTimer();
        } else if (!isVisible) {
          _stopTimer();
        }
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final lineCount = constraints.maxHeight < 150 ? 2 : 3;
              _paddingBetweenRows =
                  lineCount == 3 ? _tripleRowsPadding : _doubleRowsPadding;

              final partSize = (constraints.maxHeight -
                      _paddingBetweenRows * (lineCount - 1)) /
                  lineCount;
              if (controllers.isEmpty) {
                final imagesByControllerCount = _images.length ~/ lineCount;
                controllers.addAll(
                  List.generate(lineCount, (index) {
                    final start = index * imagesByControllerCount;
                    controllerImages.add(
                      _images.sublist(start, start + imagesByControllerCount),
                    );
                    if (index.isEven) return ScrollController();
                    return ScrollController(
                      initialScrollOffset:
                          partSize / 2 + _paddingBetweenRows / 2,
                    );
                  }),
                );
              }

              return Column(
                children: controllers
                    .mapIndexed(
                      (listIndex, c) => SizedBox(
                        height: partSize,
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: c,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            return _generateItem(
                              listIndex,
                              index % controllerImages[listIndex].length,
                              partSize,
                            );
                          },
                        ),
                      ),
                    )
                    .separated(SizedBox(height: _paddingBetweenRows)),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _generateItem(int listIndex, int index, double size) {
    return Container(
      key: ValueKey('OnboardingImage_${controllerImages[listIndex][index]}'),
      margin: EdgeInsets.only(right: _paddingBetweenRows),
      width: size,
      height: size,
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: SvgPicture.asset(
        'assets/images/onboarding/${controllerImages[listIndex][index]}',
      ),
    );
  }
}
