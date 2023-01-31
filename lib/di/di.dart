import 'package:app/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
  generateForDir: ['lib'],
)
Future<void> configureDi() => getIt.init();

T inject<T extends Object>({
  String? instanceName,
}) =>
    getIt.get<T>(
      instanceName: instanceName,
    );
