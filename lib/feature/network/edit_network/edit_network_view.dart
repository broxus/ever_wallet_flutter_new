import 'package:app/app/router/router.dart';
import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/network/edit_network/connection_type.dart';
import 'package:app/feature/network/network.dart';
import 'package:app/feature/wallet/wallet_deploy/clipboard_paste_button.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

const _maxNetworkNameLength = 32;
const _maxCurrencySymbolLength = 16;

// TODO(komarov): refactor
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
          padding: const EdgeInsets.all(DimensSizeV2.d16),
          child: SeparatedColumn(
            separatorSize: DimensSizeV2.d24,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _typeBuilder(),
              _nameBuilder(),
              _endpointsBuilder(),
              _currencySymbolBuilder(),
              _blockExplorerBuilder(),
              _tokenListBuilder(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeBuilder() {
    return _FormField(
      label: LocaleKeys.networkType.tr(),
      child: PrimaryCard(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(DimensRadiusV2.radius16),
        child: SeparatedColumn(
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
      ),
    );
  }

  Widget _nameBuilder() {
    return _FormField(
      label: LocaleKeys.networkName.tr(),
      child: PrimaryTextField(
        textEditingController: _nameController,
        hintText: LocaleKeys.networkNameHint.tr(),
        isEnabled: widget.editable,
        validator: _nameValidator.validate,
      ),
    );
  }

  Widget _endpointsBuilder() {
    void onLocalChanged({required bool value}) {
      if (!widget.editable) {
        return;
      }
      setState(() {
        _isLocal = value;
      });
    }

    void onAdd() {
      setState(() {
        _endpointsControllers.add(TextEditingController());
      });
    }

    return _FormField(
      label: LocaleKeys.networkEndpoint.plural(_endpointsControllers.length),
      trailing: widget.editable && _connectionType.enableMultipleEndpoints
          ? GhostButton(
              buttonShape: ButtonShape.square,
              buttonSize: ButtonSize.small,
              icon: LucideIcons.plus,
              onPressed: onAdd,
            )
          : null,
      child: SeparatedColumn(
        children: [
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
                Switch(
                  value: _isLocal,
                  onChanged: (value) => onLocalChanged(value: value),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _endpointItemBuilder(int index, TextEditingController controller) {
    void onRemove() {
      setState(() {
        _endpointsControllers.removeAt(index);
      });
    }

    return PrimaryTextField(
      textEditingController: controller,
      hintText: index == 0
          ? LocaleKeys.networkEndpointHint.tr()
          : LocaleKeys.networkAdditionalEndpointHint.tr(),
      isEnabled: widget.editable,
      validator: _nonOptionalUrlValidator.validate,
      suffixes: [
        _PasteButton(
          parentController: controller,
        ),
        if (index > 0 && widget.editable)
          Padding(
            padding: const EdgeInsets.only(right: DimensSizeV2.d8),
            child: PrimaryButton(
              buttonShape: ButtonShape.square,
              buttonSize: ButtonSize.small,
              icon: LucideIcons.trash,
              onPressed: onRemove,
            ),
          ),
      ],
    );
  }

  Widget _currencySymbolBuilder() {
    return _FormField(
      label: LocaleKeys.networkCurrencySymbol.tr(),
      child: PrimaryTextField(
        textEditingController: _currencySymbolController,
        hintText: LocaleKeys.networkCurrencySymbolHint.tr(),
        isEnabled: widget.editable,
        validator: _currencySymbolValidator.validate,
      ),
    );
  }

  Widget _blockExplorerBuilder() {
    return _FormField(
      label: LocaleKeys.networkBlockExplorer.tr(),
      child: PrimaryTextField(
        textEditingController: _blockExplorerUrlController,
        hintText: LocaleKeys.networkBlockExplorerHint.tr(),
        isEnabled: widget.editable,
        validator: _optionalUrlValidator.validate,
        suffixes: [
          _PasteButton(
            parentController: _blockExplorerUrlController,
          ),
        ],
      ),
    );
  }

  Widget _tokenListBuilder() {
    final theme = context.themeStyleV2;

    return _FormField(
      label: LocaleKeys.networkTokenList.tr(),
      child: SeparatedColumn(
        children: [
          PrimaryTextField(
            textEditingController: _manifestUrlController,
            hintText: LocaleKeys.networkTokenListHint.tr(),
            isEnabled: widget.editable,
            validator: _optionalUrlValidator.validate,
            suffixes: [
              _PasteButton(
                parentController: _manifestUrlController,
              ),
            ],
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: LocaleKeys.networkTokenListText.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content3,
                  ),
                ),
                TextSpan(
                  text: LocaleKeys.networkTokenListTextLink.tr(),
                  style: theme.textStyles.labelXSmall.copyWith(
                    color: theme.colors.content0,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _onTokenListTextLinkTap,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _typeComponentBuilder(String title, ConnectionType type) {
    final theme = context.themeStyleV2;
    final onPressed = widget.editable
        ? () {
            _onChangeType(type);
          }
        : null;

    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        height: DimensSizeV2.d56,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensSizeV2.d16),
          child: SeparatedRow(
            children: [
              Expanded(
                child: Text(title, style: theme.textStyles.labelSmall),
              ),
              if (_connectionType == type)
                const Icon(LucideIcons.check, size: DimensSizeV2.d20),
            ],
          ),
        ),
      ),
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
    final theme = context.themeStyleV2;

    final saveButtonText = widget.connection == null
        ? LocaleKeys.networkAdd.tr()
        : LocaleKeys.networkSave.tr();

    return ColoredBox(
      color: theme.colors.background0,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(
          vertical: DimensSizeV2.d12,
          horizontal: DimensSizeV2.d16,
        ),
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_saveEnabled)
              AccentButton(
                buttonShape: ButtonShape.pill,
                title: saveButtonText,
                onPressed: _onSave,
              ),
            if (_deleteEnabled)
              DestructiveButton(
                buttonShape: ButtonShape.pill,
                title: LocaleKeys.networkDelete.tr(),
                onPressed: _onDelete,
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
          height: buttonCount * commonButtonHeight + DimensSizeV2.d16,
        ),
      ),
      minimum: const EdgeInsets.only(bottom: DimensSizeV2.d16),
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
      context.read<ManageNetworksBloc>().add(
            ManageNetworksEvent.removeConnection(
              id: widget.connection!.id,
            ),
          );
      context.clearQueryParamsAndPop();
    }
  }

  Future<void> _onSave() async {
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

class _FormField extends StatelessWidget {
  const _FormField({
    required this.label,
    required this.child,
    this.trailing,
  });

  final String label;
  final Widget? trailing;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    final text = Text(
      label,
      style: theme.textStyles.headingXSmall.copyWith(
        color: theme.colors.content3,
      ),
    );

    return SeparatedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (trailing != null)
          SeparatedRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [text, trailing!],
          )
        else
          text,
        child,
      ],
    );
  }
}

class _PasteButton extends StatelessWidget {
  const _PasteButton({
    required this.parentController,
  });

  final TextEditingController parentController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: DimensSizeV2.d8),
      child: ClipboardPasteButton(
        onPressed: _onPressed,
      ),
    );
  }

  Future<void> _onPressed() async {
    final text = await getClipBoardText();
    if (text != null) {
      parentController.text = text;
    }
  }
}
