// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i22;
import 'package:encrypted_storage/encrypted_storage.dart' as _i24;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i4;
import 'package:fancy_logger/fancy_logger.module.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nekoton_repository/nekoton_repository.dart' as _i34;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i5;

import '../app/service/app_lifecycle_service.dart' as _i13;
import '../app/service/app_links/app_links_service.dart' as _i47;
import '../app/service/app_permissions_service.dart' as _i14;
import '../app/service/app_version_service.dart' as _i8;
import '../app/service/approvals_service.dart' as _i20;
import '../app/service/assets_service.dart' as _i36;
import '../app/service/balance_service.dart' as _i55;
import '../app/service/biometry_service.dart' as _i48;
import '../app/service/bootstrap_service.dart' as _i9;
import '../app/service/currencies_service.dart' as _i54;
import '../app/service/currency_convert_service.dart' as _i17;
import '../app/service/current_accounts_service.dart' as _i53;
import '../app/service/current_seed_service.dart' as _i49;
import '../app/service/identify/i_identify_icons_service.dart' as _i41;
import '../app/service/identify/identify_icons_service.dart' as _i42;
import '../app/service/js_servcie.dart' as _i10;
import '../app/service/localization/service/localization_service.dart' as _i15;
import '../app/service/messenger/service/messenger_service.dart' as _i12;
import '../app/service/navigation/service/navigation_service.dart' as _i11;
import '../app/service/nekoton_related/connection_service/connection_service.dart'
    as _i32;
import '../app/service/nekoton_related/current_key_service.dart' as _i45;
import '../app/service/network_connection/network_connection_service.dart'
    as _i16;
import '../app/service/ntp_service.dart' as _i43;
import '../app/service/permissions_service.dart' as _i37;
import '../app/service/remote/dns_resolve_service.dart' as _i19;
import '../app/service/remote/http_service.dart' as _i18;
import '../app/service/service.dart' as _i33;
import '../app/service/staking_service.dart' as _i39;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i46;
import '../app/service/storage_service/balance_storage_service.dart' as _i25;
import '../app/service/storage_service/browser_bookmarks_storage_service.dart'
    as _i30;
import '../app/service/storage_service/browser_favicon_url_storage_service.dart'
    as _i26;
import '../app/service/storage_service/browser_history_storage_service.dart'
    as _i29;
import '../app/service/storage_service/browser_permissions_storage_service.dart'
    as _i23;
import '../app/service/storage_service/browser_tabs_storage_service.dart'
    as _i27;
import '../app/service/storage_service/connections_storage_service.dart'
    as _i28;
import '../app/service/storage_service/general_storage_service.dart' as _i31;
import '../app/service/storage_service/nekoton_repository_service.dart' as _i44;
import '../app/service/storage_service/secure_storage_service.dart' as _i21;
import '../app/service/storage_service/storage_manager_service.dart' as _i52;
import '../app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart'
    as _i6;
import '../app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart'
    as _i7;
import '../app/service/token_wallets_service.dart' as _i50;
import '../app/service/ton/ton_service.dart' as _i38;
import '../http/api/ton/ton_api.dart' as _i35;
import '../http/dio_module.dart' as _i56;
import '../http/http.dart' as _i51;
import '../http/repository/token_repository.dart' as _i40;

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
    gh.singleton<_i11.NavigationService>(() => _i11.NavigationService());
    gh.singleton<_i12.MessengerService>(() => _i12.MessengerService());
    gh.singleton<_i13.AppLifecycleService>(() => _i13.AppLifecycleService());
    gh.singleton<_i14.AppPermissionsService>(
        () => _i14.AppPermissionsService());
    gh.singleton<_i15.LocalizationService>(() => _i15.LocalizationService());
    gh.singleton<_i16.NetworkConnectionService>(
        () => _i16.NetworkConnectionService());
    gh.singleton<_i17.CurrencyConvertService>(
        () => _i17.CurrencyConvertService());
    gh.singleton<_i18.HttpService>(() => _i18.HttpService());
    gh.singleton<_i19.DnsResolveService>(() => _i19.DnsResolveService());
    gh.singleton<_i20.BrowserApprovalsService>(
        () => _i20.BrowserApprovalsService());
    gh.lazySingleton<_i21.SecureStorageService>(
        () => _i21.SecureStorageService());
    gh.lazySingleton<_i22.Dio>(() => dioModule.getDio());
    gh.singleton<_i23.BrowserPermissionsStorageService>(() =>
        _i23.BrowserPermissionsStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i25.BalanceStorageService>(
        () => _i25.BalanceStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i26.BrowserFaviconURLStorageService>(() =>
        _i26.BrowserFaviconURLStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i27.BrowserTabsStorageService>(
        () => _i27.BrowserTabsStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i28.ConnectionsStorageService>(
        () => _i28.ConnectionsStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i29.BrowserHistoryStorageService>(
        () => _i29.BrowserHistoryStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i30.BrowserBookmarksStorageService>(
        () => _i30.BrowserBookmarksStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i31.GeneralStorageService>(
        () => _i31.GeneralStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i32.ConnectionService>(() => _i32.ConnectionService(
          gh<_i33.ConnectionsStorageService>(),
          gh<_i34.NekotonRepository>(),
          gh<_i33.HttpService>(),
        ));
    gh.factory<_i35.TonApi>(() => _i35.TonApi(gh<_i22.Dio>()));
    gh.singleton<_i36.AssetsService>(() => _i36.AssetsService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.HttpService>(),
          gh<_i33.GeneralStorageService>(),
        ));
    gh.singleton<_i37.PermissionsService>(() => _i37.PermissionsService(
          gh<_i33.BrowserPermissionsStorageService>(),
          gh<_i34.NekotonRepository>(),
        ));
    gh.lazySingleton<_i38.TonService>(
      () => _i38.TonService(gh<_i35.TonApi>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i39.StakingService>(() => _i39.StakingService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.HttpService>(),
        ));
    gh.singleton<_i40.TokenRepository>(() => _i40.TokenRepository(
          gh<_i34.NekotonRepository>(),
          gh<_i22.Dio>(),
        ));
    gh.lazySingleton<_i41.IIdentifyIconsService>(
        () => _i42.IdentifyIconsService(gh<_i33.SecureStorageService>()));
    gh.singleton<_i43.NtpService>(
      () => _i43.NtpService(gh<_i33.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i44.NekotonRepositoryStorageService>(() =>
        _i44.NekotonRepositoryStorageService(gh<_i34.NekotonRepository>()));
    gh.singleton<_i45.CurrentKeyService>(() => _i45.CurrentKeyService(
          gh<_i33.GeneralStorageService>(),
          gh<_i34.NekotonRepository>(),
        ));
    gh.singleton<_i46.NekotonStorageService>(
        () => _i46.NekotonStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i47.AppLinksService>(
      () => _i47.AppLinksService(gh<_i38.TonService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i48.BiometryService>(() => _i48.BiometryService(
          gh<_i33.GeneralStorageService>(),
          gh<_i33.AppLifecycleService>(),
        ));
    gh.singleton<_i49.CurrentSeedService>(() => _i49.CurrentSeedService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.CurrentKeyService>(),
        ));
    gh.singleton<_i50.TokenWalletsService>(() => _i50.TokenWalletsService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.HttpService>(),
          gh<_i33.AssetsService>(),
          gh<_i51.TokenRepository>(),
        ));
    gh.singleton<_i52.StorageManagerService>(() => _i52.StorageManagerService(
          gh<_i33.GeneralStorageService>(),
          gh<_i33.BrowserTabsStorageService>(),
          gh<_i33.BrowserHistoryStorageService>(),
          gh<_i33.BrowserBookmarksStorageService>(),
          gh<_i33.BrowserPermissionsStorageService>(),
          gh<_i33.BrowserFaviconURLStorageService>(),
          gh<_i33.NekotonStorageService>(),
          gh<_i33.NekotonRepositoryStorageService>(),
          gh<_i33.TonWalletStorageService>(),
          gh<_i33.TokenWalletStorageService>(),
          gh<_i33.ConnectionsStorageService>(),
          gh<_i33.BalanceStorageService>(),
          gh<_i33.SecureStorageService>(),
        ));
    gh.singleton<_i53.CurrentAccountsService>(() => _i53.CurrentAccountsService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.CurrentKeyService>(),
          gh<_i24.EncryptedStorage>(),
        ));
    gh.singleton<_i54.CurrenciesService>(() => _i54.CurrenciesService(
          httpService: gh<_i33.HttpService>(),
          nekotonRepository: gh<_i34.NekotonRepository>(),
          currentAccounts: gh<_i33.CurrentAccountsService>(),
          storageService: gh<_i33.GeneralStorageService>(),
          appLifecycle: gh<_i33.AppLifecycleService>(),
        ));
    gh.singleton<_i55.BalanceService>(() => _i55.BalanceService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.CurrenciesService>(),
        ));
    return this;
  }
}

class _$DioModule extends _i56.DioModule {}
