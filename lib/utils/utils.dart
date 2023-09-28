import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

extension DateX on DateTime {
  bool isSameDay(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }
}

const timestampFromStringJsonConverter = _TimestampFromStringJsonConverter();

class _TimestampFromStringJsonConverter
    extends JsonConverter<DateTime, String> {
  const _TimestampFromStringJsonConverter();

  @override
  DateTime fromJson(String json) =>
      dateSecondsSinceEpochJsonConverter.fromJson(int.parse(json));

  @override
  String toJson(DateTime object) =>
      dateSecondsSinceEpochJsonConverter.toJson(object).toString();
}

class NtpTime {
  NtpTime._();

  /// Returns current time of the system clock with offset from the NTP server
  /// Use this method instead of [DateTime.now] to get the correct time
  static DateTime now() => inject<NtpService>().now();

  static DateTime clockNow() =>
      // ignore: avoid_datetime_now
      Platform.environment.containsKey('FLUTTER_TEST') ? clock.now() : now();

  /// Updates offset from the NTP server
  /// Use this method to update the offset if you need to get the correct time
  /// before sensitive operations
  static void update() => inject<NtpService>().update();
}
