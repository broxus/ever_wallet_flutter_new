import 'package:app/di/di.dart';
import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:fancy_logger/fancy_logger.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> contactSupportEmailSend(
  ContactSupportMode mode,
) async {
  final to = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportEmailToInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportEmailToInitiatedByUser.tr(),
  };

  final subject = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportEmailSubjectInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportEmailSubjectInitiatedByUser.tr(),
  };

  final body = switch (mode) {
    ContactSupportMode.initiatedByUser =>
      LocaleKeys.contactSupportEmailBodyInitiatedByUser.tr(),
    ContactSupportMode.initiatedByCrash =>
      LocaleKeys.contactSupportEmailBodyInitiatedByUser.tr(),
  };

  final logFilePath = await inject<FancyLogger>().writeAllLogsToJson();

  final email = Email(
    subject: subject,
    recipients: [to],
    body: body,
    attachmentPaths: [logFilePath],
  );

  await FlutterEmailSender.send(email);
}
