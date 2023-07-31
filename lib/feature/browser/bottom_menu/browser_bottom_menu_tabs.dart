import 'package:app/app/router/app_route.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserBottomMenuTabs extends StatelessWidget {
  const BrowserBottomMenuTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      builder: (context, state) {
        final isEmpty = context.watch<BrowserTabsBloc>().state.tabs.isEmpty;

        return BrowserBottomBarTabs(
          closeAllText: LocaleKeys.browserCloseAll.tr(),
          plusSvg: Assets.images.plusCircled.path,
          doneText: LocaleKeys.browserDone.tr(),
          onCloseAllPressed: isEmpty ? null : () => _onCloseAllPressed(context),
          onPlusPressed: () => _onPlusPressed(context),
          onDonePressed: () => _onDonePressed(context),
        );
      },
    );
  }

  void _onCloseAllPressed(BuildContext context) {
    context.read<BrowserTabsBloc>().add(
          const BrowserTabsEvent.closeAll(),
        );
    context.goNamed(AppRoute.browser.name);
  }

  void _onPlusPressed(BuildContext context) {
    context.read<BrowserTabsBloc>().add(
          const BrowserTabsEvent.addEmpty(),
        );
    context.goNamed(AppRoute.browser.name);
  }

  void _onDonePressed(BuildContext context) {
    context.goNamed(AppRoute.browser.name);
  }
}
