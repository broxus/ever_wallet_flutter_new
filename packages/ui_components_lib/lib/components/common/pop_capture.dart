import 'package:flutter/widgets.dart';

class PopCapture extends PopScope {
  PopCapture({
    required super.child,
    VoidCallback? onPop,
    super.key,
  }) : super(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop || onPop == null) {
              return;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) => onPop());
          },
        );
}
