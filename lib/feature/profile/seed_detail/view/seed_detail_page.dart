import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/manage_seeds_accounts/widgets/widgets.dart';
import 'package:app/feature/profile/seed_detail/seed_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

/// Entry point for seed detail screen
class SeedDetailPage extends StatelessWidget {
  const SeedDetailPage({
    required this.publicKey,
    super.key,
  });

  /// Master key of seed
  final PublicKey publicKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        actions: [
          FloatButton(
            buttonShape: ButtonShape.circle,
            icon: LucideIcons.cog,
            buttonSize: ButtonSize.medium,
            onPressed: () => showSeedSettingsSheet(context, publicKey),
          ),
        ],
      ),
      body: BlocProvider<SeedDetailCubit>(
        create: (context) => SeedDetailCubit(
          publicKey,
          inject<CurrentSeedService>(),
          inject<NekotonRepository>(),
          inject<CurrentKeyService>(),
        )..init(),
        child: SeedDetailView(publicKey: publicKey),
      ),
    );
  }
}
