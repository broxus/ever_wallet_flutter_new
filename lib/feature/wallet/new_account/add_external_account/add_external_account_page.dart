import 'package:app/di/di.dart';
import 'package:app/feature/profile/key_detail/widgets/add_new_external_account_sheet/add_new_external_account_cubit.dart';
import 'package:app/feature/wallet/new_account/add_external_account/add_external_account_view.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class AddExternalAccountPage extends StatelessWidget {
  const AddExternalAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: LocaleKeys.addExternalAccount.tr(),
        onClosePressed: (context) {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(DimensSizeV2.d16),
        child: BlocProvider(
          create: (context) => AddNewExternalAccountCubit(
            null,
            inject(),
            inject(),
          ),
          child: const AddExternalAccountView(),
        ),
      ),
    );
  }
}
