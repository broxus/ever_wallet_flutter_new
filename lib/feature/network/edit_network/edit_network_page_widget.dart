import 'package:app/feature/network/edit_network/edit_network.dart';
import 'package:app/feature/network/edit_network/widgets/network_type_field.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class EditNetworkPageWidget extends ElementaryWidget<EditNetworkWidgetModel> {
  const EditNetworkPageWidget({
    this.connectionDataId,
    Key? key,
    WidgetModelFactory wmFactory = defaultEditNetworkWidgetModelFactory,
  }) : super(wmFactory, key: key);

  final String? connectionDataId;

  @override
  Widget build(EditNetworkWidgetModel wm) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: wm.connection?.name ?? LocaleKeys.addCustomNetwork.tr(),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              Form(
                key: wm.formKey,
                child: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(DimensSizeV2.d16),
                    child: SeparatedColumn(
                      separatorSize: DimensSizeV2.d24,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TypeField(
                          connectionTypeState: wm.connectionTypeState,
                          editable: wm.isEditable,
                          onChangeType: wm.onChangeType,
                        ),
                        if (wm.networkTypesOptions != null)
                          NetworkTypeField(
                            types: wm.networkTypesOptions!,
                            selectedNetworkTypeState:
                                wm.selectedNetworkTypeState,
                            onChanged: wm.onChangedNetworkType,
                          ),
                        NameField(
                          editable: wm.isEditable,
                          controller: wm.nameController,
                          validator: wm.validators.nameValidator,
                        ),
                        EndpointsField(
                          editable: wm.isEditable,
                          endpointsControllersState:
                              wm.endpointsControllersState,
                          connectionTypeState: wm.connectionTypeState,
                          validator: wm.validators.nonOptionalUrlValidator,
                          isLocalState: wm.isLocalState,
                          onLocalChanged: wm.onLocalChanged,
                          onAdd: wm.onAdd,
                          onRemove: wm.onRemove,
                        ),
                        CurrencyField(
                          editable: wm.isEditable,
                          controller: wm.currencySymbolController,
                          validator: wm.validators.currencySymbolValidator,
                        ),
                        BlockExplorerField(
                          validator: wm.validators.optionalUrlValidator,
                          editable: wm.isEditable,
                          controller: wm.blockExplorerUrlController,
                        ),
                        TokenListField(
                          editable: wm.isEditable,
                          controller: wm.manifestUrlController,
                          validator: wm.validators.optionalUrlValidator,
                          onTap: wm.onTokenListTextLinkTap,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BottomSpacer(
                deleteEnabled: wm.isDeleteEnabled,
                saveEnabled: wm.isSaveEnabled,
              ),
            ],
          ),
          NetworkButtons(
            saveEnabled: wm.isSaveEnabled,
            deleteEnabled: wm.isDeleteEnabled,
            connection: wm.connection,
            onSave: wm.onSave,
            onDelete: wm.onDelete,
          ),
        ],
      ),
    );
  }
}
