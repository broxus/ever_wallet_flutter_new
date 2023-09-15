import 'package:app/di/di.dart';
import 'package:app/feature/profile/profile.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Entry point for screen with information about account
class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({
    required this.address,
    super.key,
  });

  final Address address;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountDetailCubit>(
      create: (_) => AccountDetailCubit(
        address: address,
        nekotonRepository: inject<NekotonRepository>(),
        balanceService: inject(),
        convertService: inject(),
        currentAccountsService: inject(),
      )..init(),
      child: BlocConsumer<AccountDetailCubit, AccountDetailState>(
        listener: (context, state) {
          state.whenOrNull(empty: () => context.pop());
        },
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () => const Scaffold(
              appBar: DefaultAppBar(),
            ),
            data: (account, balance) {
              return Scaffold(
                appBar: DefaultAppBar(
                  actions: [
                    CommonIconButton.svg(
                      svg: Assets.images.settings.path,
                      buttonType: EverButtonType.secondary,
                      size: CommonIconButtonSize.small,
                      onPressed: () => showAccountSettingsSheet(
                        context: context,
                        address: account.address,
                        showHiding: false,
                      ),
                    ),
                  ],
                ),
                body: AccountDetailView(account: account, balance: balance),
              );
            },
          );
        },
      ),
    );
  }
}
