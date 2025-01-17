import 'package:app/feature/contact_support/contact_support.dart';
import 'package:app/generated/generated.dart';
import 'package:app/utils/utils.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:share_plus/share_plus.dart';
import 'package:the_logger/the_logger.dart';

Future<String> contactSupportCreateLogfile() async {
  final now = NtpTime.now().toLocal().toString().replaceAll(RegExp(r'\s'), '_');

  return TheLogger.i().writeAllLogsToJson('sparx_logs_$now.json');
}

Future<void> contactSupportEmailSend(
  ContactSupportMode mode,
  String logFilePath,
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

  final email = Email(
    subject: subject,
    recipients: [to],
    body: body,
    attachmentPaths: [logFilePath],
  );

  await FlutterEmailSender.send(email);
}

Future<void> contactSupportShareFile(
  String logFilePath,
) async {
  await Share.shareXFiles([XFile(logFilePath)]);
}
