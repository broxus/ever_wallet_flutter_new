import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point for screen with information about key
class KeyDetailPage extends StatelessWidget {
  const KeyDetailPage({
    required this.publicKey,
    super.key,
  });

  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<KeyDetailCubit>(
      create: (_) => KeyDetailCubit(
        inject<NekotonRepository>(),
        publicKey,
      )..init(),
      child: BlocConsumer<KeyDetailCubit, KeyDetailState>(
        listener: (context, state) =>
            state.whenOrNull(empty: () => context.pop()),
        builder: (context, state) {
          SeedKey? key;
          String? seedName;
          KeyDetailAccountsTab? tab;

          state.whenOrNull(
            data: (k, name, t) {
              key = k;
              seedName = name;
              tab = t;
            },
          );

          final hasData = key != null && seedName != null && tab != null;

          return Scaffold(
            appBar: DefaultAppBar(
              actions: !hasData
                  ? null
                  : [
                      FloatButton(
                        buttonShape: ButtonShape.circle,
                        icon: LucideIcons.cog,
                        buttonSize: ButtonSize.medium,
                        onPressed: () => showKeySettingsSheet(
                          context: context,
                          publicKey: publicKey,
                          isMaster: key!.isMaster,
                        ),
                      ),
                    ],
            ),
            body: !hasData
                ? Container()
                : SafeArea(
                    minimum: const EdgeInsets.only(bottom: DimensSize.d16),
                    child: KeyDetailView(
                      seedKey: key!,
                      seedName: seedName!,
                      tab: tab!,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
