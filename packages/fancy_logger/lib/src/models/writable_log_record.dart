import 'package:logging/logging.dart';

/// Db-related extension for LogRecord
extension WritableLogRecord on LogRecord {
  /// Prepare structure for writing to db
  Map<String, dynamic> toMap({required int sessionId}) {
    var trace = error?.toString();
    trace = trace != null ? '\n$trace\n' : '';

    return {
      'session_id': sessionId,
      'level': level.value,
      'message': '$message$trace',
      'logger_name': loggerName,
      'time': time.microsecondsSinceEpoch,
    };
  }
}
