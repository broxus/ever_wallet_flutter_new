import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

const _baseUrl = 'https://ton-tokens-api.bf.works';

@singleton
class TonRepository {
  TonRepository(
    this.dio,
  ) : api = TonApi(dio, baseUrl: _baseUrl);

  final Dio dio;
  final TonApi api;

  Future<TonTokenInfoDto> getTokenInfo({
    required Address address,
  }) =>
      api.getTokenInfo(address.address);
}
