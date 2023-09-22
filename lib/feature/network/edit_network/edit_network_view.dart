import 'package:app/data/models/models.dart';
import 'package:app/feature/browser/browser.dart';
import 'package:app/feature/network/edit_network/connection_type.dart';
import 'package:app/generated/generated.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EditNetworkView extends StatefulWidget {
  EditNetworkView({required this.connection, super.key})
      : editable = connection?.canBeEdited ?? true;

  final ConnectionData? connection;
  final bool editable;

  @override
  State<EditNetworkView> createState() => _EditNetworkViewState();
}

class _EditNetworkViewState extends State<EditNetworkView> {
  int _buttonCount = 1;

  final _formKey = GlobalKey<FormState>();

  late ConnectionType _connectionType;
  late final TextEditingController _nameController = TextEditingController();
  late List<TextEditingController> _endpointsControllers;
  late final TextEditingController _currencySymbolController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _connectionType = widget.connection == null
        ? ConnectionType.jrpc
        : ConnectionType.fromConnection(widget.connection!);

    _nameController.text = widget.connection?.name ?? '';
    _endpointsControllers = _getEndpointsControllers();
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
      ),
    ];
  }

  List<Widget> _endpointsBuilder() {
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
        controller: _nameController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkBlockExplorerHint.tr(),
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
        controller: _nameController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkTokenListHint.tr(),
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
        child: CommonButton.primary(
          // text: widget.buttonText,
          // onPressed: widget.onButtonPressed,
          fillWidth: true,
        ),
      ),
    );
  }

  Widget _bottomSpacerBuilder() {
    return SliverSafeArea(
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: _buttonCount * commonButtonHeight + DimensSize.d16,
        ),
      ),
      minimum: const EdgeInsets.only(bottom: DimensSize.d16),
    );
  }

  void _onTokenListTextLinkTap() =>
      browserNewTab(context, LocaleKeys.networkTokenListTextLinkUrl.tr());

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
}
