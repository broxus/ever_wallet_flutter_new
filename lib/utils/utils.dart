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
