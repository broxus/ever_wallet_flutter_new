import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_cubit.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/export_seed_sheet/export_seed_save_phrase.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper method that shows the [ExportSeedSheet] bottom sheet.
ModalRoute<void> exportSeedSheetRoute(String publicKey) {
  return commonBottomSheetRoute<void>(
    title: LocaleKeys.enterPasswordTo.tr(
      args: [LocaleKeys.exportWord.tr().toLowerCase()],
    ),
    useAppBackgroundColor: true,
    body: (_, __) => BlocProvider<ExportSeedCubit>(
      create: (_) => ExportSeedCubit(
        inject<NekotonRepository>(),
        publicKey,
      ),
      child: ExportSeedSheet(publicKey: publicKey),
    ),
  );
}

/// Sheet that allows user to enter password and export seed phrase.
class ExportSeedSheet extends StatelessWidget {
  const ExportSeedSheet({
    required this.publicKey,
    super.key,
  });

  final String publicKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportSeedCubit, ExportSeedState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (error) => inject<MessengerService>().show(
            Message.error(message: error),
          ),
          success: (phrase) {
            Navigator.of(context)
              ..pop()
              ..push(exportSeedSavePhraseRoute(phrase));
          },
        );
      },
      builder: (context, _) {
        return EnterPasswordWidget(
          onPasswordEntered: (password) =>
              context.read<ExportSeedCubit>().export(password),
          publicKey: publicKey,
        );
      },
    );
  }
}
