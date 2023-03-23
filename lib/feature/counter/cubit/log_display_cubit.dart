import 'package:app/di/di.dart';
import 'package:bloc/bloc.dart';
import 'package:fancy_logger/fancy_logger.dart';
import 'package:logging/logging.dart';

class LogDisplayCubit extends Cubit<String> {
  LogDisplayCubit() : super('');
  final _log = Logger('LogDisplayCubit');

  Future<void> requestLogs() async => emit(
        await inject<FancyLogger>().getAllLogsAsString(),
      );

  Future<void> writeAllLogsToJson() async {
    final fileName = await inject<FancyLogger>().writeAllLogsToJson();
    _log.info('Logs in JSON archived to file: $fileName');
  }
}
