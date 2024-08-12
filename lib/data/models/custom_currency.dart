import 'package:app/data/models/network_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'custom_currency.freezed.dart';
part 'custom_currency.g.dart';

@freezed
class CustomCurrency with _$CustomCurrency {
  const factory CustomCurrency({
    required String currency,
    required Address address,
    // Price in USD
    // TODO(nesquikm): refactor to use Currency and Money
    required String price,
    required String priceChange,
    required String tvl,
    required String tvlChange,
    required String volume24h,
    required String volumeChange24h,
    required String volume7d,
    required String fee24h,
    required int transactionsCount24h,
    required NetworkType networkType,
  }) = _CustomCurrency;

  factory CustomCurrency.fromJson(Map<String, dynamic> json) =>
      _$CustomCurrencyFromJson(json);
}
