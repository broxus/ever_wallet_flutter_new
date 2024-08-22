import 'package:app/generated/generated.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart';
import 'package:ui_components_lib/ui_components_lib.dart';
import 'package:ui_components_lib/v2/ui_components_lib_v2.dart';

class FunctionCallBody extends StatelessWidget {
  const FunctionCallBody({
    required this.payload,
    this.contract,
    super.key,
  });

  final FunctionCall payload;
  final Address? contract;

  @override
  Widget build(BuildContext context) => SeparatedColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (contract != null)
            _Param(
              label: LocaleKeys.contract.tr().toLowerCase(),
              value: contract!.address,
            ),
          _Param(
            label: LocaleKeys.methodWord.tr().toLowerCase(),
            value: payload.method,
          ),
          for (final param in payload.params.entries)
            _Param(
              key: ValueKey(param.key),
              label: param.key,
              value: param.value.toString(),
            ),
        ],
      );
}

class _Param extends StatelessWidget {
  const _Param({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = context.themeStyleV2;

    return PrimaryCard(
      color: theme.colors.background3,
      borderRadius: BorderRadius.circular(DimensRadiusV2.radius8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textStyles.paragraphSmall.copyWith(
              color: theme.colors.content3,
            ),
          ),
          Text(value, style: theme.textStyles.paragraphSmall),
        ],
      ),
    );
  }
}
