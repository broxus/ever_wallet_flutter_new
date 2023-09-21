import 'package:app/feature/browser/browser.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EditNetworkView extends StatefulWidget {
  const EditNetworkView({super.key});

  @override
  State<EditNetworkView> createState() => _EditNetworkViewState();
}

class _EditNetworkViewState extends State<EditNetworkView> {
  int _buttonCount = 1;
  bool _multipleEndpoints = true;

  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController = TextEditingController();

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
          _typeComponentBuilder(LocaleKeys.networkTypeJRPC.tr()),
          _typeComponentBuilder(LocaleKeys.networkTypeGraphQL.tr()),
          _typeComponentBuilder(LocaleKeys.networkTypeProto.tr()),
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
      ),
    ];
  }

  List<Widget> _endpointsBuilder() {
    final colors = context.themeStyle.colors;

    return [
      Padding(
        padding: const EdgeInsets.only(
          top: DimensSize.d12,
        ),
        child: Text(
          LocaleKeys.networkEndpoint.tr(),
          style: StyleRes.secondaryBold,
        ),
      ),
      CommonInput(
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkEndpointHint.tr(),
        suffixIcon: CommonIconButton.svg(
          color: colors.blue,
          svg: Assets.images.plus.path,
          buttonType: EverButtonType.ghost,
          onPressed: () {},
        ),
      ),
      SeparatedRow(
        children: [
          Expanded(
            child: CommonInput(
              needClearButton: false,
              autocorrect: false,
              hintText: LocaleKeys.networkEndpointHint.tr(),
            ),
          ),
          CommonIconButton.svg(
            color: colors.alert,
            svg: Assets.images.trash.path,
            buttonType: EverButtonType.secondary,
            onPressed: () {},
          ),
        ],
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.networkEndpointLocal.tr(),
              style: StyleRes.secondaryBold,
            ),
          ),
          CommonSwitchInput(
            value: false,
            onChanged: (bool value) {},
          ),
        ],
      ),
    ];
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
        controller: _nameController,
        needClearButton: false,
        autocorrect: false,
        hintText: LocaleKeys.networkCurrencySymbolHint.tr(),
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

  Widget _typeComponentBuilder(String title) {
    return CommonListTile(
      titleText: title,
      trailing: CommonCheckboxInput(
        checked: false,
        // onChanged: widget.clearHistoryEnabled
        //     ? (value) => setState(
        //           () => _clearHistory = value,
        //         )
        //     : null,
      ),
      // onPressed: widget.clearHistoryEnabled
      //     ? () {
      //         setState(() => _clearHistory = !_clearHistory);
      //       }
      //     : null,
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
}
