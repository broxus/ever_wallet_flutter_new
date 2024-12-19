import 'package:app/feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/clipboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class AddExternalAccountView extends StatefulWidget {
  const AddExternalAccountView({super.key});

  @override
  State<AddExternalAccountView> createState() => _AddExternalAccountViewState();
}

class _AddExternalAccountViewState extends State<AddExternalAccountView> {
  final nameController = TextEditingController();
  final nameFocus = FocusNode();

  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    addressController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    nameFocus.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;
    return BlocConsumer<AddNewExternalAccountCubit, AddNewExternalAccountState>(
      listener: (context, state) {
        state.whenOrNull(completed: () => Navigator.of(context).pop());
      },
      builder: (context, state) {
        final isLoading =
            state.maybeWhen(orElse: () => false, loading: () => true);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.addExistingAccountDescription.tr(),
              style: theme.textStyles.paragraphMedium,
            ),
            const SizedBox(height: DimensSizeV2.d24),
            PrimaryTextField(
              textEditingController: nameController,
              focusNode: nameFocus,
              hintText: LocaleKeys.nameWord.tr(),
              onSubmit: (_) => _createAccount(context),
            ),
            const SizedBox(height: DimensSizeV2.d12),
            PrimaryTextField(
              textEditingController: addressController,
              hintText: LocaleKeys.addressWord.tr(),
              onSubmit: (_) => nameFocus.requestFocus(),
              suffixes: [
                if (addressController.text.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DimensSizeV2.d8,
                    ),
                    child: FloatButton(
                      buttonShape: ButtonShape.square,
                      buttonSize: ButtonSize.small,
                      icon: LucideIcons.arrowDownToDot,
                      onPressed: _paste,
                    ),
                  ),
                if (addressController.text.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: DimensSizeV2.d8,
                    ),
                    child: FloatButton(
                      buttonShape: ButtonShape.square,
                      buttonSize: ButtonSize.small,
                      icon: LucideIcons.x,
                      onPressed: addressController.clear,
                    ),
                  ),
              ],
            ),
            const Spacer(),
            AccentButton(
              buttonShape: ButtonShape.pill,
              isLoading: isLoading,
              title: LocaleKeys.addAccount.tr(),
              onPressed: () => _createAccount(context),
            ),
            const SizedBox(height: DimensSizeV2.d12),
          ],
        );
      },
    );
  }

  Future<void> _paste() async {
    final text = await getClipBoardText();
    if (text?.isEmpty ?? true) return;
    addressController.text = text!;
  }

  void _createAccount(BuildContext context) =>
      context.read<AddNewExternalAccountCubit>().createAccount(
            context,
            addressController.text,
            nameController.text,
          );
}
