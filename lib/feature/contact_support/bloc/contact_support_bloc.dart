// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/messenger/messenger.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

part 'contact_support_bloc.freezed.dart';

part 'contact_support_event.dart';

part 'contact_support_state.dart';

class ContactSupportBloc extends Bloc<ContactSupportEvent, ContactSupportState>
    with BlocBaseMixin {
  ContactSupportBloc(this.context)
      : super(const ContactSupportState.initial()) {
    on<ContactSupportEvent>((event, emit) async {
      await event.map(
        sendEmail: (event) async {
          emitSafe(const ContactSupportState.busy());
          String? logFilePath;
          try {
            logFilePath = await contactSupportCreateLogfile();
          } catch (e, s) {
            _log.severe(e, null, s);
            emitSafe(const ContactSupportState.initial());
            inject<MessengerService>().show(
              Message.error(
                context: context,
                message: LocaleKeys.contactSupportCantCreateFile.tr(),
              ),
            );
          }

          if (logFilePath != null) {
            try {
              await contactSupportEmailSend(event.mode, logFilePath);
            } catch (e, s) {
              _log.severe(e, null, s);
              emitSafe(const ContactSupportState.initial());
              inject<MessengerService>().show(
                Message.error(
                  context: context,
                  message: LocaleKeys.contactSupportCantFindEmailClient.tr(),
                  actionText:
                      LocaleKeys.contactSupportCantFindEmailClientShare.tr(),
                  onAction: () => contactSupportShareFile(logFilePath!),
                ),
              );
            }
          }

          emitSafe(const ContactSupportState.initial());
        },
      );
    });
  }

  final BuildContext context;
  final _log = Logger('ContactSupportBloc');
}
