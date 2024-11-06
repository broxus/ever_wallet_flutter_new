import 'package:app/http/dto/ton/ton_manifest/ton_manifest_dto.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'ton_api.g.dart';

@injectable
class TonApi {
  TonApi(this._dio);

  final Dio _dio;

  Future<TokenManifestDto> fetchManifest(String manifestUrl) {
    final manifestApi = ManifestApi(_dio, baseUrl: manifestUrl);

    return manifestApi.fetchManifest();
  }
}

@RestApi()
// ignore: one_member_abstracts
abstract class ManifestApi {
  factory ManifestApi(Dio dio, {String? baseUrl}) = _ManifestApi;

  @GET('')
  Future<TokenManifestDto> fetchManifest();
}
