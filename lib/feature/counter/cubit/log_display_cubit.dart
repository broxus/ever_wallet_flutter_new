import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:fancy_logger/fancy_logger.dart';

class LogDisplayCubit extends Cubit<String> {
  LogDisplayCubit() : super('');

  Future<void> requestLogs() async => emit(
        await inject<FancyLogger>().getAllLogs(),
      );
}
