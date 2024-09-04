import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:clock/clock.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money2_fixer/money2_fixer.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide MoneyFixer;

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

const moneyFromStringJsonConverter = _MoneyFromStringJsonConverter();

class _MoneyFromStringJsonConverter
    extends JsonConverter<Money, Map<String, dynamic>> {
  const _MoneyFromStringJsonConverter();

  @override
  Money fromJson(Map<String, dynamic> json) => MoneyFixer.fromJson(json);

  @override
  Map<String, dynamic> toJson(Money object) => object.toJson();
}

class NtpTime {
  NtpTime._();

  /// Returns current time of the system clock with offset from the NTP server
  /// Use this method instead of [DateTime.now] to get the correct time
  static DateTime now() => inject<NtpService>().now();

  static DateTime clockNow() =>
      // We forced to check if the test is running because we can't mock
      // DateTime.now() in tests directly and forced to use clock package
      // ignore: avoid_datetime_now
      Platform.environment.containsKey('FLUTTER_TEST') ? clock.now() : now();

  /// Updates offset from the NTP server
  /// Use this method to update the offset if you need to get the correct time
  /// before sensitive operations
  static Future<void> update() => inject<NtpService>().update();
}

/// Helper method that can be used in ui for converting error that was sent
/// by subscribing to [TonWallet]/[TokenWallet] to text.
String convertRetrySubscribeErrorToText(Object error) {
  if (error is TonWalletRetrySubscriptionMissedAsset ||
      error is TokenWalletRetrySubscriptionMissedAsset) {
    return LocaleKeys.suchTokenCannotBeSubscribed.tr();
  }

  if (error is FfiException) {
    return error.message;
  }

  return LocaleKeys.creatingSubscriptionFailed.tr();
}

String toEllipseString(String value) => value.length > 6
    ? '${value.substring(0, 6)}...${value.substring(value.length - 4)}'
    : value;

extension FunctionalExt<T> on T {
  R let<R>(R Function(T value) block) => block(this);
}
