import 'package:app/app/router/router.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomMenuCommon extends StatelessWidget {
  const BrowserBottomMenuCommon({
    super.key,
  });
  static const height = BrowserBottomBarPrimary.height;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      builder: (context, state) {
        final tabCount = context.watch<BrowserTabsBloc>().state.tabs.length;
        final currentTabState = context.read<BrowserTabsBloc>().activeTabState;
        final canGoBack = currentTabState?.canGoBack ?? false;
        final canGoForward = currentTabState?.canGoForward ?? false;

        return BrowserBottomBarPrimary(
          backSvg: Assets.images.navigateBack.path,
          forwardSvg: Assets.images.navigateForward.path,
          plusSvg: Assets.images.plusCircled.path,
          historySvg: Assets.images.history.path,
          dotsSvg: Assets.images.dots.path,
          onCountIndicatorPressed: () => _onCountIndicatorPressed(context),
          onBackPressed: canGoBack ? currentTabState?.goBack : null,
          onForwardPressed: canGoForward ? currentTabState?.goForward : null,
          onPlusPressed: () => _onPlusPressed(context),
          onHistoryPressed: () => _onHistoryPressed(context),
          onDotsPressed: () => _onDotsPressed(context),
          tabCount: tabCount,
        );
      },
    );
  }

  void _onCountIndicatorPressed(BuildContext context) {
    context.goNamed(AppRoute.browserTabs.name);
  }

  void _onPlusPressed(BuildContext context) {
    context.read<BrowserTabsBloc>().add(
          const BrowserTabsEvent.addEmpty(),
        );
  }

  void _onHistoryPressed(BuildContext context) {
    context.goNamed(AppRoute.browserHistory.name);
  }

  void _onDotsPressed(BuildContext context) {
    final currentTab = context.read<BrowserTabsBloc>().activeTab;
    final currentTabState = context.read<BrowserTabsBloc>().activeTabState;
    final hasUrl = currentTab?.url.host.isNotEmpty ?? false;

    showBrowserPrimarySheet(
      context: context,
      refreshEnabled: hasUrl,
      addToBookmarksEnabled: hasUrl,
      onRefreshPressed: currentTabState?.refresh,
    );
  }
}
