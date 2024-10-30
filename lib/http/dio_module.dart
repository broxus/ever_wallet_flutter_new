import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio getDio() {
    const timeoutMinutes = 1;

    final dio = Dio()
      ..options.connectTimeout = const Duration(minutes: timeoutMinutes)
      ..options.sendTimeout = const Duration(minutes: timeoutMinutes)
      ..options.receiveTimeout = const Duration(minutes: timeoutMinutes);

    return dio;
  }
}
