import 'package:app/app/router/router.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Open new tab in browser with [url].
/// This is ridiculous, but we need to navigate to browser page first and then
/// navigate to it second time, after StatefulShellRoute is set up.
void browserNewTab(BuildContext context, String url) {
  context.goNamed(
    AppRoute.browser.name,
  );
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.goNamed(
      AppRoute.browser.name,
      queryParameters: {
        browserUrlPathParam: url,
      },
    );
  });
}
