import 'package:flutter/material.dart';
import 'package:ui_components_lib/ui_components_lib.dart';

class CurrencyInputsStory extends StatefulWidget {
  const CurrencyInputsStory({super.key});

  @override
  State<CurrencyInputsStory> createState() => _CurrencyInputsStoryState();
}

class _CurrencyInputsStoryState extends State<CurrencyInputsStory> {
  final _formKey = GlobalKey<FormState>();

  late final CurrencyTextInputValidator _usdValidator;
  late final CurrencyTextInputFormatter _usdFormatter;

  late final CurrencyTextInputValidator _scale6Validator;
  late final CurrencyTextInputFormatter _scale6Formatter;

  late final CurrencyTextInputValidator _scale0Validator;
  late final CurrencyTextInputFormatter _scale0Formatter;

  late final CurrencyTextInputValidator _usdTickerValidator;
  late final CurrencyTextInputFormatter _usdTickerFormatter;

  late final CurrencyTextInputValidator _scale6TickerValidator;
  late final CurrencyTextInputFormatter _scale6TickerFormatter;

  late final CurrencyTextInputValidator _scale0TickerValidator;
  late final CurrencyTextInputFormatter _scale0TickerFormatter;

  late final CurrencyTextInputValidator _usdNegativeValidator;
  late final CurrencyTextInputFormatter _usdNegativeFormatter;

  late final CurrencyTextInputValidator _scale6NegativeValidator;
  late final CurrencyTextInputFormatter _scale6NegativeFormatter;

  late final CurrencyTextInputValidator _scale0NegativeValidator;
  late final CurrencyTextInputFormatter _scale0NegativeFormatter;

  late final CurrencyTextInputValidator _usdNegativeTickerValidator;
  late final CurrencyTextInputFormatter _usdNegativeTickerFormatter;

  late final CurrencyTextInputValidator _scale6NegativeTickerValidator;
  late final CurrencyTextInputFormatter _scale6NegativeTickerFormatter;

  late final CurrencyTextInputValidator _scale0NegativeTickerValidator;
  late final CurrencyTextInputFormatter _scale0NegativeTickerFormatter;

  @override
  void initState() {
    super.initState();

    final usd = Currencies().find('USD')!;
    final scale6 = Currency.create('SIX', 6);
    final scale0 = Currency.create('ZERO', 0);

    _usdValidator = CurrencyTextInputValidator(usd);
    _usdFormatter = CurrencyTextInputFormatter.fromValidator(_usdValidator);

    _scale6Validator = CurrencyTextInputValidator(scale6);
    _scale6Formatter =
        CurrencyTextInputFormatter.fromValidator(_scale6Validator);

    _scale0Validator = CurrencyTextInputValidator(scale0);
    _scale0Formatter =
        CurrencyTextInputFormatter.fromValidator(_scale0Validator);

    _usdTickerValidator = CurrencyTextInputValidator(usd, includeTicker: true);
    _usdTickerFormatter =
        CurrencyTextInputFormatter.fromValidator(_usdTickerValidator);

    _scale6TickerValidator =
        CurrencyTextInputValidator(scale6, includeTicker: true);
    _scale6TickerFormatter =
        CurrencyTextInputFormatter.fromValidator(_scale6TickerValidator);

    _scale0TickerValidator =
        CurrencyTextInputValidator(scale0, includeTicker: true);
    _scale0TickerFormatter =
        CurrencyTextInputFormatter.fromValidator(_scale0TickerValidator);

    _usdNegativeValidator =
        CurrencyTextInputValidator(usd, allowNegative: true);
    _usdNegativeFormatter =
        CurrencyTextInputFormatter.fromValidator(_usdNegativeValidator);

    _scale6NegativeValidator =
        CurrencyTextInputValidator(scale6, allowNegative: true);
    _scale6NegativeFormatter =
        CurrencyTextInputFormatter.fromValidator(_scale6NegativeValidator);

    _scale0NegativeValidator =
        CurrencyTextInputValidator(scale0, allowNegative: true);
    _scale0NegativeFormatter =
        CurrencyTextInputFormatter.fromValidator(_scale0NegativeValidator);

    _usdNegativeTickerValidator = CurrencyTextInputValidator(
      usd,
      allowNegative: true,
      includeTicker: true,
    );
    _usdNegativeTickerFormatter =
        CurrencyTextInputFormatter.fromValidator(_usdNegativeTickerValidator);

    _scale6NegativeTickerValidator = CurrencyTextInputValidator(
      scale6,
      allowNegative: true,
      includeTicker: true,
    );
    _scale6NegativeTickerFormatter = CurrencyTextInputFormatter.fromValidator(
      _scale6NegativeTickerValidator,
    );

    _scale0NegativeTickerValidator = CurrencyTextInputValidator(
      scale0,
      allowNegative: true,
      includeTicker: true,
    );
    _scale0NegativeTickerFormatter = CurrencyTextInputFormatter.fromValidator(
      _scale0NegativeTickerValidator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(titleText: 'Currency Inputs'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(DimensSize.d16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'USD',
                ),
                CommonInput(
                  inputFormatters: [_usdFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _usdValidator.validate,
                ),
                const Text(
                  'Coin with scale 6',
                ),
                CommonInput(
                  inputFormatters: [_scale6Formatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale6Validator.validate,
                ),
                const Text(
                  'Coin with scale 0',
                ),
                CommonInput(
                  inputFormatters: [_scale0Formatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale0Validator.validate,
                ),
                const Text(
                  'USD with ticker',
                ),
                CommonInput(
                  inputFormatters: [
                    _usdTickerFormatter,
                  ],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _usdTickerValidator.validate,
                ),
                const Text(
                  'Coin with scale 6 with ticker',
                ),
                CommonInput(
                  inputFormatters: [
                    _scale6TickerFormatter,
                  ],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale6TickerValidator.validate,
                ),
                const Text(
                  'Coin with scale 0 with ticker',
                ),
                CommonInput(
                  inputFormatters: [
                    _scale0TickerFormatter,
                  ],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale0TickerValidator.validate,
                ),
                const Text(
                  'USD, allow negative',
                ),
                CommonInput(
                  inputFormatters: [_usdNegativeFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _usdNegativeValidator.validate,
                ),
                const Text(
                  'Coin with scale 6, allow negative',
                ),
                CommonInput(
                  inputFormatters: [_scale6NegativeFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale6NegativeValidator.validate,
                ),
                const Text(
                  'Coin with scale 0, allow negative',
                ),
                CommonInput(
                  inputFormatters: [_scale0NegativeFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale0NegativeValidator.validate,
                ),
                const Text(
                  'USD, allow negative with ticker',
                ),
                CommonInput(
                  inputFormatters: [_usdNegativeTickerFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _usdNegativeTickerValidator.validate,
                ),
                const Text(
                  'Coin with scale 6, allow negative with ticker',
                ),
                CommonInput(
                  inputFormatters: [_scale6NegativeTickerFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale6NegativeTickerValidator.validate,
                ),
                const Text(
                  'Coin with scale 0, allow negative with ticker',
                ),
                CommonInput(
                  inputFormatters: [_scale0NegativeTickerFormatter],
                  validateMode: AutovalidateMode.onUserInteraction,
                  validator: _scale0NegativeTickerValidator.validate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
