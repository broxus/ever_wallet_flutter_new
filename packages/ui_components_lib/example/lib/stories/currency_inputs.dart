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
                'USD without ticker',
              ),
              CommonInput(
                inputFormatters: [CurrencyTextInputFormatter(usd)],
              ),
              const Text(
                'USD with ticker',
              ),
              CommonInput(
                inputFormatters: [CurrencyTextInputFormatter(usd)],
              ),
              const Text(
                'Coin with scale 6 and without ticker',
              ),
              CommonInput(
                inputFormatters: [CurrencyTextInputFormatter(scale6)],
              ),
              const Text(
                'Coin with scale 6 and with ticker',
              ),
              CommonInput(
                inputFormatters: [CurrencyTextInputFormatter(scale6)],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
