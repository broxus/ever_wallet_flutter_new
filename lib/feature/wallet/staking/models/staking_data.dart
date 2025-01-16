import 'package:app/feature/wallet/staking/models/models.dart';
import 'package:app/widgets/amount_input/amount_input_asset.dart';
import 'package:money2/money2.dart';

class StakingData {
  StakingData({
    required this.tab,
    required this.attachedAmount,
    required this.exchangeRate,
    required this.receiveCurrency,
    this.asset,
  });

  final StakingTab tab;
  final Money attachedAmount;
  final double exchangeRate;
  final Currency receiveCurrency;
  final AmountInputAsset? asset;
}
