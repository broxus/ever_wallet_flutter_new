class ImportWalletData {
  ImportWalletData({
    this.isPasted,
    this.allowedData,
    this.selectedValue,
    this.words,
    this.firstColumnWords,
    this.secondColumnWords,
  });

  final bool? isPasted;
  final List<int>? allowedData;
  final int? selectedValue;
  final List<String>? words;
  final List<String>? firstColumnWords;
  final List<String>? secondColumnWords;

  ImportWalletData copyWith({
    bool? isPasted,
    List<int>? allowedData,
    int? selectedValue,
    List<String>? words,
    List<String>? firstColumnWords,
    List<String>? secondColumnWords,
  }) {
    return ImportWalletData(
      isPasted: isPasted ?? this.isPasted,
      allowedData: allowedData ?? this.allowedData,
      selectedValue: selectedValue ?? this.selectedValue,
      words: words,
      firstColumnWords: firstColumnWords,
      secondColumnWords: secondColumnWords,
    );
  }
}
