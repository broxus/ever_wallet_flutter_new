import 'package:app/feature/browser/approvals_listener/actions/add_network/add_network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_webview/nekoton_webview.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<Network?> showAddNetworkSheet({
  required BuildContext context,
  required Uri origin,
  required AddNetwork network,
  required bool switchNetwork,
}) =>
    showCommonBottomSheet<Network?>(
      context: context,
      title: LocaleKeys.addNetwork.tr(),
      centerTitle: true,
      body: (context, scroll) => AddNetworkWidget(
        origin: origin,
        network: network,
        switchNetwork: switchNetwork,
        scrollController: scroll,
      ),
    );
