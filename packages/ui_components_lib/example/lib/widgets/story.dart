import 'package:example/widgets/story_v1.dart';
import 'package:example/widgets/story_v2.dart';
import 'package:flutter/material.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget({super.key});

  @override
  State<StoryWidget> createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget>
    with SingleTickerProviderStateMixin {
  late final _tabsController = TabController(
    initialIndex: _currentIndex,
    length: 2,
    vsync: this,
  );

  int _currentIndex = 0;

  @override
  void dispose() {
    _tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              controller: _tabsController,
              onTap: _onPressedTap,
              tabs: const [
                _Tab(title: 'v1'),
                _Tab(title: 'v2'),
              ],
            ),
            Flexible(
              child: switch (_currentIndex) {
                0 => const StoryV1(),
                1 => const StoryV2(),
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(title),
    );
  }
}
