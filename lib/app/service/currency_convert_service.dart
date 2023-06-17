import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _usdScale = 2;

/// This is a service that helps converting some real-world currency to another.
///
/// !!! We do not know now how it will look like, but this is an attempt to
/// predict some common behavior.
@singleton
class CurrencyConvertService {
  CurrencyConvertService() {
    Currencies().register(
      Currency.create(
        'USD',
        _usdScale,
        name: 'USD',
      ),
    );
  }

  /// Convert [amount] in USD currency to [currency] (aka USD, euro, won etc).
  ///
  /// !!! Now this is just a direct returning of amount with USD currency.
  // ignore: avoid-unused-parameters
  Future<Money> convert(Fixed amount, {Currency? currency}) async {
    return Money.fromFixed(amount, code: 'USD');
  }
}
