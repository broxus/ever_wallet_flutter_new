import 'package:app/di/di.dart';
import 'package:app/utils/factories/error_handler/standard_error_handler.dart';
import 'package:flutter/cupertino.dart';

PrimaryErrorHandler createPrimaryErrorHandler(BuildContext context) {
  return PrimaryErrorHandler(
    context,
    inject(),
  );
}
