class CommonTextValidator {
  /// A validator that checks if a string is empty or has a length between
  /// [minLength] and [maxLength]. It can also check if the string is empty
  /// and return [emptyError] if it is.
  CommonTextValidator({
    this.minLength,
    this.maxLength,
    this.emptyError,
    this.minLengthError,
    this.maxLengthError,
  })  : assert(
          minLength == null || minLength >= 0,
          'minLength must be greater than or equal to 0',
        ),
        assert(
          maxLength == null || maxLength >= 0,
          'maxLength must be greater than or equal to 0',
        ),
        assert(
          minLength == null || maxLength == null || minLength <= maxLength,
          'minLength must be less than or equal to maxLength',
        ),
        assert(
          minLength != null &&
                  minLength == 1 &&
                  (minLengthError != null || emptyError != null) ||
              minLength == null && minLengthError == null,
          'minError or emptyError must be provided when min is provided and '
          'min is 1',
        ),
        assert(
          minLength != null && minLength > 1 && minLengthError != null ||
              (minLength == null || minLength <= 1) && minLengthError == null,
          'minError must be provided when min is provided',
        ),
        assert(
          maxLength != null && maxLengthError != null ||
              maxLength == null && maxLengthError == null,
          'minError must be provided when min is provided',
        );

  final int? minLength;
  final int? maxLength;
  final String? emptyError;
  final String? minLengthError;
  final String? maxLengthError;

  String? validate(String? value) {
    final stripped = value?.trim() ?? '';
    final length = stripped.length;

    if (minLength != null && emptyError != null && length < 1) {
      return emptyError;
    }

    if (minLength != null && minLengthError != null && length < minLength!) {
      return minLengthError;
    }

    if (maxLength != null && maxLengthError != null && length > maxLength!) {
      return maxLengthError;
    }

    return null;
  }
}
