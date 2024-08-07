class ImportWalletData {
  ImportWalletData({
    this.isPasted,
    this.words,
    this.firstColumnWords,
    this.secondColumnWords,
  });

  final bool? isPasted;
  final List<String>? words;
  final List<String>? firstColumnWords;
  final List<String>? secondColumnWords;

  ImportWalletData copyWith({
    bool? isPasted,
    List<String>? words,
    List<String>? firstColumnWords,
    List<String>? secondColumnWords,
  }) {
    return ImportWalletData(
      isPasted: isPasted ?? this.isPasted,
      words: words,
      firstColumnWords: firstColumnWords,
      secondColumnWords: secondColumnWords,
    );
  }
}
