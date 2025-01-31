// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:app/app/service/service.dart';
import 'package:app/di/di.dart';
import 'package:app/generated/generated.dart';
import 'package:clock/clock.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:money2_fixer/money2_fixer.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide MoneyFixer;
import 'package:rxdart/rxdart.dart';

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
  Map<String, dynamic> toJson(Money object) => MoneyFixer(object).toJson();
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

  if (error is FrbException) {
    return error.toString();
  }

  return LocaleKeys.creatingSubscriptionFailed.tr();
}

String toEllipseString(String value) => value.length > 6
    ? '${value.substring(0, 6)}...${value.substring(value.length - 4)}'
    : value;

extension FunctionalExt<T> on T {
  R let<R>(R Function(T value) block) => block(this);
}

extension MoneyExt on Money {
  Money exchangeToUSD(Fixed price, [int toDecimalDigits = 7]) => exchangeTo(
        ExchangeRate.fromFixed(
          price,
          fromIsoCode: currency.isoCode,
          toIsoCode: 'USD',
          toDecimalDigits: toDecimalDigits,
        ),
      );

  /// Returns a `Money` object that is guaranteed to have a non-negative amount.
  ///
  /// If the current `Money` object has a positive amount,
  /// it returns the current object.
  /// Otherwise, it returns a new `Money` object with the amount set to zero.
  Money positiveOrZero() {
    if (isPositive) return this;
    return copyWith(amount: Fixed.zero);
  }
}

extension GetStorageExt on GetStorage {
  Iterable<String> getStringKeys() => getKeys();

  Map<String, dynamic> getEntries() => Map.fromIterables(
        getStringKeys(),
        getValues<Iterable<dynamic>>(),
      );
}

extension FutureExt<T> on Future<T> {
  static Future<(T1, T2)> wait2<T1, T2>(
    Future<T1> future1,
    Future<T2> future2,
  ) async {
    late T1 result1;
    late T2 result2;

    await Future.wait([
      future1.then((value) => result1 = value),
      future2.then((value) => result2 = value),
    ]);

    return (result1, result2);
  }

  static Future<(T1, T2, T3)> wait3<T1, T2, T3>(
    Future<T1> future1,
    Future<T2> future2,
    Future<T3> future3,
  ) async {
    late T1 result1;
    late T2 result2;
    late T3 result3;

    await Future.wait([
      future1.then((value) => result1 = value),
      future2.then((value) => result2 = value),
      future3.then((value) => result3 = value),
    ]);

    return (result1, result2, result3);
  }

  static Future<(T1, T2, T3, T4)> wait4<T1, T2, T3, T4>(
    Future<T1> future1,
    Future<T2> future2,
    Future<T3> future3,
    Future<T4> future4,
  ) async {
    late T1 result1;
    late T2 result2;
    late T3 result3;
    late T4 result4;

    await Future.wait([
      future1.then((value) => result1 = value),
      future2.then((value) => result2 = value),
      future3.then((value) => result3 = value),
      future4.then((value) => result4 = value),
    ]);

    return (result1, result2, result3, result4);
  }

  static Future<(T1, T2, T3, T4, T5)> wait5<T1, T2, T3, T4, T5>(
    Future<T1> future1,
    Future<T2> future2,
    Future<T3> future3,
    Future<T4> future4,
    Future<T5> future5,
  ) async {
    late T1 result1;
    late T2 result2;
    late T3 result3;
    late T4 result4;
    late T5 result5;

    await Future.wait([
      future1.then((value) => result1 = value),
      future2.then((value) => result2 = value),
      future3.then((value) => result3 = value),
      future4.then((value) => result4 = value),
      future5.then((value) => result5 = value),
    ]);

    return (result1, result2, result3, result4, result5);
  }
}

extension MapExt<K, V> on Map<K, V> {
  void set(K key, V value) {
    this[key] = value;
  }
}

extension ValueListenableExt<T> on ValueListenable<T> {
  Stream<T> asStream() {
    final subject = BehaviorSubject<T>.seeded(value);
    void listener() => subject.add(value);

    subject.onListen = () => addListener(listener);
    subject.onCancel = () => removeListener(listener);

    return subject.stream;
  }
}

extension ListenableStateExt<T> on ListenableState<T> {
  Stream<T?> asStream() {
    final subject = BehaviorSubject<T?>.seeded(value);
    void listener() => subject.add(value);

    subject.onListen = () => addListener(listener);
    subject.onCancel = () => removeListener(listener);

    return subject.stream;
  }
}

String getNetworkGroupByNetworkType(dynamic networkType) {
  return switch (networkType) {
    'ever' => 'mainnet',
    'venom' => 'venom_mainnet',
    'tycho' => 'tycho_testnet',
    'mainnet' => 'mainnet',
    'venom_mainnet' => 'venom_mainnet',
    'tycho_testnet' => 'tycho_testnet',
    'ton' => 'ton',
    _ => 'custom',
  };
}
