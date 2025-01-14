import 'package:app/feature/add_seed/enter_seed_phrase/data/input_data.dart';

class EnterSeedPhraseTabData {
  EnterSeedPhraseTabData({
    required this.allowedValues,
    required this.currentValue,
    required this.inputs,
  });

  final List<int> allowedValues;
  final int currentValue;
  final List<EnterSeedPhraseInputData> inputs;

  EnterSeedPhraseTabData copyWith({
    List<int>? allowedValues,
    int? currentValue,
    List<EnterSeedPhraseInputData>? inputs,
  }) {
    return EnterSeedPhraseTabData(
      allowedValues: allowedValues ?? this.allowedValues,
      currentValue: currentValue ?? this.currentValue,
      inputs: inputs ?? this.inputs,
    );
  }
}
