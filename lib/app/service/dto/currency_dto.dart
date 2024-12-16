// ignore_for_file: no-magic-number

import 'package:app/data/models/custom_currency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'currency_dto.freezed.dart';

part 'currency_dto.g.dart';

@freezed
class CurrencyDto with _$CurrencyDto {
  @HiveType(typeId: 4)
  const factory CurrencyDto({
    @HiveField(0) required String currency,
    @HiveField(1) required String address,
    @HiveField(2) required String price,
  }) = _CurrencyDto;
}

extension CurrencyX on CustomCurrency {
  CurrencyDto toDto() => CurrencyDto(
        currency: currency,
        address: address.address,
        price: price,
      );
}

extension CurrencyDtoX on CurrencyDto {
  CustomCurrency toModel(String networkType) => CustomCurrency(
        currency: currency,
        address: Address(address: address),
        price: price,
        networkType: networkType,
      );
}
