import 'package:app/feature/bootstrap_failed/cubit/rerun_cubit/rerun_cubit.dart';
import 'package:app/feature/connection_fail/connection_fail_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';

/// [ElementaryModel] for [ConnectionFailScreen]
class ConnectionFailModel extends ElementaryModel {
  ConnectionFailModel(
    ErrorHandler errorHandler,
    this._cubit,
  ) : super(errorHandler: errorHandler);

  final BootstrapRerunCubit _cubit;

  void tryAgain(BuildContext context) {
    _cubit.rerun(context);
  }
}
