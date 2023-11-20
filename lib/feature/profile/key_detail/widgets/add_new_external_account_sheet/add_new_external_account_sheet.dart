import 'package:app/di/di.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method to display [AddNewExternalAccountSheet].
Future<void> showAddNewExternalAccountSheet({
  required BuildContext context,
  required PublicKey publicKey,
}) {
  return showCommonBottomSheet(
    context: context,
    useAppBackgroundColor: true,
    title: LocaleKeys.addExistingAccount.tr(),
    subtitle: LocaleKeys.addExistingAccountDescription.tr(),
    body: (_, scrollController) => BlocProvider<AddNewExternalAccountCubit>(
      create: (_) => AddNewExternalAccountCubit(
        publicKey,
        inject<NekotonRepository>(),
      ),
      child: AddNewExternalAccountSheet(
        controller: scrollController,
      ),
    ),
  );
}

/// Sheet that allows to add new external account.
class AddNewExternalAccountSheet extends StatefulWidget {
  const AddNewExternalAccountSheet({
    required this.controller,
    super.key,
  });

  final ScrollController controller;

  @override
  State<AddNewExternalAccountSheet> createState() =>
      _AddNewExternalAccountSheetState();
}

class _AddNewExternalAccountSheetState
    extends State<AddNewExternalAccountSheet> {
  final nameController = TextEditingController();
  final nameFocus = FocusNode();

  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    nameFocus.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child:
          BlocConsumer<AddNewExternalAccountCubit, AddNewExternalAccountState>(
        listener: (context, state) {
          state.whenOrNull(completed: () => Navigator.of(context).pop());
        },
        builder: (context, state) {
          final isLoading =
              state.maybeWhen(orElse: () => false, loading: () => true);

          return SeparatedColumn(
            mainAxisSize: MainAxisSize.min,
            separatorSize: DimensSize.d16,
            children: [
              CommonInput(
                controller: addressController,
                titleText: LocaleKeys.addressWord.tr(),
                onSubmitted: (_) => nameFocus.requestFocus(),
              ),
              CommonInput(
                controller: nameController,
                focusNode: nameFocus,
                titleText: LocaleKeys.nameWord.tr(),
                onSubmitted: (_) => _createAccount(context),
              ),
              CommonButton.primary(
                fillWidth: true,
                isLoading: isLoading,
                text: LocaleKeys.confirm.tr(),
                onPressed: () => _createAccount(context),
              ),
            ],
          );
        },
      ),
    );
  }

  void _createAccount(BuildContext context) =>
      context.read<AddNewExternalAccountCubit>().createAccount(
            addressController.text,
            nameController.text,
          );
}
