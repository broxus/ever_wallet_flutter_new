import 'package:app/data/models/models.dart';
import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

@singleton
class TokenRepository {
  TokenRepository(
    this.nekotonRepository,
    this.dio,
  );

  final NekotonRepository nekotonRepository;
  final Dio dio;
  TokenApi? api;

  void init() {
    nekotonRepository.currentTransportStream
        .map((transport) => transport.tokenApiBaseUrl)
        .distinct()
        .listen((baseUrl) => api = TokenApi(dio, baseUrl: baseUrl));
  }

  Future<List<TokenBalanceModel>> getBalances({
    required Address address,
    required List<Address> rootAddresses,
  }) async {
    if (api == null) throw Exception('API client was not initialized');

    final response = await api!.getBalances(
      GetTokenBalancesRequestDto(
        limit: rootAddresses.length,
        offset: 0,
        rootAddresses: rootAddresses,
        ownerAddress: address,
        balanceGt: '0',
      ),
    );

    return response.balances
        .map(
          (item) => TokenBalanceModel(
            amount: item.amount,
            ownerAddress: item.ownerAddress,
            rootAddress: item.rootAddress,
            tokenWalletAddress: item.tokenWalletAddress,
            token: item.token,
          ),
        )
        .toList();
  }
}
