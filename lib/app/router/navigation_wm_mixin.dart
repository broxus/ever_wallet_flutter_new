import 'package:app/app/router/router.dart';
import 'package:flutter/cupertino.dart';

mixin NavigationMixin {
  BuildContext get context;

  void goPop({
    bool preserveQueryParams = true,
  }) =>
      context.maybePop(
        preserveQueryParams: preserveQueryParams,
      );
}
