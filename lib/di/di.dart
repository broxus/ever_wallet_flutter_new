import 'package:app/di/di.config.dart';
import 'package:encrypted_storage/encrypted_storage.module.dart';
import 'package:fancy_logger/fancy_logger.module.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:nekoton_repository/nekoton_repository.module.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
  generateForDir: ['lib'],
  externalPackageModulesBefore: [
    ExternalModule(FancyLoggerPackageModule),
    ExternalModule(EncryptedStoragePackageModule),
    ExternalModule(NekotonRepositoryPackageModule),
  ],
)
Future<void> configureDi() => getIt.init();

T inject<T extends Object>({
  String? instanceName,
}) =>
    getIt.get<T>(
      instanceName: instanceName,
    );
