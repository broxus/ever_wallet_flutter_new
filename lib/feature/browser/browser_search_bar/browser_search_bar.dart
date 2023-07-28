import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class BrowserSearchBar extends StatelessWidget {
  const BrowserSearchBar({
    this.onSubmitted,
    super.key,
  });
  final ValueChanged<String?>? onSubmitted;

  static const height = DimensSize.d64;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowserTabsBloc, BrowserTabsState>(
      builder: (context, state) {
        final currentTab = context.read<BrowserTabsBloc>().activeTab;

        return BrowserSearchBarInput(
          uri: currentTab?.url,
          hintText: LocaleKeys.browserSearchURL.tr(),
          cancelText: LocaleKeys.browserSearchURLCancel.tr(),
          onSubmitted: onSubmitted,
          onShared: _onShared,
          searchSvg: Assets.images.search.path,
          secureSvg: Assets.images.lock.path,
          shareSvg: Assets.images.export.path,
        );
      },
    );
  }

  void _onShared(Uri? url) {
    final shareText = url?.toString();
    if (shareText != null) {
      Share.share(shareText);
    }
  }
}
