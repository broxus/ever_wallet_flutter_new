import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

String moneyPattern(int decimal) => '0.${'#' * decimal}';

String moneyPatternWithSymbol(int decimal) => '0.${'#' * decimal} S';

/// This is a service that helps converting some real-world currency to another.
///
/// !!! We do not know now how it will look like, but this is an attempt to
/// predict some common behavior.
@singleton
class CurrencyConvertService {
  CurrencyConvertService() {
    for (final cur in fiatSupportedMoney) {
      Currencies().register(cur);
    }
  }

  /// Currencies from real-world that we can use to convert
  static final fiatSupportedMoney = [
    Currency.create('USD', 5, symbol: 'USD', pattern: moneyPattern(5)),
  ];

  /// Returns [Currency.isoCode] of currency for real world
  String get currentFiatCode => fiatSupportedMoney.first.isoCode;

  /// Convert amount [usdAmount] in USD currency to [currency] (aka USD, euro,
  /// won etc), if [currency] is null, then [currentFiatCode] will be used.
  ///
  /// !!! Now this is just a direct returning of amount with USD currency.
  // ignore: avoid-unused-parameters
  Money convert(Fixed usdAmount, {Currency? currency}) {
    return Money.fromFixedWithCurrency(
      usdAmount,
      currency ?? Currencies()[currentFiatCode]!,
    );
  }
}
