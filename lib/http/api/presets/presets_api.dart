import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'presets_api.g.dart';

const _baseUrl =
    'https://raw.githubusercontent.com/broxus/sparx-networks/master';

@injectable
@RestApi(baseUrl: _baseUrl)
// ignore: one_member_abstracts
abstract class PresetsApi {
  @factoryMethod
  factory PresetsApi(Dio dio) = _PresetsApi;

  @GET('/{fileName}')
  Future<HttpResponse<String>> getPresetConfig(
    @Path() String fileName,
  );
}
