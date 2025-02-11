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

  late final fistInputsRange = inputs.getRange(
    0,
    currentValue ~/ _gridColumnCount,
  );

  late final secondInputsRange = inputs.getRange(
    currentValue ~/ _gridColumnCount,
    currentValue,
  );

  static const _gridColumnCount = 2;

  EnterSeedPhraseTabData copyWith({
    int? currentValue,
    List<EnterSeedPhraseInputData>? inputs,
  }) {
    return EnterSeedPhraseTabData(
      allowedValues: allowedValues,
      currentValue: currentValue ?? this.currentValue,
      inputs: inputs ?? this.inputs,
    );
  }
}
