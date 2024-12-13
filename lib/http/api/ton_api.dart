import 'package:app/http/http.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'ton_api.g.dart';

@RestApi()
// ignore: one_member_abstracts
abstract class TonApi {
  factory TonApi(Dio dio, {String? baseUrl}) = _TonApi;

  @GET('/token/{address}')
  Future<TonTokenInfoDto> getTokenInfo(
    @Path('address') String address,
  );
}
