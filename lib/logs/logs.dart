import 'package:app/di/di.dart';
import 'package:fancy_logger/fancy_logger.dart';

Future<void> configureLogs() async {
  await inject<FancyLogger>().start();
}
