import 'dart:async';

import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:flutter/widgets.dart';

/// LocalizationServiceWidget is a widget that allows to listen to
/// [LocalizationService] events and respond to them by sending
/// locale updates (which is only available via context)
/// And yes, we don't use cubit or bloc here, because we don't need
/// to use any state, we just need to listen to events and respond to them
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
  StreamSubscription<void>? _refreshLocaleSubscription;

  @override
  void initState() {
    super.initState();

    _refreshLocaleSubscription =
        inject<LocalizationService>().refreshLocaleStream.listen(
              (_) => _setLocaleByLanguageCode(),
            );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setLocaleByLanguageCode();
    });
  }

  void _setLocaleByLanguageCode() {
    inject<LocalizationService>()
        .setLocaleByLanguageCode(context.locale.languageCode);
  }

  @override
  void dispose() {
    _refreshLocaleSubscription?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
