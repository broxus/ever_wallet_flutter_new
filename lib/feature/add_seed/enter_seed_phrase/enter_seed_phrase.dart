import 'package:app/app/service/localization/service/supported_locale_codes.dart';
import 'package:app/app/view/app_wm.dart';
import 'package:app/app/view/widets/app_root.dart';
import 'package:app/app/view/widets/app_wrapper.dart';
import 'package:app/app/view/widets/screen_util_wrapper.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase_wm.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class EnterSeedPhrase extends ElementaryWidget<EnterSeedPhraseWidgetModel> {
  const EnterSeedPhrase({
    Key? key,
    WidgetModelFactory<EnterSeedPhraseWidgetModel> wmFactory =
        defaultEnterSeedPhraseWidgetModelFactory,
  }) : super(
          wmFactory,
          key: key,
        );

  @override
  Widget build(EnterSeedPhraseWidgetModel wm) {
    return SizedBox();
  }
}
