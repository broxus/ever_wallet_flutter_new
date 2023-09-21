import 'package:app/data/models/models.dart';
import 'package:flutter/material.dart';

class StakingInProgress extends StatelessWidget {
  const StakingInProgress({
    required this.requests,
    super.key,
  });

  /// Pending withdraw requests
  final List<StEverWithdrawRequest> requests;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
