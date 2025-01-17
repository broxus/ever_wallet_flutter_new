import 'package:app/http/dto/token_balances/search_balances/request/search_token_balances_request_dto.dart';
import 'package:app/http/dto/token_balances/search_balances/response/search_token_balances_response_dto.dart';
import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'token_api.g.dart';

@injectable
@RestApi()
// ignore: one_member_abstracts
abstract class TokenApi {
  @factoryMethod
  factory TokenApi(Dio dio, {String? baseUrl}) = _TokenApi;

  @POST('/balances')
  Future<GetTokenBalancesResponseDto> getBalances(
    @Body() GetTokenBalancesRequestDto params,
  );

  @POST('/balances/search')
  Future<SearchTokenBalancesResponseDto> searchBalances(
    @Body() SearchTokenBalancesRequestDto params,
  );
}
