double? parseToDouble(dynamic input) {
  try {
    if (input == null) return null;
    if (input is double) return input;
    if (input is int) return input.toDouble();
    if (input is String) return double.tryParse(input);

    return null;
  } catch (e) {
    return null;
  }
}

int? parseToInt(dynamic input) {
  try {
    if (input == null) return null;
    if (input is int) return input;
    if (input is double) return input.toInt();
    if (input is String) return int.tryParse(input);

    return null;
  } catch (e) {
    return null;
  }
}
