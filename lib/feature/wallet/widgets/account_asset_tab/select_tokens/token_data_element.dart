import 'package:app/data/models/models.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

class TokenDataElement {
  TokenDataElement({
    required this.asset,
    required this.isSelected,
    required this.value,
  });

  final TokenContractAsset asset;
  final bool isSelected;
  final Money? value;

  TokenDataElement copyWith({
    TokenContractAsset? asset,
    bool? isSelected,
    Money? value,
  }) {
    return TokenDataElement(
      asset: asset ?? this.asset,
      isSelected: isSelected ?? this.isSelected,
      value: value ?? this.value,
    );
  }
}
