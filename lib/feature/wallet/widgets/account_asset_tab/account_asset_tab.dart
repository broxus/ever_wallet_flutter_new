import 'package:app/di/di.dart';
import 'package:app/feature/wallet/widgets/account_asset_tab/account_asset_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Tab from <WalletBottomPanel> that allows display list of assets(tokens)
/// related to [account] and manage them.
class AccountAssetsTab extends StatelessWidget {
  const AccountAssetsTab({
    required this.account,
    super.key,
  });

  final KeyAccount account;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountAssetTabCubit>(
      create: (_) => AccountAssetTabCubit(
        account,
        inject<NekotonRepository>(),
      ),
      child: BlocBuilder<AccountAssetTabCubit, AccountAssetTabState>(
        builder: (context, state) {
          final assets = state.when(
            empty: () => <Widget>[],
            account: (account) {
              return <Widget>[];
            },
          );

          return SeparatedColumn(
            separator: const Padding(
              padding: EdgeInsets.symmetric(vertical: DimensSize.d8),
              child: CommonDivider(),
            ),
            children: [],
          );
        },
      ),
    );
  }
}
