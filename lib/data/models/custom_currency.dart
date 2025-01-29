import 'package:app/app/service/connection/network_type.dart';
import 'package:app/utils/common_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

part 'custom_currency.freezed.dart';

part 'custom_currency.g.dart';

@freezed
class CustomCurrency with _$CustomCurrency {
  // TODO(nesquikm): refactor to use Currency and Money
  const factory CustomCurrency({
    required String currency,
    required Address address,

    /// Price in USD
    required String price,
    required NetworkType networkType,
    required NetworkType networkGroup,
  }) = _CustomCurrency;

  factory CustomCurrency.fromJson(Map<String, dynamic> json) =>
      _$CustomCurrencyFromJson(_update(json));
}

Map<String, dynamic> _update(Map<String, dynamic> json) {
  json['networkGroup'] ??= getNetworkGroupByNetworkType(json['networkType']);

  return json;
}
