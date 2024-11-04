// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i24;
import 'package:encrypted_storage/encrypted_storage.dart' as _i26;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i4;
import 'package:fancy_logger/fancy_logger.module.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nekoton_repository/nekoton_repository.dart' as _i36;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i5;

import '../app/service/app_lifecycle_service.dart' as _i15;
import '../app/service/app_links/app_links_service.dart' as _i11;
import '../app/service/app_permissions_service.dart' as _i16;
import '../app/service/app_version_service.dart' as _i8;
import '../app/service/approvals_service.dart' as _i22;
import '../app/service/assets_service.dart' as _i37;
import '../app/service/balance_service.dart' as _i54;
import '../app/service/biometry_service.dart' as _i47;
import '../app/service/bootstrap_service.dart' as _i9;
import '../app/service/currencies_service.dart' as _i53;
import '../app/service/currency_convert_service.dart' as _i19;
import '../app/service/current_accounts_service.dart' as _i52;
import '../app/service/current_seed_service.dart' as _i48;
import '../app/service/identify/i_identify_icons_service.dart' as _i41;
import '../app/service/identify/identify_icons_service.dart' as _i42;
import '../app/service/js_servcie.dart' as _i10;
import '../app/service/localization/service/localization_service.dart' as _i17;
import '../app/service/messenger/service/messenger_service.dart' as _i13;
import '../app/service/navigation/service/navigation_service.dart' as _i12;
import '../app/service/nekoton_related/connection_service/connection_service.dart'
    as _i34;
import '../app/service/nekoton_related/current_key_service.dart' as _i45;
import '../app/service/network_connection/network_connection_service.dart'
    as _i18;
import '../app/service/ntp_service.dart' as _i43;
import '../app/service/permissions_service.dart' as _i38;
import '../app/service/remote/dns_resolve_service.dart' as _i21;
import '../app/service/remote/http_service.dart' as _i20;
import '../app/service/service.dart' as _i35;
import '../app/service/staking_service.dart' as _i39;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i46;
import '../app/service/storage_service/balance_storage_service.dart' as _i27;
import '../app/service/storage_service/browser_bookmarks_storage_service.dart'
    as _i32;
import '../app/service/storage_service/browser_favicon_url_storage_service.dart'
    as _i28;
import '../app/service/storage_service/browser_history_storage_service.dart'
    as _i31;
import '../app/service/storage_service/browser_permissions_storage_service.dart'
    as _i25;
import '../app/service/storage_service/browser_tabs_storage_service.dart'
    as _i29;
import '../app/service/storage_service/connections_storage_service.dart'
    as _i30;
import '../app/service/storage_service/general_storage_service.dart' as _i33;
import '../app/service/storage_service/nekoton_repository_service.dart' as _i44;
import '../app/service/storage_service/secure_storage_service.dart' as _i23;
import '../app/service/storage_service/storage_manager_service.dart' as _i51;
import '../app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart'
    as _i6;
import '../app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart'
    as _i7;
import '../app/service/token_wallets_service.dart' as _i49;
import '../app/service/ton/ton_service.dart' as _i14;
import '../http/dio_module.dart' as _i55;
import '../http/http.dart' as _i50;
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
    gh.singleton<_i11.AppLinksService>(
      () => _i11.AppLinksService(),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i12.NavigationService>(() => _i12.NavigationService());
    gh.singleton<_i13.MessengerService>(() => _i13.MessengerService());
    gh.singleton<_i14.TonService>(() => _i14.TonService());
    gh.singleton<_i15.AppLifecycleService>(() => _i15.AppLifecycleService());
    gh.singleton<_i16.AppPermissionsService>(
        () => _i16.AppPermissionsService());
    gh.singleton<_i17.LocalizationService>(() => _i17.LocalizationService());
    gh.singleton<_i18.NetworkConnectionService>(
        () => _i18.NetworkConnectionService());
    gh.singleton<_i19.CurrencyConvertService>(
        () => _i19.CurrencyConvertService());
    gh.singleton<_i20.HttpService>(() => _i20.HttpService());
    gh.singleton<_i21.DnsResolveService>(() => _i21.DnsResolveService());
    gh.singleton<_i22.BrowserApprovalsService>(
        () => _i22.BrowserApprovalsService());
    gh.lazySingleton<_i23.SecureStorageService>(
        () => _i23.SecureStorageService());
    gh.lazySingleton<_i24.Dio>(() => dioModule.getDio());
    gh.singleton<_i25.BrowserPermissionsStorageService>(() =>
        _i25.BrowserPermissionsStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i27.BalanceStorageService>(
        () => _i27.BalanceStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i28.BrowserFaviconURLStorageService>(() =>
        _i28.BrowserFaviconURLStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i29.BrowserTabsStorageService>(
        () => _i29.BrowserTabsStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i30.ConnectionsStorageService>(
        () => _i30.ConnectionsStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i31.BrowserHistoryStorageService>(
        () => _i31.BrowserHistoryStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i32.BrowserBookmarksStorageService>(
        () => _i32.BrowserBookmarksStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i33.GeneralStorageService>(
        () => _i33.GeneralStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i34.ConnectionService>(() => _i34.ConnectionService(
          gh<_i35.ConnectionsStorageService>(),
          gh<_i36.NekotonRepository>(),
          gh<_i35.HttpService>(),
        ));
    gh.singleton<_i37.AssetsService>(() => _i37.AssetsService(
          gh<_i36.NekotonRepository>(),
          gh<_i35.HttpService>(),
          gh<_i35.GeneralStorageService>(),
        ));
    gh.singleton<_i38.PermissionsService>(() => _i38.PermissionsService(
          gh<_i35.BrowserPermissionsStorageService>(),
          gh<_i36.NekotonRepository>(),
        ));
    gh.singleton<_i39.StakingService>(() => _i39.StakingService(
          gh<_i36.NekotonRepository>(),
          gh<_i35.HttpService>(),
        ));
    gh.singleton<_i40.TokenRepository>(() => _i40.TokenRepository(
          gh<_i36.NekotonRepository>(),
          gh<_i24.Dio>(),
        ));
    gh.lazySingleton<_i41.IIdentifyIconsService>(
        () => _i42.IdentifyIconsService(gh<_i35.SecureStorageService>()));
    gh.singleton<_i43.NtpService>(
      () => _i43.NtpService(gh<_i35.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i44.NekotonRepositoryStorageService>(() =>
        _i44.NekotonRepositoryStorageService(gh<_i36.NekotonRepository>()));
    gh.singleton<_i45.CurrentKeyService>(() => _i45.CurrentKeyService(
          gh<_i35.GeneralStorageService>(),
          gh<_i36.NekotonRepository>(),
        ));
    gh.singleton<_i46.NekotonStorageService>(
        () => _i46.NekotonStorageService(gh<_i26.EncryptedStorage>()));
    gh.singleton<_i47.BiometryService>(() => _i47.BiometryService(
          gh<_i35.GeneralStorageService>(),
          gh<_i35.AppLifecycleService>(),
        ));
    gh.singleton<_i48.CurrentSeedService>(() => _i48.CurrentSeedService(
          gh<_i36.NekotonRepository>(),
          gh<_i35.CurrentKeyService>(),
        ));
    gh.singleton<_i49.TokenWalletsService>(() => _i49.TokenWalletsService(
          gh<_i36.NekotonRepository>(),
          gh<_i35.HttpService>(),
          gh<_i35.AssetsService>(),
          gh<_i50.TokenRepository>(),
        ));
    gh.singleton<_i51.StorageManagerService>(() => _i51.StorageManagerService(
          gh<_i35.GeneralStorageService>(),
          gh<_i35.BrowserTabsStorageService>(),
          gh<_i35.BrowserHistoryStorageService>(),
          gh<_i35.BrowserBookmarksStorageService>(),
          gh<_i35.BrowserPermissionsStorageService>(),
          gh<_i35.BrowserFaviconURLStorageService>(),
          gh<_i35.NekotonStorageService>(),
          gh<_i35.NekotonRepositoryStorageService>(),
          gh<_i35.TonWalletStorageService>(),
          gh<_i35.TokenWalletStorageService>(),
          gh<_i35.ConnectionsStorageService>(),
          gh<_i35.BalanceStorageService>(),
          gh<_i35.SecureStorageService>(),
        ));
    gh.singleton<_i52.CurrentAccountsService>(() => _i52.CurrentAccountsService(
          gh<_i36.NekotonRepository>(),
          gh<_i35.CurrentKeyService>(),
          gh<_i26.EncryptedStorage>(),
        ));
    gh.singleton<_i53.CurrenciesService>(() => _i53.CurrenciesService(
          httpService: gh<_i35.HttpService>(),
          nekotonRepository: gh<_i36.NekotonRepository>(),
          currentAccounts: gh<_i35.CurrentAccountsService>(),
          storageService: gh<_i35.GeneralStorageService>(),
          appLifecycle: gh<_i35.AppLifecycleService>(),
        ));
    gh.singleton<_i54.BalanceService>(() => _i54.BalanceService(
          gh<_i36.NekotonRepository>(),
          gh<_i35.CurrenciesService>(),
        ));
    return this;
  }
}

class _$DioModule extends _i55.DioModule {}
