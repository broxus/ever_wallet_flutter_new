import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

mixin ContextWmMixin<W extends ElementaryWidget, M extends ElementaryModel>
    on WidgetModel<W, M> {
  BuildContext? get contextSafe {
    try {
      if (!isMounted) {
        return null;
      }

      return context;
    } catch (_) {
      return null;
    }
  }
}

mixin ContextMixin {
  BuildContext get context;

  BuildContext? get contextSafe {
    try {
      if (!context.mounted) {
        return null;
      }

      return context;
    } catch (_) {
      return null;
    }
  }
}

mixin ContextMixin {
  BuildContext get context;

  BuildContext? get contextSafe {
    if (!context.mounted) {
      return null;
    }

    return context;
  }
}
