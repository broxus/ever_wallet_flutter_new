import 'package:logging/logging.dart';

/// An abstract logger
abstract class AbstractLogger {
  /// Init logger
  Future<void> init(Map<Level, int> retainStrategy) async {}

  /// Start a new session
  Future<String?> sessionStart() async {
    return null;
  }

  /// Write record
  void write(LogRecord record);
}
