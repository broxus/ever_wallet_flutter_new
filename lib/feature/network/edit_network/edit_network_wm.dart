import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/network/edit_network/validators.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';

EditNetworkWidgetModel defaultEditNetworkWidgetModelFactory(
  BuildContext context,
) =>
    EditNetworkWidgetModel(
      EditNetworkModel(
        inject(),
        inject(),
      ),
    );

class EditNetworkWidgetModel
    extends CustomWidgetModel<EditNetworkPageWidget, EditNetworkModel> {
  EditNetworkWidgetModel(super.model);

  final formKey = GlobalKey<FormState>();

  late final nameController =
      createTextEditingController(connection?.name ?? '');

  late final isEditable = connection?.canBeEdited ?? true;

  late final currencySymbolController = createTextEditingController(
    connection?.nativeTokenTicker ?? '',
  );

  late final blockExplorerUrlController = createTextEditingController(
    connection?.blockExplorerUrl ?? '',
  );

  late final manifestUrlController = createTextEditingController(
    connection?.manifestUrl ?? '',
  );

  late final bool isDeleteEnabled = connection != null && isEditable;
  late final bool isSaveEnabled = isEditable;

  late final validators = Validators();

  late final _selectedNetworkTypeState = StateNotifier<String?>(
    initValue:
        connection?.networkType ?? model.networkTypesOptions?.firstOrNull,
  );

  late final _isLocalState = StateNotifier<bool>(
    initValue: _getIsLocal(),
  );

  late final _endpointsControllersState =
      StateNotifier<List<TextEditingController>>(
    initValue: _getEndpointsControllers(),
  );

  late final _connectionTypeState = StateNotifier<ConnectionType>(
    initValue: connection == null
        ? ConnectionType.jrpc
        : ConnectionType.fromConnection(connection!),
  );

  late final connection = model.connections.firstWhereOrNull(
    (element) => element.id == widget.connectionDataId,
  );

  ListenableState<String?> get selectedNetworkTypeState =>
      _selectedNetworkTypeState;

  ListenableState<bool> get isLocalState => _isLocalState;

  ListenableState<List<TextEditingController>> get endpointsControllersState =>
      _endpointsControllersState;

  ListenableState<ConnectionType> get connectionTypeState =>
      _connectionTypeState;

  List<String>? get networkTypesOptions => model.networkTypesOptions;

  String get selectedNetworkType => selectedNetworkTypeState.value ?? 'custom';

  List<TextEditingController>? get _endpointsControllers =>
      _endpointsControllersState.value;

  ConnectionType? get _connectionType => _connectionTypeState.value;

  bool get _isLocal => _isLocalState.value ?? connection != null;

  void onChangedNetworkType(String value) {
    _selectedNetworkTypeState.accept(value);
  }

  // ignore: avoid_positional_boolean_parameters
  void onLocalChanged(bool value) {
    if (!isEditable) {
      return;
    }

    _isLocalState.accept(value);
  }

  void onAdd() {
    _endpointsControllersState.accept([
      ...?_endpointsControllers,
      createTextEditingController(),
    ]);
  }

  void onRemove(int index) {
    final controllers = [...?_endpointsControllers]..removeAt(index);

    _endpointsControllersState.accept(controllers);
  }

  void onChangeType(ConnectionType type) {
    _connectionTypeState.accept(type);
    if (!type.enableMultipleEndpoints) {
      final first = _endpointsControllers?.first;

      _endpointsControllersState.accept(first == null ? [] : [first]);
    }
  }

  void onTokenListTextLinkTap() =>
      browserNewTab(context, LocaleKeys.networkTokenListTextLinkUrl.tr());

  Future<void> onDelete() async {
    final result = await showDeleteNetworkConfirmationSheet(
      context: context,
      networkName: connection?.name ?? '',
    );

    if ((result ?? false) && connection != null) {
      model.removeConnection(connection!.id);
      contextSafe?.clearQueryParamsAndPop();
    }
  }

  Future<void> onSave() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final currentConnection = _getConnection();

    if (currentConnection == null) {
      return;
    }

    if (connection == null) {
      model.addConnection(currentConnection);
    } else {
      model.updateConnection(currentConnection);
    }

    if (connection == null) {
      await showSwitchToThisNetworkSheet(
        context: context,
        onSwitch: () => model.saveCurrentConnectionId(currentConnection.id),
      );
    }

    contextSafe?.clearQueryParamsAndPop();
  }

  // ignore: long-method
  List<TextEditingController> _getEndpointsControllers() {
    if (connection == null) {
      return [TextEditingController()];
    }

    return connection!.when(
      gql: (
        _,
        __,
        ___,
        endpoints,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ____________,
        _____________,
        ______________,
        _______________,
        ________________,
      ) =>
          endpoints
              .map((endpoint) => TextEditingController(text: endpoint))
              .toList(),
      proto: (
        _,
        __,
        ___,
        endpoint,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ____________,
      ) =>
          [TextEditingController(text: endpoint)],
      jrpc: (
        _,
        __,
        ___,
        endpoint,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ____________,
      ) =>
          [TextEditingController(text: endpoint)],
    );
  }

  bool _getIsLocal() {
    if (connection == null) {
      return false;
    }

    return connection!.when(
      gql: (
        _,
        __,
        ___,
        ____,
        ______,
        isLocal,
        ________,
        _________,
        __________,
        ___________,
        ____________,
        _____________,
        ______________,
        _______________,
        ________________,
        _________________,
      ) =>
          isLocal,
      proto: (
        _,
        __,
        ___,
        endpoint,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ____________,
      ) =>
          false,
      jrpc: (
        _,
        __,
        ___,
        endpoint,
        _____,
        ______,
        _______,
        ________,
        _________,
        __________,
        ___________,
        ____________,
      ) =>
          false,
    );
  }

  ConnectionData? _getConnection() {
    final id = connection?.id;

    return switch (_connectionType) {
      ConnectionType.jrpc => ConnectionData.jrpcCustom(
          id: id,
          name: nameController.text,
          group: 'custom',
          networkType: selectedNetworkType,
          endpoint: _endpointsControllers![0].text,
          blockExplorerUrl: blockExplorerUrlController.text,
          manifestUrl: manifestUrlController.text,
          nativeTokenTicker: currencySymbolController.text,
        ),
      ConnectionType.gql => ConnectionData.gqlCustom(
          id: id,
          name: nameController.text,
          group: 'custom',
          networkType: selectedNetworkType,
          endpoints: [
            for (final controller in _endpointsControllers!) controller.text,
          ],
          isLocal: _isLocal,
          blockExplorerUrl: blockExplorerUrlController.text,
          manifestUrl: manifestUrlController.text,
          nativeTokenTicker: currencySymbolController.text,
        ),
      ConnectionType.proto => ConnectionData.protoCustom(
          id: id,
          name: nameController.text,
          group: 'custom',
          networkType: selectedNetworkType,
          endpoint: _endpointsControllers![0].text,
          blockExplorerUrl: blockExplorerUrlController.text,
          manifestUrl: manifestUrlController.text,
          nativeTokenTicker: currencySymbolController.text,
        ),
      _ => null,
    };
  }
}
