class ImportWalletData {
  ImportWalletData({
    this.isPasted,
    this.words,
  });

  final bool? isPasted;
  final List<String>? words;

  ImportWalletData copyWith({
    bool? isPasted,
    List<String>? words,
  }) {
    return ImportWalletData(
      isPasted: isPasted ?? this.isPasted,
      words: words,
    );
  }
}
