import 'dart:async';

import 'package:app/app/router/app_route.dart';
import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/di/di.dart';
import 'package:app/feature/wallet/wallet_backup/check_phrase/check_phrase_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/good_job_back_up_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_data.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/manual_backup/manual_back_up_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

ManualBackUpWidgetModel defaultManualBackUpWidgetModelFactory(
  BuildContext context,
  List<String> words,
  String address,
  VoidCallback finishedBackupCallback,
) {
  return ManualBackUpWidgetModel(
    finishedBackupCallback,
    ManualBackUpModel(
      createPrimaryErrorHandler(context),
      inject(),
      inject(),
      words,
      address,
    ),
  );
}

class ManualBackUpWidgetModel
    extends CustomWidgetModel<ContentManualBackup, ManualBackUpModel> {
  ManualBackUpWidgetModel(
    this.finishedBackupCallback,
    super.model,
  );

  final VoidCallback finishedBackupCallback;

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  late final screenState = createEntityNotifier<ManualBackUpData>()
    ..loading(ManualBackUpData(isCopied: false));

  late List<String> words = model.phrases;

  Future<void> copySeed() async {
    screenState.content(ManualBackUpData(isCopied: true));
    await Clipboard.setData(
      ClipboardData(text: words.join(' ')),
    );
    Future.delayed(const Duration(seconds: 2), () {
      screenState.content(ManualBackUpData(isCopied: false));
    });
  }

  void clickCheckPhrase(BuildContext context) {
    showCheckPhraseDialog(
      context,
      words,
      model.address,
      finishedBackupCallback,
    );
  }

  void clickSkip(BuildContext context) {
    model.setShowingBackUpFlag();
    finishedBackupCallback();
    context.maybePop(); //close current dialog
    showGoodJobDialog(context);
  }
}
