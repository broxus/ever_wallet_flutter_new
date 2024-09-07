import 'package:app/data/models/seed/seed_phrase_model.dart';

class ImportWalletData {
  ImportWalletData({
    this.isPasted,
    this.allowedData,
    this.selectedValue,
    this.seed,
    this.firstColumnWords,
    this.secondColumnWords,
  });

  final bool? isPasted;
  final List<int>? allowedData;
  final int? selectedValue;
  final SeedPhraseModel? seed;
  final List<String>? firstColumnWords;
  final List<String>? secondColumnWords;

  ImportWalletData copyWith({
    bool? isPasted,
    List<int>? allowedData,
    int? selectedValue,
    SeedPhraseModel? seed,
    List<String>? firstColumnWords,
    List<String>? secondColumnWords,
  }) {
    return ImportWalletData(
      isPasted: isPasted ?? this.isPasted,
      allowedData: allowedData ?? this.allowedData,
      selectedValue: selectedValue ?? this.selectedValue,
      seed: seed,
      firstColumnWords: firstColumnWords,
      secondColumnWords: secondColumnWords,
    );
  }
}
