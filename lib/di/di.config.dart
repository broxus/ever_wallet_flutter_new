// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypted_storage/encrypted_storage.dart' as _i8;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i5;
import 'package:fancy_logger/fancy_logger.module.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i4;

import '../app/service/key_value_storage_service.dart' as _i7;
import '../app/service/navigation_service.dart' as _i9;
import '../feature/counter/service/counter_service.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i3.FancyLoggerPackageModule().init(gh);
    await _i4.NekotonRepositoryPackageModule().init(gh);
    await _i5.EncryptedStoragePackageModule().init(gh);
    gh.singleton<_i6.CounterService>(_i6.CounterService());
    gh.singleton<_i7.KeyValueStorageService>(
        _i7.KeyValueStorageService(gh<_i8.EncryptedStorage>()));
    gh.singleton<_i9.NavigationService>(_i9.NavigationService());
    return this;
  }
}
