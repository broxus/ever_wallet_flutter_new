import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'token_api.g.dart';

@RestApi()
// ignore: one_member_abstracts
abstract class TokenApi {
  factory TokenApi(Dio dio, {String? baseUrl}) = _TokenApi;

  @POST('/balances')
  Future<GetTokenBalancesResponseDto> getBalances(
    @Body() GetTokenBalancesRequestDto params,
  );
}
