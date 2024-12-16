// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:encrypted_storage/encrypted_storage.dart' as _i426;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i171;
import 'package:fancy_logger/fancy_logger.module.dart' as _i1060;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nekoton_repository/nekoton_repository.dart' as _i771;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i1067;

import '../app/service/app_links/app_links_service.dart' as _i746;
import '../app/service/bootstrap/bootstrap_service.dart' as _i468;
import '../app/service/connection/connection_service.dart' as _i754;
import '../app/service/connection/presets_connection_service.dart' as _i710;
import '../app/service/identify/i_identify_icons_service.dart' as _i958;
import '../app/service/identify/identify_icons_service.dart' as _i316;
import '../app/service/localization/service/localization_service.dart' as _i5;
import '../app/service/messenger/service/messenger_service.dart' as _i980;
import '../app/service/navigation/service/navigation_service.dart' as _i451;
import '../app/service/nekoton_related/current_key_service.dart' as _i272;
import '../app/service/network_connection/network_connection_service.dart'
    as _i33;
import '../app/service/remote/dns_resolve_service.dart' as _i391;
import '../app/service/remote/http_service.dart' as _i126;
import '../app/service/service.dart' as _i128;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i747;
import '../app/service/storage_service/app_storage_service.dart' as _i184;
import '../app/service/storage_service/balance_storage_service.dart' as _i1020;
import '../app/service/storage_service/browser_bookmarks_storage_service.dart'
    as _i122;
import '../app/service/storage_service/browser_favicon_url_storage_service.dart'
    as _i721;
import '../app/service/storage_service/browser_history_storage_service.dart'
    as _i756;
import '../app/service/storage_service/browser_permissions_storage_service.dart'
    as _i29;
import '../app/service/storage_service/browser_tabs_storage_service.dart'
    as _i933;
import '../app/service/storage_service/connections_storage_service.dart'
    as _i65;
import '../app/service/storage_service/general_storage_service.dart' as _i747;
import '../app/service/storage_service/nekoton_repository_service.dart'
    as _i386;
import '../app/service/storage_service/secure_storage_service.dart' as _i679;
import '../app/service/storage_service/storage_manager_service.dart' as _i725;
import '../app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart'
    as _i738;
import '../app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart'
    as _i139;
import '../http/api/token/token_api.dart' as _i639;
import '../http/api/ton/ton_api.dart' as _i162;
import '../http/repository/token_repository.dart' as _i700;
import '../http/repository/ton_repository.dart' as _i495;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    await _i1060.FancyLoggerPackageModule().init(gh);
    await _i171.EncryptedStoragePackageModule().init(gh);
    await _i1067.NekotonRepositoryPackageModule().init(gh);
    gh.singleton<_i738.TokenWalletStorageService>(
        () => _i738.TokenWalletStorageService());
    gh.singleton<_i139.TonWalletStorageService>(
        () => _i139.TonWalletStorageService());
    gh.singleton<_i710.PresetsConnectionService>(
        () => _i710.PresetsConnectionService());
    gh.singleton<_i746.AppLinksService>(
      () => _i746.AppLinksService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i451.NavigationService>(() => _i451.NavigationService());
    gh.singleton<_i980.MessengerService>(() => _i980.MessengerService());
    gh.singleton<_i5.LocalizationService>(() => _i5.LocalizationService());
    gh.singleton<_i33.NetworkConnectionService>(
        () => _i33.NetworkConnectionService());
    gh.singleton<_i126.HttpService>(() => _i126.HttpService());
    gh.singleton<_i391.DnsResolveService>(() => _i391.DnsResolveService());
    gh.singleton<_i29.BrowserPermissionsStorageService>(() =>
        _i29.BrowserPermissionsStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_permissions')));
    gh.singleton<_i468.BootstrapService>(
        () => _i468.BootstrapService(gh<_i710.PresetsConnectionService>()));
    gh.singleton<_i679.SecureStorageService>(
        () => _i679.SecureStorageService(gh<_i426.EncryptedStorage>()));
    gh.singleton<_i747.GeneralStorageService>(() => _i747.GeneralStorageService(
          gh<_i792.GetStorage>(instanceName: 'preferences_key'),
          gh<_i792.GetStorage>(instanceName: 'currencies_key'),
          gh<_i792.GetStorage>(instanceName: 'system_contract_assets_key'),
          gh<_i792.GetStorage>(instanceName: 'custom_contract_assets_key'),
        ));
    gh.singleton<_i65.ConnectionsStorageService>(
        () => _i65.ConnectionsStorageService(
              gh<_i792.GetStorage>(instanceName: 'connections'),
              gh<_i710.PresetsConnectionService>(),
            ));
    gh.lazySingleton<_i184.AppStorageService>(() => _i184.AppStorageService(
        gh<_i792.GetStorage>(instanceName: 'app_storage_service')));
    gh.lazySingleton<_i958.IIdentifyIconsService>(
        () => _i316.IdentifyIconsService(gh<_i128.AppStorageService>()));
    gh.singleton<_i1020.BalanceStorageService>(
        () => _i1020.BalanceStorageService(
              gh<_i792.GetStorage>(instanceName: 'overallBalancesDomain'),
              gh<_i792.GetStorage>(instanceName: 'balancesDomain'),
            ));
    gh.singleton<_i933.BrowserTabsStorageService>(() =>
        _i933.BrowserTabsStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_tabs')));
    gh.singleton<_i756.BrowserHistoryStorageService>(() =>
        _i756.BrowserHistoryStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_history')));
    gh.singleton<_i700.TokenRepository>(() => _i700.TokenRepository(
          gh<_i771.NekotonRepository>(),
          gh<_i361.Dio>(),
        ));
    gh.factory<_i639.TokenApi>(() => _i639.TokenApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.factory<_i162.TonApi>(() => _i162.TonApi(
          gh<_i361.Dio>(),
          baseUrl: gh<String>(),
        ));
    gh.singleton<_i122.BrowserBookmarksStorageService>(() =>
        _i122.BrowserBookmarksStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_bookmarks')));
    gh.singleton<_i495.TonRepository>(
        () => _i495.TonRepository(gh<_i162.TonApi>()));
    gh.singleton<_i386.NekotonRepositoryStorageService>(() =>
        _i386.NekotonRepositoryStorageService(gh<_i771.NekotonRepository>()));
    gh.singleton<_i272.CurrentKeyService>(() => _i272.CurrentKeyService(
          gh<_i128.GeneralStorageService>(),
          gh<_i771.NekotonRepository>(),
        ));
    gh.singleton<_i754.ConnectionService>(() => _i754.ConnectionService(
          gh<_i128.ConnectionsStorageService>(),
          gh<_i771.NekotonRepository>(),
          gh<_i710.PresetsConnectionService>(),
        ));
    gh.singleton<_i747.NekotonStorageService>(
        () => _i747.NekotonStorageService(gh<_i426.EncryptedStorage>()));
    gh.singleton<_i721.BrowserFaviconURLStorageService>(() =>
        _i721.BrowserFaviconURLStorageService(
            gh<_i792.GetStorage>(instanceName: 'browser_favicon_urls')));
    gh.singleton<_i725.StorageManagerService>(() => _i725.StorageManagerService(
          gh<_i128.SecureStorageService>(),
          gh<_i128.GeneralStorageService>(),
          gh<_i128.BrowserTabsStorageService>(),
          gh<_i128.BrowserHistoryStorageService>(),
          gh<_i128.BrowserBookmarksStorageService>(),
          gh<_i128.BrowserPermissionsStorageService>(),
          gh<_i128.BrowserFaviconURLStorageService>(),
          gh<_i128.NekotonStorageService>(),
          gh<_i128.NekotonRepositoryStorageService>(),
          gh<_i128.TonWalletStorageService>(),
          gh<_i128.TokenWalletStorageService>(),
          gh<_i128.ConnectionsStorageService>(),
          gh<_i128.BalanceStorageService>(),
          gh<_i128.AppStorageService>(),
        ));
    return this;
  }
}
