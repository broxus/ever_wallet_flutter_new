// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i22;
import 'package:encrypted_storage/encrypted_storage.dart' as _i26;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i4;
import 'package:fancy_logger/fancy_logger.module.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:get_storage/get_storage.dart' as _i24;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nekoton_repository/nekoton_repository.dart' as _i31;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i5;

import '../app/service/app_lifecycle_service.dart' as _i14;
import '../app/service/app_links/app_links_service.dart' as _i11;
import '../app/service/app_permissions_service.dart' as _i15;
import '../app/service/app_version_service.dart' as _i8;
import '../app/service/approvals_service.dart' as _i21;
import '../app/service/assets_service.dart' as _i33;
import '../app/service/balance_service.dart' as _i55;
import '../app/service/biometry_service.dart' as _i52;
import '../app/service/bootstrap_service.dart' as _i9;
import '../app/service/currencies_service.dart' as _i53;
import '../app/service/currency_convert_service.dart' as _i18;
import '../app/service/current_accounts_service.dart' as _i46;
import '../app/service/current_seed_service.dart' as _i49;
import '../app/service/identify/i_identify_icons_service.dart' as _i35;
import '../app/service/identify/identify_icons_service.dart' as _i36;
import '../app/service/js_servcie.dart' as _i10;
import '../app/service/localization/service/localization_service.dart' as _i16;
import '../app/service/messenger/service/messenger_service.dart' as _i13;
import '../app/service/navigation/service/navigation_service.dart' as _i12;
import '../app/service/nekoton_related/connection_service/connection_service.dart'
    as _i29;
import '../app/service/nekoton_related/current_key_service.dart' as _i45;
import '../app/service/network_connection/network_connection_service.dart'
    as _i17;
import '../app/service/ntp_service.dart' as _i43;
import '../app/service/permissions_service.dart' as _i34;
import '../app/service/remote/dns_resolve_service.dart' as _i20;
import '../app/service/remote/http_service.dart' as _i19;
import '../app/service/service.dart' as _i30;
import '../app/service/staking_service.dart' as _i38;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i47;
import '../app/service/storage_service/app_storage_service.dart' as _i32;
import '../app/service/storage_service/balance_storage_service.dart' as _i37;
import '../app/service/storage_service/browser_bookmarks_storage_service.dart'
    as _i42;
import '../app/service/storage_service/browser_favicon_url_storage_service.dart'
    as _i48;
import '../app/service/storage_service/browser_history_storage_service.dart'
    as _i40;
import '../app/service/storage_service/browser_permissions_storage_service.dart'
    as _i23;
import '../app/service/storage_service/browser_tabs_storage_service.dart'
    as _i39;
import '../app/service/storage_service/connections_storage_service.dart'
    as _i28;
import '../app/service/storage_service/general_storage_service.dart' as _i27;
import '../app/service/storage_service/nekoton_repository_service.dart' as _i44;
import '../app/service/storage_service/secure_storage_service.dart' as _i25;
import '../app/service/storage_service/storage_manager_service.dart' as _i54;
import '../app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart'
    as _i6;
import '../app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart'
    as _i7;
import '../app/service/token_wallets_service.dart' as _i50;
import '../http/dio_module.dart' as _i56;
import '../http/http.dart' as _i51;
import '../http/repository/token_repository.dart' as _i41;

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
    await _i4.EncryptedStoragePackageModule().init(gh);
    await _i5.NekotonRepositoryPackageModule().init(gh);
    final dioModule = _$DioModule();
    gh.singleton<_i6.TokenWalletStorageService>(
        () => _i6.TokenWalletStorageService());
    gh.singleton<_i7.TonWalletStorageService>(
        () => _i7.TonWalletStorageService());
    gh.singleton<_i8.AppVersionService>(() => _i8.AppVersionService());
    gh.singleton<_i9.BootstrapService>(() => _i9.BootstrapService());
    gh.singleton<_i10.JsService>(() => _i10.JsService());
    gh.singleton<_i11.AppLinksService>(
      () => _i11.AppLinksService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i12.NavigationService>(() => _i12.NavigationService());
    gh.singleton<_i13.MessengerService>(() => _i13.MessengerService());
    gh.singleton<_i14.AppLifecycleService>(() => _i14.AppLifecycleService());
    gh.singleton<_i15.AppPermissionsService>(
        () => _i15.AppPermissionsService());
    gh.singleton<_i16.LocalizationService>(() => _i16.LocalizationService());
    gh.singleton<_i17.NetworkConnectionService>(
        () => _i17.NetworkConnectionService());
    gh.singleton<_i18.CurrencyConvertService>(
        () => _i18.CurrencyConvertService());
    gh.singleton<_i19.HttpService>(() => _i19.HttpService());
    gh.singleton<_i20.DnsResolveService>(() => _i20.DnsResolveService());
    gh.singleton<_i21.BrowserApprovalsService>(
        () => _i21.BrowserApprovalsService());
    gh.lazySingleton<_i22.Dio>(() => dioModule.getDio());
    gh.singleton<_i23.BrowserPermissionsStorageService>(() =>
        _i23.BrowserPermissionsStorageService(
            gh<_i24.GetStorage>(instanceName: 'browser_permissions')));
    gh.singleton<_i25.SecureStorageService>(
        () => _i25.SecureStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i27.GeneralStorageService>(() => _i27.GeneralStorageService(
          gh<_i24.GetStorage>(instanceName: 'preferences_key'),
          gh<_i24.GetStorage>(instanceName: 'currencies_key'),
          gh<_i24.GetStorage>(instanceName: 'system_contract_assets_key'),
          gh<_i24.GetStorage>(instanceName: 'custom_contract_assets_key'),
        ));
    gh.singleton<_i28.ConnectionsStorageService>(() =>
        _i28.ConnectionsStorageService(
            gh<_i24.GetStorage>(instanceName: 'connections')));
    gh.singleton<_i29.ConnectionService>(() => _i29.ConnectionService(
          gh<_i30.ConnectionsStorageService>(),
          gh<_i31.NekotonRepository>(),
          gh<_i30.HttpService>(),
        ));
    gh.lazySingleton<_i32.AppStorageService>(() => _i32.AppStorageService(
        gh<_i24.GetStorage>(instanceName: 'app_storage_service')));
    gh.singleton<_i33.AssetsService>(() => _i33.AssetsService(
          gh<_i31.NekotonRepository>(),
          gh<_i30.HttpService>(),
          gh<_i30.GeneralStorageService>(),
        ));
    gh.singleton<_i34.PermissionsService>(() => _i34.PermissionsService(
          gh<_i30.BrowserPermissionsStorageService>(),
          gh<_i31.NekotonRepository>(),
        ));
    gh.lazySingleton<_i35.IIdentifyIconsService>(
        () => _i36.IdentifyIconsService(gh<_i30.AppStorageService>()));
    gh.singleton<_i37.BalanceStorageService>(() => _i37.BalanceStorageService(
          gh<_i24.GetStorage>(instanceName: 'overallBalancesDomain'),
          gh<_i24.GetStorage>(instanceName: 'balancesDomain'),
        ));
    gh.singleton<_i38.StakingService>(() => _i38.StakingService(
          gh<_i31.NekotonRepository>(),
          gh<_i30.HttpService>(),
        ));
    gh.singleton<_i39.BrowserTabsStorageService>(() =>
        _i39.BrowserTabsStorageService(
            gh<_i24.GetStorage>(instanceName: 'browser_tabs')));
    gh.singleton<_i40.BrowserHistoryStorageService>(() =>
        _i40.BrowserHistoryStorageService(
            gh<_i24.GetStorage>(instanceName: 'browser_history')));
    gh.singleton<_i41.TokenRepository>(() => _i41.TokenRepository(
          gh<_i31.NekotonRepository>(),
          gh<_i22.Dio>(),
        ));
    gh.singleton<_i42.BrowserBookmarksStorageService>(() =>
        _i42.BrowserBookmarksStorageService(
            gh<_i24.GetStorage>(instanceName: 'browser_bookmarks')));
    gh.singleton<_i43.NtpService>(
      () => _i43.NtpService(gh<_i30.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i44.NekotonRepositoryStorageService>(() =>
        _i44.NekotonRepositoryStorageService(gh<_i31.NekotonRepository>()));
    gh.singleton<_i45.CurrentKeyService>(() => _i45.CurrentKeyService(
          gh<_i30.GeneralStorageService>(),
          gh<_i31.NekotonRepository>(),
        ));
    gh.singleton<_i46.CurrentAccountsService>(() => _i46.CurrentAccountsService(
          gh<_i31.NekotonRepository>(),
          gh<_i30.CurrentKeyService>(),
          gh<_i30.GeneralStorageService>(),
        ));
    gh.singleton<_i47.NekotonStorageService>(
        () => _i47.NekotonStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i48.BrowserFaviconURLStorageService>(() =>
        _i48.BrowserFaviconURLStorageService(
            gh<_i24.GetStorage>(instanceName: 'browser_favicon_urls')));
    gh.singleton<_i49.CurrentSeedService>(() => _i49.CurrentSeedService(
          gh<_i31.NekotonRepository>(),
          gh<_i30.CurrentKeyService>(),
        ));
    gh.singleton<_i50.TokenWalletsService>(() => _i50.TokenWalletsService(
          gh<_i31.NekotonRepository>(),
          gh<_i30.HttpService>(),
          gh<_i30.AssetsService>(),
          gh<_i51.TokenRepository>(),
        ));
    gh.singleton<_i52.BiometryService>(() => _i52.BiometryService(
          gh<_i30.GeneralStorageService>(),
          gh<_i30.SecureStorageService>(),
          gh<_i30.AppLifecycleService>(),
        ));
    gh.singleton<_i53.CurrenciesService>(() => _i53.CurrenciesService(
          httpService: gh<_i30.HttpService>(),
          nekotonRepository: gh<_i31.NekotonRepository>(),
          currentAccounts: gh<_i30.CurrentAccountsService>(),
          storageService: gh<_i30.GeneralStorageService>(),
          appLifecycle: gh<_i30.AppLifecycleService>(),
        ));
    gh.singleton<_i54.StorageManagerService>(() => _i54.StorageManagerService(
          gh<_i30.SecureStorageService>(),
          gh<_i30.GeneralStorageService>(),
          gh<_i30.BrowserTabsStorageService>(),
          gh<_i30.BrowserHistoryStorageService>(),
          gh<_i30.BrowserBookmarksStorageService>(),
          gh<_i30.BrowserPermissionsStorageService>(),
          gh<_i30.BrowserFaviconURLStorageService>(),
          gh<_i30.NekotonStorageService>(),
          gh<_i30.NekotonRepositoryStorageService>(),
          gh<_i30.TonWalletStorageService>(),
          gh<_i30.TokenWalletStorageService>(),
          gh<_i30.ConnectionsStorageService>(),
          gh<_i30.BalanceStorageService>(),
          gh<_i30.AppStorageService>(),
        ));
    gh.singleton<_i55.BalanceService>(() => _i55.BalanceService(
          gh<_i31.NekotonRepository>(),
          gh<_i30.CurrenciesService>(),
        ));
    return this;
  }
}

class _$DioModule extends _i56.DioModule {}
