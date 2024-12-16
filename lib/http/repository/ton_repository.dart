import 'package:app/http/api/ton/ton_api.dart';
import 'package:app/http/dto/ton_token_info/ton_token_info_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class TonRepository {
  TonRepository(
    this._api,
  );

  final TonApi _api;

  Future<TonTokenInfoDto> getTokenInfo({
    required Address address,
  }) =>
      _api.getTokenInfo(address.address);
}
