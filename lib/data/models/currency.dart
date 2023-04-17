import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';
part 'currency.g.dart';

@freezed
class Currency with _$Currency {
  const factory Currency({
    required String currency,
    required String address,
    required String price,
    required String priceChange,
    required String tvl,
    required String tvlChange,
    required String volume24h,
    required String volumeChange24h,
    required String volume7d,
    required String fee24h,
    required int transactionsCount24h,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
}
