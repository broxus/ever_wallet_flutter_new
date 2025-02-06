import 'package:app/di/di.dart';
import 'package:app/feature/bootstrap_failed/bootstrap_failed.dart';
import 'package:app/feature/contact_support/widgets/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Simple view (not created design), that allows just rerun bootstrap process
class BootstrapFailedRerunView extends StatelessWidget {
  const BootstrapFailedRerunView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeStyle.colors;

    return BlocProvider<BootstrapRerunCubit>(
      create: (_) => BootstrapRerunCubit(inject()),
      child: Padding(
        padding: const EdgeInsets.all(DimensSize.d16),
        child: Center(
          child: SeparatedColumn(
            separatorSize: DimensSize.d32,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                LocaleKeys.initializationFailedDescription.tr(),
                style: StyleRes.addRegular.copyWith(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<BootstrapRerunCubit, bool>(
                    builder: (context, isLoading) {
                      return CommonButton.primary(
                        fillWidth: true,
                        text: LocaleKeys.tryAgain.tr(),
                        isLoading: isLoading,
                        onPressed: () =>
                            context.read<BootstrapRerunCubit>().rerun(context),
                      );
                    },
                  ),
                  const SizedBox(height: DimensSize.d16),
                  CommonButton.primary(
                    fillWidth: true,
                    text: LocaleKeys.contactSupport.tr(),
                    onPressed: () => showContactSupportSheet(
                      context: context,
                      mode: ContactSupportMode.initiatedByCrash,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
