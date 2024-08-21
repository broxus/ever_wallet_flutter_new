import 'package:app/app/router/router.dart';
import 'package:flutter/cupertino.dart';

mixin NavigationMixin {
  BuildContext get context;

  void goPop({
    bool preserveQueryParams = true,
    List<String>? removeQueries,
  }) =>
      context.maybePop(
        preserveQueryParams: preserveQueryParams,
        removeQueries: removeQueries,
      );
}
