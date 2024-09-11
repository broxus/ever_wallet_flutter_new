import 'package:app/di/di.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_local_account_type_sheet/add_new_local_account_type_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Helper function to display AddNewLocalAccountTypeSheet
ModalRoute<void> showAddNewLocalAccountTypeSheet({
  required BuildContext context,
  required PublicKey publicKey,
  required String name,
}) {
  return commonBottomSheetRoute(
    titleTextStyle: context.themeStyleV2.textStyles.headingLarge,
    title: LocaleKeys.newAccountType.tr(),
    body: (_, scrollController) => BlocProvider<AddNewLocalAccountTypeCubit>(
      create: (_) => AddNewLocalAccountTypeCubit(
        publicKey,
        name,
        inject<NekotonRepository>(),
      )..init(),
      child: AddNewLocalAccountTypeSheet(
        controller: scrollController,
      ),
    ),
  );
}

/// Sheet to select type of local account, that user can select for creation.
class AddNewLocalAccountTypeSheet extends StatelessWidget {
  const AddNewLocalAccountTypeSheet({
    required this.controller,
    super.key,
  });

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewLocalAccountTypeCubit,
        AddNewLocalAccountTypeState>(
      listener: (context, state) {
        state.whenOrNull(
          data: (_, __, ___, ____, isCompleted) {
            if (isCompleted) {
              Navigator.of(context).pop();
            }
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          data: (
            availableAccounts,
            defaultAccount,
            createdAccounts,
            currentSelected,
            _,
          ) {
            return SeparatedColumn(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: SeparatedColumn(
                      mainAxisSize: MainAxisSize.min,
                      separator: const Padding(
                        padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
                        child: CommonDivider(),
                      ),
                      children: [
                        _accountItem(
                          type: defaultAccount,
                          isSelected: currentSelected == defaultAccount,
                          isCreated: createdAccounts.contains(defaultAccount),
                          isDefault: true,
                        ),
                        ...availableAccounts.map(
                          (a) => _accountItem(
                            type: a,
                            isSelected: currentSelected == a,
                            isCreated: createdAccounts.contains(a),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PrimaryButton(
                  buttonShape: ButtonShape.pill,
                  title: LocaleKeys.confirm.tr(),
                  onPressed: () => context
                      .read<AddNewLocalAccountTypeCubit>()
                      .createAccount(context),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// [isSelected] means that account is selected during this adding.
  /// [isCreated] means that account was already created before and it can't be
  /// selected or unselected.
  Widget _accountItem({
    required WalletType type,
    required bool isSelected,
    required bool isCreated,
    bool isDefault = false,
  }) {
    final name =
        inject<NekotonRepository>().currentTransport.defaultAccountName(type);

    return Builder(
      builder: (context) {
        final theme = context.themeStyleV2;

        return CommonListTile(
          height: DimensSize.d40,
          titleChild: Text(
            isDefault ? LocaleKeys.accountDefault.tr(args: [name]) : name,
            style: theme.textStyles.labelMedium.copyWith(
              color: isDefault ? theme.colors.content3 : theme.colors.content0,
            ),
          ),
          onPressed: isCreated
              ? null
              : () =>
                  context.read<AddNewLocalAccountTypeCubit>().changeType(type),
          trailing: CommonRadio<WalletType>(
            value: type,
            groupValue: isCreated || isSelected ? type : null,
            enabled: !isCreated,
          ),
        );
      },
    );
  }
}
