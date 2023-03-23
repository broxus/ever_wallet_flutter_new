import 'package:logging/logging.dart';

/// Db-related extension for Level
extension WritableLevel on Level {
  /// Return Level by value
  static Level fromValue(int value) {
    return Level.LEVELS.firstWhere((element) => element.value == value);
  }
}

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

  /// Create LogRecord from db record
  static LogRecord fromMap(Map<String, dynamic> map) {
    return LogRecord(
      WritableLevel.fromValue(map['level'] as int),
      map['message'] as String,
      map['logger_name'] as String,
    );
  }
}
