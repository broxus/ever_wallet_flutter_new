// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypted_storage/encrypted_storage.dart' as _i24;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i4;
import 'package:fancy_logger/fancy_logger.module.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nekoton_repository/nekoton_repository.dart' as _i34;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i5;

import '../app/service/app_lifecycle_service.dart' as _i14;
import '../app/service/app_links/app_links_service.dart' as _i11;
import '../app/service/app_permissions_service.dart' as _i15;
import '../app/service/app_version_service.dart' as _i8;
import '../app/service/approvals_service.dart' as _i21;
import '../app/service/assets_service.dart' as _i35;
import '../app/service/balance_service.dart' as _i49;
import '../app/service/biometry_service.dart' as _i44;
import '../app/service/bootstrap_service.dart' as _i9;
import '../app/service/currencies_service.dart' as _i48;
import '../app/service/currency_convert_service.dart' as _i18;
import '../app/service/current_accounts_service.dart' as _i47;
import '../app/service/current_seed_service.dart' as _i45;
import '../app/service/identify/i_identify_icons_service.dart' as _i38;
import '../app/service/identify/identify_icons_service.dart' as _i39;
import '../app/service/js_servcie.dart' as _i10;
import '../app/service/localization/service/localization_service.dart' as _i16;
import '../app/service/messenger/service/messenger_service.dart' as _i13;
import '../app/service/navigation/service/navigation_service.dart' as _i12;
import '../app/service/nekoton_related/connection_service/connection_service.dart'
    as _i32;
import '../app/service/nekoton_related/current_key_service.dart' as _i42;
import '../app/service/network_connection/network_connection_service.dart'
    as _i17;
import '../app/service/ntp_service.dart' as _i40;
import '../app/service/permissions_service.dart' as _i36;
import '../app/service/remote/dns_resolve_service.dart' as _i20;
import '../app/service/remote/http_service.dart' as _i19;
import '../app/service/service.dart' as _i33;
import '../app/service/staking_service.dart' as _i37;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i43;
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
import '../app/service/storage_service/nekoton_repository_service.dart' as _i41;
import '../app/service/storage_service/secure_storage_service.dart' as _i22;
import '../app/service/storage_service/storage_manager_service.dart' as _i46;
import '../app/service/storage_service/token_wallet_storage_service/token_wallet_storage_service.dart'
    as _i6;
import '../app/service/storage_service/ton_wallet_storage_service/ton_wallet_storage_service.dart'
    as _i7;

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
    gh.lazySingleton<_i22.SecureStorageService>(
        () => _i22.SecureStorageService());
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
    gh.singleton<_i35.AssetsService>(() => _i35.AssetsService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.HttpService>(),
          gh<_i33.GeneralStorageService>(),
        ));
    gh.singleton<_i36.PermissionsService>(() => _i36.PermissionsService(
          gh<_i33.BrowserPermissionsStorageService>(),
          gh<_i34.NekotonRepository>(),
        ));
    gh.singleton<_i37.StakingService>(() => _i37.StakingService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.HttpService>(),
        ));
    gh.lazySingleton<_i38.IIdentifyIconsService>(
        () => _i39.IdentifyIconsService(gh<_i33.SecureStorageService>()));
    gh.singleton<_i40.NtpService>(
      () => _i40.NtpService(gh<_i33.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i41.NekotonRepositoryStorageService>(() =>
        _i41.NekotonRepositoryStorageService(gh<_i34.NekotonRepository>()));
    gh.singleton<_i42.CurrentKeyService>(() => _i42.CurrentKeyService(
          gh<_i33.GeneralStorageService>(),
          gh<_i34.NekotonRepository>(),
        ));
    gh.singleton<_i43.NekotonStorageService>(
        () => _i43.NekotonStorageService(gh<_i24.EncryptedStorage>()));
    gh.singleton<_i44.BiometryService>(() => _i44.BiometryService(
          gh<_i33.GeneralStorageService>(),
          gh<_i33.AppLifecycleService>(),
        ));
    gh.singleton<_i45.CurrentSeedService>(() => _i45.CurrentSeedService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.CurrentKeyService>(),
        ));
    gh.singleton<_i46.StorageManagerService>(() => _i46.StorageManagerService(
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
    gh.singleton<_i47.CurrentAccountsService>(() => _i47.CurrentAccountsService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.CurrentKeyService>(),
          gh<_i24.EncryptedStorage>(),
        ));
    gh.singleton<_i48.CurrenciesService>(() => _i48.CurrenciesService(
          httpService: gh<_i33.HttpService>(),
          nekotonRepository: gh<_i34.NekotonRepository>(),
          currentAccounts: gh<_i33.CurrentAccountsService>(),
          storageService: gh<_i33.GeneralStorageService>(),
          appLifecycle: gh<_i33.AppLifecycleService>(),
        ));
    gh.singleton<_i49.BalanceService>(() => _i49.BalanceService(
          gh<_i34.NekotonRepository>(),
          gh<_i33.CurrenciesService>(),
        ));
    return this;
  }
}
