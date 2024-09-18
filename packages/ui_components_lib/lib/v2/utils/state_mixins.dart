import 'package:flutter/cupertino.dart';

mixin StateMixin<T extends StatefulWidget> on State<T> {
  void setStateSafe([VoidCallback? fn]) {
    if (!mounted) {
      return;
    }
    setState(fn ?? () {});
  }

  void setStateSafeFuture([VoidCallback? fn]) => Future(() => setStateSafe(fn));

  void setStatePostFrame([VoidCallback? fn]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setStateSafe(fn);
    });
  }
}
