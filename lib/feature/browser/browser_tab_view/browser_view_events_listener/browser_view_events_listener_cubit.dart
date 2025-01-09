import 'dart:async';

import 'package:app/app/service/js_servcie.dart';
import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:nekoton_webview/nekoton_webview.dart' as nwv;

part 'browser_view_events_listener_cubit.freezed.dart';
part 'browser_view_events_listener_state.dart';

/// This cubit is a listener of events from different parts of application
/// that allows trigger events to InPageProvider in webview.
class BrowserViewEventsListenerCubit
    extends Cubit<BrowserViewEventsListenerState> {
  BrowserViewEventsListenerCubit({
    required this.nekotonRepository,
    required this.tabId,
    required this.permissionsService,
    required this.jsService,
  }) : super(const BrowserViewEventsListenerState.empty()) {
    jsService.loadNekotonJs();
  }

  final NekotonRepository nekotonRepository;

  final PermissionsService permissionsService;
  final JsService jsService;

  EntityValueListenable<String?> get nekotonJsState => jsService.nekotonJsState;

  /// Id of the tab
  final String tabId;

  /// Controller initializes in [initControllerAndListeners] that calls from ui
  late InAppWebViewController controller;

  List<StreamSubscription<dynamic>> subs = [];

  void initControllerAndListeners(InAppWebViewController controller) {
    subs.addAll([
      nekotonRepository.tabTransactionsStream(tabId).listen(
            (event) => controller.transactionsFound(
              nwv.TransactionsFoundEvent(
                event.address.address,
                event.transactions
                    .map((e) => nwv.Transaction.fromJson(e.toJson()))
                    .toList(),
                nwv.TransactionsBatchInfo.fromJson(event.info.toJson()),
              ),
            ),
          ),
      nekotonRepository.tabStateChangesStream(tabId).listen(
            (state) => controller.contractStateChanged(
              nwv.ContractStateChangedEvent(
                state.address.address,
                nwv.ContractState.fromJson(state.state.toJson()),
              ),
            ),
          ),
      nekotonRepository.currentTransportStream.listen(
        (transport) async => controller.networkChanged(
          nwv.NetworkChangedEvent(
            transport.transport.name,
            await transport.transport.getNetworkId(),
          ),
        ),
      ),
      nekotonRepository.hasSeeds.listen((hasSeeds) {
        if (!hasSeeds) controller.loggedOut();
      }),
      permissionsService.permissionsStream.listen(
        (permissions) async {
          final url = await controller.getUrl();
          final currentPermissions =
              url == null ? null : permissions[Uri.parse(url.origin)];

          await controller.permissionsChanged(
            nwv.PermissionsChangedEvent(
              nwv.PermissionsPartial.fromJson(
                currentPermissions?.toJson() ?? {},
              ),
            ),
          );
        },
      ),
    ]);
  }

  @override
  Future<void> close() {
    for (final sub in subs) {
      sub.cancel();
    }

    return super.close();
  }
}
