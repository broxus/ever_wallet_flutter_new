import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

/// Helper function to show [ContactSupportSheet].
Future<void> showContactSupportSheet({
  required BuildContext context,
  required ContactSupportMode mode,
}) {
  final title = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportBottomSheetHeaderInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportBottomSheetHeaderInitiatedByCrash.tr(),
  };

  final subtitle = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportBottomSheetTextInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportBottomSheetTextInitiatedByCrash.tr(),
  };

  return showCommonBottomSheet(
    context: context,
    title: title,
    subtitle: subtitle,
    body: (_, __) => BlocProvider(
      create: (context) => ContactSupportBloc(),
      child: BlocListener<ContactSupportBloc, ContactSupportState>(
        listener: (context, state) {
          state.when(
            initial: () {
              Navigator.of(context).pop();
            },
            // ignore: no-empty-block
            busy: () {},
          );
        },
        child: ContactSupportSheet(mode: mode),
      ),
    ),
  );
}

class ContactSupportSheet extends StatelessWidget {
  const ContactSupportSheet({
    required this.mode,
    super.key,
  });

  final ContactSupportMode mode;

  @override
  Widget build(BuildContext context) {
    final buttonText = switch (mode) {
      ContactSupportMode.initiatedByUser =>
        LocaleKeys.contactSupportBottomSheetButtonInitiatedByUser.tr(),
      ContactSupportMode.initiatedByCrash =>
        LocaleKeys.contactSupportBottomSheetButtonInitiatedByCrash.tr(),
    };

    return BlocBuilder<ContactSupportBloc, ContactSupportState>(
      builder: (context, state) {
        return ShapedContainerColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const CommonDivider(),
          margin: EdgeInsets.zero,
          children: [
            CommonButton.primary(
              fillWidth: true,
              text: buttonText,
              isLoading: state.when(initial: () => false, busy: () => true),
              onPressed: () => {
                context.read<ContactSupportBloc>().add(
                      ContactSupportEvent.sendEmail(
                        mode,
                      ),
                    ),
              },
            ),
          ],
        );
      },
    );
  }
}
