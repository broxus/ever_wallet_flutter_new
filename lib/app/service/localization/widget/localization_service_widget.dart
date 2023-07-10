import 'dart:async';

import 'package:app/app/service/localization/localization.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';

/// LocalizationServiceWidget is a widget that allows to listen to
/// [LocalizationService] events and respond to them by sending
/// locale updates (which is only available via context)
/// And yes, we don't use cubit or bloc here, because we don't need
/// to use any state, we just need to listen to events and respond to them
/// immediately
class LocalizationServiceWidget extends StatefulWidget {
  const LocalizationServiceWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<LocalizationServiceWidget> createState() =>
      _LocalizationServiceWidgetState();
}

class _LocalizationServiceWidgetState extends State<LocalizationServiceWidget> {
  final _log = Logger('LocalizationServiceWidget');
  StreamSubscription<void>? _refreshLocaleSubscription;
  StreamSubscription<void>? _updateLocaleSubscription;

  @override
  void initState() {
    super.initState();

    _refreshLocaleSubscription =
        inject<LocalizationService>().refreshLocaleStream.listen(
              (_) => _setLocaleByLanguageCode(),
            );

    _updateLocaleSubscription =
        inject<LocalizationService>().updateLocaleStream.listen(
              _updateLocaleByLanguageCode,
            );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setLocaleByLanguageCode();
    });
  }

  void _setLocaleByLanguageCode() {
    final languageCode = context.locale.languageCode;

    _log.finest('set locale by language code $languageCode');

    inject<LocalizationService>()
        .updateCurrentLocaleByLanguageCodeFromServiceWidget(
      SupportedLocaleCodes.byName(languageCode),
    );
  }

  void _updateLocaleByLanguageCode(SupportedLocaleCodes code) {
    _log.finest('update locale by language code ${code.name}');

    context.setLocale(code.locale);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setLocaleByLanguageCode();
    });
  }

  @override
  void dispose() {
    _refreshLocaleSubscription?.cancel();
    _updateLocaleSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
