import 'dart:async';

import 'package:app/app/service/service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'browser_view_events_listener_state.dart';

part 'browser_view_events_listener_cubit.freezed.dart';

/// This cubit is a listener of events from different parts of application
/// that allows trigger events to InPageProvider in webview.
class BrowserViewEventsListenerCubit
    extends Cubit<BrowserViewEventsListenerState> {
  BrowserViewEventsListenerCubit({
    required this.nekotonRepository,
    required this.tabId,
    required this.permissionsService,
  }) : super(const BrowserViewEventsListenerState.empty());

  final NekotonRepository nekotonRepository;

  final PermissionsService permissionsService;

  /// Id of the tab
  final String tabId;

  /// Controller initializes in [initControllerAndListeners] that calls from ui
  late InAppWebViewController controller;

  List<StreamSubscription<dynamic>> subs = [];

  // ignore: avoid-unused-parameters
  void initControllerAndListeners(InAppWebViewController controller) {
    subs.addAll([
      // TODO(alex-a4): uncomment and fix when webview will be updated
      // nekotonRepository
      //     .tabTransactionsStream(tabId)
      //     .listen((trans) => controller.transactionsFound(trans)),
      // nekotonRepository
      //     .tabStateChangesStream(tabId)
      //     .listen((state) => controller.stateChanged(state)),
      // nekotonRepository.currentTransportStream.listen(
      //     (transport) => controller.transportChanged(transport.transport)),
      // nekotonRepository.hasSeeds.listen((hasSeeds) => controler.loggerOut()),
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
