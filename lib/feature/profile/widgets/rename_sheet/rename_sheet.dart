import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/widgets/rename_sheet/rename_sheet_cubit.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

export 'rename_sheet_cubit.dart';

/// Helper method to show the [RenameSheet] widget as a bottom sheet.
ModalRoute<void> showRenameSheet(String publicKey) {
  return commonBottomSheetRoute(
    title: LocaleKeys.enterNewName.tr(),
    body: (_, __) => BlocProvider<RenameSheetCubit>(
      create: (_) => RenameSheetCubit(inject<NekotonRepository>(), publicKey),
      child: const RenameSheet(),
    ),
  );
}

/// Sheet that allows enter new name of the seed or public key.
/// This sheet automatically calls rename method for key/seed.
///
/// Snackbar will contains 'seed' if key is master and 'key' if not.
class RenameSheet extends StatefulWidget {
  const RenameSheet({super.key});

  @override
  State<RenameSheet> createState() => _RenameSheetState();
}

class _RenameSheetState extends State<RenameSheet> {
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      mainAxisSize: MainAxisSize.min,
      separatorSize: DimensSize.d24,
      children: [
        CommonInput(
          controller: _nameController,
          titleText: LocaleKeys.nameWord.tr(),
        ),
        BlocConsumer<RenameSheetCubit, RenameSheetState>(
          listener: (context, state) {
            state.whenOrNull(
              completed: (isSeed) {
                inject<MessengerService>().show(
                  Message.successful(
                    message: isSeed
                        ? LocaleKeys.valueRenamed.tr(
                            args: [LocaleKeys.seedPhrase.tr()],
                          )
                        : LocaleKeys.valueRenamed.tr(
                            args: [LocaleKeys.keyWord.tr()],
                          ),
                  ),
                );
                Navigator.of(context).pop();
              },
            );
          },
          builder: (context, state) {
            final isLoading =
                state.maybeWhen(loading: () => true, orElse: () => false);

            return CommonButton.primary(
              fillWidth: true,
              isLoading: isLoading,
              onPressed: () =>
                  context.read<RenameSheetCubit>().rename(_nameController.text),
              text: LocaleKeys.renameWord.tr(),
            );
          },
        ),
      ],
    );
  }
}
