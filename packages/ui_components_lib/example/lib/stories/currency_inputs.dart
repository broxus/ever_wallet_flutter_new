import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CurrencyInputsStory extends StatefulWidget {
  const CurrencyInputsStory({super.key});

  @override
  State<CurrencyInputsStory> createState() => _CurrencyInputsStoryState();
}

class _CurrencyInputsStoryState extends State<CurrencyInputsStory> {
  final usd = Currencies().find('USD')!;
  final scale6 = Currency.create('SIX', 6);
  final scale0 = Currency.create('ZERO', 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'Currency Inputs'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'USD',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    usd,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 6',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale6,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 0',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale0,
                  ),
                ],
              ),
              const Text(
                'USD with ticker',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    usd,
                    includeTicker: true,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 6 with ticker',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale6,
                    includeTicker: true,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 0 with ticker',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale0,
                    includeTicker: true,
                  ),
                ],
              ),
              const Text(
                'USD, allow negative',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    usd,
                    allowNegative: true,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 6, allow negative',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale6,
                    allowNegative: true,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 0, allow negative',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale0,
                    allowNegative: true,
                  ),
                ],
              ),
              const Text(
                'USD, allow negative with ticker',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    usd,
                    allowNegative: true,
                    includeTicker: true,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 6, allow negative with ticker',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale6,
                    allowNegative: true,
                    includeTicker: true,
                  ),
                ],
              ),
              const Text(
                'Coin with scale 0, allow negative with ticker',
              ),
              CommonInput(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    scale0,
                    allowNegative: true,
                    includeTicker: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
