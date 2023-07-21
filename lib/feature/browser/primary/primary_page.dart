import 'package:app/app/router/app_route.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/browser/primary/hud_bloc/hud_bloc.dart';
import 'package:app/feature/browser/primary/primary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrimaryPage extends StatefulWidget {
  const PrimaryPage({this.url, this.tabId, super.key});
  final String? url;
  final int? tabId;

  @override
  State<PrimaryPage> createState() => _PrimaryPageState();
}

class _PrimaryPageState extends State<PrimaryPage> {
  @override
  void didUpdateWidget(covariant PrimaryPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    final browserTabsBloc = context.read<BrowserTabsBloc>();

    var stateWasChanged = false;

    // Change active tab id.
    if (widget.tabId != oldWidget.tabId && widget.tabId != null) {
      browserTabsBloc.add(
        BrowserTabsBlocEvent.setActive(
          id: widget.tabId!,
        ),
      );
      stateWasChanged = true;
    }

    // Create new tab.
    if (widget.url != null && widget.tabId == null) {
      browserTabsBloc.add(
        BrowserTabsBlocEvent.add(
          uri: Uri.parse(widget.url!),
        ),
      );
      stateWasChanged = true;
    }

    // We don't want to store url, tab id or anything else in the route location
    // because it's complicated to handle it in the browser tabs bloc: we will
    // have two sources of truth: route location and browser tabs bloc state.
    // So, just change bloc state, clear route location and let the browser tabs
    // bloc handle the rest.
    if (stateWasChanged) {
      context.clearQueryParams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HudBloc>(
      create: (context) => HudBloc(),
      child: const PrimaryView(),
    );
  }
}
