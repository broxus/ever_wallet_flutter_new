import 'package:app/data/models/currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'currency_dto.freezed.dart';

part 'currency_dto.g.dart';

@freezed
class CurrencyDto with _$CurrencyDto {
  @HiveType(typeId: 4)
  const factory CurrencyDto({
    @HiveField(0) required String currency,
    @HiveField(1) required String address,
    @HiveField(2) required String price,
    @HiveField(3) required String priceChange,
    @HiveField(4) required String tvl,
    @HiveField(5) required String tvlChange,
    @HiveField(6) required String volume24h,
    @HiveField(7) required String volumeChange24h,
    @HiveField(8) required String volume7d,
    @HiveField(9) required String fee24h,
    @HiveField(10) required int transactionsCount24h,
  }) = _CurrencyDto;
}

extension CurrencyX on Currency {
  CurrencyDto toDto() => CurrencyDto(
        currency: currency,
        address: address,
        price: price,
        priceChange: priceChange,
        tvl: tvl,
        tvlChange: tvlChange,
        volume24h: volume24h,
        volumeChange24h: volumeChange24h,
        volume7d: volume7d,
        fee24h: fee24h,
        transactionsCount24h: transactionsCount24h,
      );
}

extension CurrencyDtoX on CurrencyDto {
  Currency toModel() => Currency(
        currency: currency,
        address: address,
        price: price,
        priceChange: priceChange,
        tvl: tvl,
        tvlChange: tvlChange,
        volume24h: volume24h,
        volumeChange24h: volumeChange24h,
        volume7d: volume7d,
        fee24h: fee24h,
        transactionsCount24h: transactionsCount24h,
      );
}
