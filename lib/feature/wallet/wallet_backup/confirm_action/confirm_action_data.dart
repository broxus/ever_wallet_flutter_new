class ConfirmActionData {
  ConfirmActionData({this.phrase, this.error, this.isLoading = false});

  final List<String>? phrase;
  final String? error;
  final bool isLoading;
}
