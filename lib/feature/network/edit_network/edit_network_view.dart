import 'package:app/app/router/router.dart';
import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/network/edit_network/connection_type.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

const _maxNetworkNameLength = 32;
const _maxCurrencySymbolLength = 16;

class EditNetworkView extends StatefulWidget {
  EditNetworkView({required this.connection, super.key})
      : editable = connection?.canBeEdited ?? true;

  final ConnectionData? connection;
  final bool editable;

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
            _formBuilder(),
            _bottomSpacerBuilder(),
          ],
        ),
        _buttonsBuilder(),
      ],
    );
  }

  Widget _formBuilder() {
    return Form(
      key: _formKey,
      child: SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimensSize.d16,
          ),
          child: SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._typeBuilder(),
              ..._nameBuilder(),
              ..._endpointsBuilder(),
              ..._currencySymbolBuilder(),
              ..._blockExplorerBuilder(),
              ..._tockenListBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _typeBuilder() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkType.tr(),
          style: StyleRes.secondaryBold,
        ),
      ),
      ShapedContainerColumn(
        margin: EdgeInsets.zero,
        mainAxisSize: MainAxisSize.min,
        separator: const CommonDivider(),
        children: [
          _typeComponentBuilder(
            LocaleKeys.networkTypeJRPC.tr(),
            ConnectionType.jrpc,
          ),
          _typeComponentBuilder(
            LocaleKeys.networkTypeGraphQL.tr(),
            ConnectionType.gql,
          ),
          _typeComponentBuilder(
            LocaleKeys.networkTypeProto.tr(),
            ConnectionType.proto,
          ),
        ],
      ),
    ];
  }

  List<Widget> _nameBuilder() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkName.tr(),
          style: StyleRes.secondaryBold,
        ),
      ),
      CommonInput(
        controller: _nameController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkNameHint.tr(),
        enabled: widget.editable,
        validator: _nameValidator.validate,
        validateMode: AutovalidateMode.onUserInteraction,
      ),
    ];
  }

  List<Widget> _endpointsBuilder() {
    void onLocalChanged({required bool value}) {
      if (!widget.editable) {
        return;
      }
      setState(() {
        _isLocal = value;
      });
    }

    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkEndpoint.plural(
            _endpointsControllers.length,
          ),
          style: StyleRes.secondaryBold,
        ),
      ),
      ..._endpointsControllers.mapIndexed(_endpointItemBuilder),
      if (_connectionType.enableLocal)
        Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.networkEndpointLocal.tr(),
                style: StyleRes.secondaryBold,
              ),
            ),
            CommonSwitchInput(
              value: _isLocal,
              onChanged: (value) => onLocalChanged(value: value),
            ),
          ],
        ),
    ];
  }

  Widget _endpointItemBuilder(int index, TextEditingController controller) {
    final colors = context.themeStyle.colors;
    void onAdd() {
      setState(() {
        _endpointsControllers.add(TextEditingController());
      });
    }

    void onRemove() {
      setState(() {
        _endpointsControllers.removeAt(index);
      });
    }

    return SeparatedRow(
      children: [
        Expanded(
          child: CommonInput(
            controller: controller,
            needClearButton: false,
            autocorrect: false,
            hintText: LocaleKeys.networkEndpointHint.tr(),
            suffixIcon: index == 0 &&
                    widget.editable &&
                    _connectionType.enableMultipleEndpoints
                ? CommonIconButton.svg(
                    color: colors.blue,
                    svg: Assets.images.plus.path,
                    buttonType: EverButtonType.ghost,
                    onPressed: onAdd,
                  )
                : null,
            enabled: widget.editable,
            validator: _nonOptionalUrlValidator.validate,
            validateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
        if (index > 0 && widget.editable)
          CommonIconButton.svg(
            color: colors.alert,
            svg: Assets.images.trash.path,
            buttonType: EverButtonType.secondary,
            onPressed: onRemove,
          ),
      ],
    );
  }

  List<Widget> _currencySymbolBuilder() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkCurrencySymbol.tr(),
          style: StyleRes.secondaryBold,
        ),
      ),
      CommonInput(
        controller: _currencySymbolController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkCurrencySymbolHint.tr(),
        enabled: widget.editable,
        validator: _currencySymbolValidator.validate,
        validateMode: AutovalidateMode.onUserInteraction,
      ),
    ];
  }

  List<Widget> _blockExplorerBuilder() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkBlockExplorer.tr(),
          style: StyleRes.secondaryBold,
        ),
      ),
      CommonInput(
        controller: _blockExplorerUrlController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkBlockExplorerHint.tr(),
        enabled: widget.editable,
        validator: _optionalUrlValidator.validate,
        validateMode: AutovalidateMode.onUserInteraction,
      ),
    ];
  }

  List<Widget> _tockenListBuilder() {
    final colors = context.themeStyle.colors;

    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkTokenList.tr(),
          style: StyleRes.secondaryBold,
        ),
      ),
      CommonInput(
        controller: _manifestUrlController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkTokenListHint.tr(),
        enabled: widget.editable,
        validator: _optionalUrlValidator.validate,
        validateMode: AutovalidateMode.onUserInteraction,
      ),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: LocaleKeys.networkTokenListText.tr(),
              style: StyleRes.addRegular,
            ),
            TextSpan(
              text: LocaleKeys.networkTokenListTextLink.tr(),
              style: StyleRes.addRegular.copyWith(color: colors.blue),
              recognizer: TapGestureRecognizer()
                ..onTap = _onTokenListTextLinkTap,
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ];
  }

  Widget _typeComponentBuilder(String title, ConnectionType type) {
    final onPressed = widget.editable
        ? () {
            _onChangeType(type);
          }
        : null;

    return CommonListTile(
      titleText: title,
      trailing: CommonCheckboxInput(
        checked: _connectionType == type,
        onChanged: onPressed != null
            ? (value) {
                if (value) onPressed.call();
              }
            : null,
      ),
      onPressed: onPressed,
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

  Widget _buttonsBuilder() {
    final colors = context.themeStyle.colors;

    final saveButtonText = widget.connection == null
        ? LocaleKeys.networkAdd.tr()
        : LocaleKeys.networkSave.tr();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: colors.gradient,
        ),
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(DimensSize.d16),
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_deleteEnabled)
              CommonButton.secondary(
                text: LocaleKeys.networkDelete.tr(),
                onPressed: _onDelete,
                fillWidth: true,
              ),
            if (_saveEnabled)
              CommonButton.primary(
                text: saveButtonText,
                onPressed: _onSave,
                fillWidth: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _bottomSpacerBuilder() {
    final buttonCount = (_deleteEnabled ? 1 : 0) + (_saveEnabled ? 1 : 0);

    return SliverSafeArea(
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: buttonCount * commonButtonHeight + DimensSize.d16,
        ),
      ),
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
    );
  }

  void _onTokenListTextLinkTap() =>
      browserNewTab(context, LocaleKeys.networkTokenListTextLinkUrl.tr());

  void _onDelete() {
    context.read<ManageNetworksBloc>().add(
          ManageNetworksEvent.removeConnection(
            id: widget.connection!.id,
          ),
        );
    context.clearQueryParamsAndPop();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final connection = _getConnection();

    final event = widget.connection != null
        ? ManageNetworksEvent.updateConnection(
            connection: connection,
          )
        : ManageNetworksEvent.addConnection(
            connection: connection,
          );

    context.read<ManageNetworksBloc>().add(event);

    final newlyCreatedConnectionId =
        widget.connection == null ? connection.id : null;

    context.clearQueryParamsAndPop(newlyCreatedConnectionId);
  }

  ConnectionData _getConnection() {
    final id = widget.connection?.id;

    return switch (_connectionType) {
      ConnectionType.jrpc => ConnectionData.jrpcCustom(
          id: id,
          name: _nameController.text,
          group: 'custom',
          endpoint: _endpointsControllers[0].text,
          networkType: NetworkType.custom,
          blockExplorerUrl: _blockExplorerUrlController.text,
          manifestUrl: _manifestUrlController.text,
          nativeTokenTicker: _currencySymbolController.text,
        ),
      ConnectionType.gql => ConnectionData.gqlCustom(
          id: id,
          name: _nameController.text,
          group: 'custom',
          endpoints: _endpointsControllers
              .map((controller) => controller.text)
              .toList(),
          networkType: NetworkType.custom,
          isLocal: _isLocal,
          blockExplorerUrl: _blockExplorerUrlController.text,
          manifestUrl: _manifestUrlController.text,
          nativeTokenTicker: _currencySymbolController.text,
        ),
      ConnectionType.proto => ConnectionData.protoCustom(
          id: id,
          name: _nameController.text,
          group: 'custom',
          endpoint: _endpointsControllers[0].text,
          networkType: NetworkType.custom,
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
        _____,
        ______,
        isLocal,
        ________,
        _________,
        __________,
        ___________,
        ____________,
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
      ) =>
          false,
    );
  }
}
