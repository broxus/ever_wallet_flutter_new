import 'package:app/core/wm/notifier_subscriptions_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';

/// Custom WidgetModel with additional functionality
///
/// *Kneads mixes:*
/// [NotifierSubscriptionsMixin] for working with subscriptions to [ChangeNotifier]
///
class CustomWidgetModel<W extends ElementaryWidget, M extends ElementaryModel>
    extends WidgetModel<W, M> with NotifierSubscriptionsMixin {
  CustomWidgetModel(
    super.model,
  );
}
