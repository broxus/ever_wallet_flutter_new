import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _maxNetworkNameLength = 32;
const _maxCurrencySymbolLength = 16;

class EditNetworkView extends StatefulWidget {
  EditNetworkView({
    required this.connection,
    required this.onAdd,
    required this.onUpdate,
    required this.onRemove,
    super.key,
  }) : editable = connection?.canBeEdited ?? true;

  final ConnectionData? connection;
  final bool editable;
  final ValueChanged<ConnectionData> onAdd;
  final ValueChanged<ConnectionData> onUpdate;
  final ValueChanged<String> onRemove;

  @override
  State<EditNetworkView> createState() => _EditNetworkViewState();
}

class _EditNetworkViewState extends State<EditNetworkView> {
  final _formKey = GlobalKey<FormState>();

  late ConnectionType _connectionType;
  final _nameController = TextEditingController();
  late List<TextEditingController> _endpointsControllers;
  final _currencySymbolController = TextEditingController();
  final _blockExplorerUrlController = TextEditingController();
  final _manifestUrlController = TextEditingController();
  late bool _isLocal;

  late final bool _deleteEnabled;
  late final bool _saveEnabled;

  final _nameValidator = CommonTextValidator(
    minLength: 1,
    maxLength: _maxNetworkNameLength,
    emptyError: LocaleKeys.textFieldShouldNotBeEmpty.tr(),
    maxLengthError: LocaleKeys.textFieldTooLong.tr(
      args: [
        _maxNetworkNameLength.toString(),
      ],
    ),
  );

  final _currencySymbolValidator = CommonTextValidator(
    maxLength: _maxCurrencySymbolLength,
    maxLengthError: LocaleKeys.textFieldTooLong.tr(
      args: [
        _maxCurrencySymbolLength.toString(),
      ],
    ),
  );

  final _nonOptionalUrlValidator = UrlTextValidator(
    emptyError: LocaleKeys.urlFieldShouldNotBeEmpty.tr(),
    schemeError: LocaleKeys.urlFieldShouldHasScheme.tr(),
    hostError: LocaleKeys.urlFieldShouldHasHost.tr(),
  );

  final _optionalUrlValidator = UrlTextValidator(
    schemeError: LocaleKeys.urlFieldShouldHasScheme.tr(),
    hostError: LocaleKeys.urlFieldShouldHasHost.tr(),
  );

  @override
  void initState() {
    super.initState();

    _connectionType = widget.connection == null
        ? ConnectionType.jrpc
        : ConnectionType.fromConnection(widget.connection!);

    _nameController.text = widget.connection?.name ?? '';
    _endpointsControllers = _getEndpointsControllers();
    _currencySymbolController.text = widget.connection?.nativeTokenTicker ?? '';
    _blockExplorerUrlController.text =
        widget.connection?.blockExplorerUrl ?? '';
    _manifestUrlController.text = widget.connection?.manifestUrl ?? '';
    _isLocal = _getIsLocal();

    _deleteEnabled = widget.connection != null && widget.editable;
    _saveEnabled = widget.editable;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CustomScrollView(
          slivers: [
            Form(
              key: _formKey,
              child: SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(DimensSizeV2.d16),
                  child: SeparatedColumn(
                    separatorSize: DimensSizeV2.d24,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TypeField(
                        connectionType: _connectionType,
                        editable: widget.editable,
                        onChangeType: _onChangeType,
                      ),
                      NameField(
                        editable: widget.editable,
                        controller: _nameController,
                        validator: _nameValidator,
                      ),
                      EndpointsField(
                        editable: widget.editable,
                        endpointsControllers: _endpointsControllers,
                        connectionType: _connectionType,
                        validator: _nonOptionalUrlValidator,
                        isLocal: _isLocal,
                        onLocalChanged: (value) {
                          if (!widget.editable) {
                            return;
                          }
                          setState(() {
                            _isLocal = value;
                          });
                        },
                        onAdd: () => setState(() {
                          _endpointsControllers.add(TextEditingController());
                        }),
                        onRemove: (index) => setState(() {
                          _endpointsControllers.removeAt(index);
                        }),
                      ),
                      CurrencyField(
                        editable: widget.editable,
                        controller: _currencySymbolController,
                        validator: _currencySymbolValidator,
                      ),
                      BlockExplorerField(
                        validator: _optionalUrlValidator,
                        editable: widget.editable,
                        controller: _blockExplorerUrlController,
                      ),
                      TokenListField(
                        editable: widget.editable,
                        controller: _manifestUrlController,
                        validator: _optionalUrlValidator,
                        onTap: _onTokenListTextLinkTap,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BottomSpacer(
              deleteEnabled: _deleteEnabled,
              saveEnabled: _saveEnabled,
            ),
          ],
        ),
        NetworkButtons(
          saveEnabled: _saveEnabled,
          deleteEnabled: _deleteEnabled,
          connection: widget.connection,
          onSave: _onSave,
          onDelete: _onDelete,
        ),
      ],
    );
  }

  void _onChangeType(ConnectionType type) {
    setState(
      () {
        _connectionType = type;
        if (!type.enableMultipleEndpoints) {
          _endpointsControllers = [_endpointsControllers.first];
        }
      },
    );
  }

  void _onTokenListTextLinkTap() =>
      browserNewTab(context, LocaleKeys.networkTokenListTextLinkUrl.tr());

  Future<void> _onDelete() async {
    final result = await showDeleteNetworkConfirmationSheet(
      context: context,
      networkName: widget.connection!.name,
    );

    if ((result ?? false) && mounted) {
      widget.onRemove(widget.connection!.id);
      context.clearQueryParamsAndPop();
    }
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final connection = _getConnection();

    if (widget.connection == null) {
      widget.onAdd(connection);
    } else {
      widget.onUpdate(connection);
    }

    if (widget.connection == null) {
      await showSwitchToThisNetworkSheet(
        context: context,
        connectionId: connection.id,
      );
    }

    if (mounted) {
      context.clearQueryParamsAndPop();
    }
  }

  ConnectionData _getConnection() {
    final id = widget.connection?.id;

    return switch (_connectionType) {
      ConnectionType.jrpc => ConnectionData.jrpcCustom(
          id: id,
          name: _nameController.text,
          group: 'custom',
          networkType: 'custom',
          endpoint: _endpointsControllers[0].text,
          blockExplorerUrl: _blockExplorerUrlController.text,
          manifestUrl: _manifestUrlController.text,
          nativeTokenTicker: _currencySymbolController.text,
        ),
      ConnectionType.gql => ConnectionData.gqlCustom(
          id: id,
          name: _nameController.text,
          group: 'custom',
          networkType: 'custom',
          endpoints: _endpointsControllers
              .map((controller) => controller.text)
              .toList(),
          isLocal: _isLocal,
          blockExplorerUrl: _blockExplorerUrlController.text,
          manifestUrl: _manifestUrlController.text,
          nativeTokenTicker: _currencySymbolController.text,
        ),
      ConnectionType.proto => ConnectionData.protoCustom(
          id: id,
          name: _nameController.text,
          group: 'custom',
          networkType: 'custom',
          endpoint: _endpointsControllers[0].text,
          blockExplorerUrl: _blockExplorerUrlController.text,
          manifestUrl: _manifestUrlController.text,
          nativeTokenTicker: _currencySymbolController.text,
        ),
    };
  }

  // ignore: long-method
  List<TextEditingController> _getEndpointsControllers() {
    if (widget.connection == null) {
      return [
        TextEditingController(),
      ];
    }

    return widget.connection!.when(
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
              .map(
                (endpoint) => TextEditingController(text: endpoint),
              )
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
          [
        TextEditingController(text: endpoint),
      ],
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
          [
        TextEditingController(text: endpoint),
      ],
    );
  }

  bool _getIsLocal() {
    if (widget.connection == null) {
      return false;
    }

    return widget.connection!.when(
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
}
