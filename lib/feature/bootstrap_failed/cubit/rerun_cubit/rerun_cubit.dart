import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:bloc/bloc.dart';

/// Cubit that allows tracking loading process of rerunning bootstrap.
class BootstrapRerunCubit extends Cubit<bool> {
  BootstrapRerunCubit(this.bootstrapService) : super(false);

  final BootstrapService bootstrapService;

  Future<void> rerun() async {
    try {
      emit(true);
      await bootstrapService.rerunFailedSteps();
    } catch (e) {
      inject<MessengerService>().show(
        Message.error(
          message: LocaleKeys.initializationRerunFailed.tr(),
        ),
      );
    } finally {
      emit(false);
    }
  }
}
