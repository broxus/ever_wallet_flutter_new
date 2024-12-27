// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/core/bloc/bloc_mixin.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

/// Cubit that allows tracking loading process of rerunning bootstrap.
class BootstrapRerunCubit extends Cubit<bool> with BlocBaseMixin {
  BootstrapRerunCubit(this.bootstrapService) : super(false);

  final BootstrapService bootstrapService;

  Future<void> rerun(BuildContext context) async {
    try {
      emitSafe(true);
      await bootstrapService.rerunFailedSteps();
    } catch (e) {
      inject<MessengerService>().show(
        Message.error(
          context: context,
          message: LocaleKeys.initializationRerunFailed.tr(),
        ),
      );
    } finally {
      emitSafe(false);
    }
  }
}
