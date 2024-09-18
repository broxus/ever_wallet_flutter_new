import 'package:app/app/service/secure_storage_service.dart';
import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/profile/manage_seeds_accounts/manage_seeds_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/components/common/common.dart';

/// Root widget for manage seeds and accounts feature
class ManageSeedsAccountsPage extends StatelessWidget {
  const ManageSeedsAccountsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageSeedsAccountsCubit>(
      create: (_) => ManageSeedsAccountsCubit(
        inject<NekotonRepository>(),
        inject<CurrentSeedService>(),
        inject<SecureStorageService>(),
      )..init(),
      child: const Scaffold(
        appBar: DefaultAppBar(),
        body: ManageSeedsAccountsView(),
      ),
    );
  }
}
