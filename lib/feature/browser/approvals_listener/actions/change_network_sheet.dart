import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/approvals_listener/actions/change_network/change_network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

Future<TransportStrategy?> showChangeNetworkSheet({
  required BuildContext context,
  required Uri origin,
  required int networkId,
  required List<ConnectionData> connections,
}) =>
    showCommonBottomSheet<TransportStrategy?>(
      context: context,
      title: LocaleKeys.changeNetwork.tr(),
      centerTitle: true,
      body: (context, scroll) => ChangeNetworkWidget(
        origin: origin,
        networkId: networkId,
        connections: connections,
        scrollController: scroll,
      ),
    );
