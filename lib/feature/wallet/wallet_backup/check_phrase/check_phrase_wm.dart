import 'dart:async';

import 'package:app/core/error_handler_factory.dart';
import 'package:app/core/wm/custom_wm.dart';
import 'package:app/feature/contact_support/widgets/widgets.dart';
import 'package:app/feature/wallet/wallet_backup/check_phrase/check_phrase_dialog.dart';
import 'package:app/feature/wallet/wallet_backup/check_phrase/check_phrase_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';
import 'package:url_launcher/url_launcher_string.dart';


CheckPhraseWidgetModel defaultCheckPhraseWidgetModelFactory(
  BuildContext context,
) {
  return CheckPhraseWidgetModel(
    CheckPhraseModel(
      createPrimaryErrorHandler(context),
    ),
  );
}


class CheckPhraseWidgetModel
    extends CustomWidgetModel<ContentCheckPhrase, CheckPhraseModel> {
  CheckPhraseWidgetModel(
    super.model,
  );

  final _decentralizationPolicyLink =
      'https://l1.broxus.com/everscale/wallet/terms';

  ThemeStyleV2 get themeStyle => context.themeStyleV2;

  List<String> words = [
    'Ocean',
    'Thunder',
    'Glide',
    'Orbit',
    'Breeze',
    'Shadow',
    'Horizon',
    'Echo',
    'Lunar',
    'Quartz',
    'Whisper',
    'Ember',
  ];

  Future<void> copySeed() async {
    //final st = state;
    //if (st is _$GeneratedImpl) {
      //emit(st.copyWith(isCopied: true));
      await Clipboard.setData(
        ClipboardData(text: words.join(' ')),
      );
      Future.delayed(const Duration(seconds: 2), () {
        //emit(st.copyWith(isCopied: false));
      });
    //}
  }

  void onLinkTap() => launchUrlString(_decentralizationPolicyLink);

  void onClickSupport() => showContactSupportSheet(
        context: context,
        mode: ContactSupportMode.initiatedByUser,
      );
}
