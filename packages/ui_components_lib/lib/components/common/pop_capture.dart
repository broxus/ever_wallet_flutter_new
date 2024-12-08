import 'package:flutter/widgets.dart';

class PopCapture extends PopScope {
  PopCapture({
    required super.child,
    required VoidCallback onPop,
    super.key,
  }) : super(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              return;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) => onPop());
          },
        );
}
