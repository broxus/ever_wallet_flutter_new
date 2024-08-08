// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:encrypted_storage/encrypted_storage.dart' as _i20;
import 'package:encrypted_storage/encrypted_storage.module.dart' as _i4;
import 'package:fancy_logger/fancy_logger.module.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:nekoton_repository/nekoton_repository.dart' as _i30;
import 'package:nekoton_repository/nekoton_repository.module.dart' as _i5;

import '../app/service/app_lifecycle_service.dart' as _i12;
import '../app/service/app_permissions_service.dart' as _i13;
import '../app/service/app_version_service.dart' as _i8;
import '../app/service/approvals_service.dart' as _i18;
import '../app/service/assets_service.dart' as _i31;
import '../app/service/balance_service.dart' as _i43;
import '../app/service/biometry_service.dart' as _i38;
import '../app/service/bootstrap_service.dart' as _i9;
import '../app/service/currencies_service.dart' as _i42;
import '../app/service/currency_convert_service.dart' as _i15;
import '../app/service/current_accounts_service.dart' as _i41;
import '../app/service/current_seed_service.dart' as _i39;
import '../app/service/localization/service/localization_service.dart' as _i14;
import '../app/service/messenger/service/messenger_service.dart' as _i11;
import '../app/service/navigation/service/navigation_service.dart' as _i10;
import '../app/service/nekoton_related/connection_service/connection_service.dart'
    as _i28;
import '../app/service/nekoton_related/current_key_service.dart' as _i36;
import '../app/service/ntp_service.dart' as _i34;
import '../app/service/permissions_service.dart' as _i32;
import '../app/service/remote/dns_resolve_service.dart' as _i17;
import '../app/service/remote/http_service.dart' as _i16;
import '../app/service/service.dart' as _i29;
import '../app/service/staking_service.dart' as _i33;
import '../app/service/storage_service/account_seed_storage_service.dart'
    as _i37;
import '../app/service/storage_service/balance_storage_service.dart' as _i21;
import '../app/service/storage_service/browser_bookmarks_storage_service.dart'
    as _i26;
import '../app/service/storage_service/browser_favicon_url_storage_service.dart'
    as _i22;
import '../app/service/storage_service/browser_history_storage_service.dart'
    as _i25;
import '../app/service/storage_service/browser_permissions_storage_service.dart'
    as _i19;
import '../app/service/storage_service/browser_tabs_storage_service.dart'
    as _i23;
import '../app/service/storage_service/connections_storage_service.dart'
    as _i24;
import '../app/service/storage_service/general_storage_service.dart' as _i27;
import '../app/service/storage_service/nekoton_repository_service.dart' as _i35;
import '../app/service/storage_service/storage_manager_service.dart' as _i40;
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
    gh.singleton<_i10.NavigationService>(() => _i10.NavigationService());
    gh.singleton<_i11.MessengerService>(() => _i11.MessengerService());
    gh.singleton<_i12.AppLifecycleService>(() => _i12.AppLifecycleService());
    gh.singleton<_i13.AppPermissionsService>(
        () => _i13.AppPermissionsService());
    gh.singleton<_i14.LocalizationService>(() => _i14.LocalizationService());
    gh.singleton<_i15.CurrencyConvertService>(
        () => _i15.CurrencyConvertService());
    gh.singleton<_i16.HttpService>(() => _i16.HttpService());
    gh.singleton<_i17.DnsResolveService>(() => _i17.DnsResolveService());
    gh.singleton<_i18.BrowserApprovalsService>(
        () => _i18.BrowserApprovalsService());
    gh.singleton<_i19.BrowserPermissionsStorageService>(() =>
        _i19.BrowserPermissionsStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i21.BalanceStorageService>(
        () => _i21.BalanceStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i22.BrowserFaviconURLStorageService>(() =>
        _i22.BrowserFaviconURLStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i23.BrowserTabsStorageService>(
        () => _i23.BrowserTabsStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i24.ConnectionsStorageService>(
        () => _i24.ConnectionsStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i25.BrowserHistoryStorageService>(
        () => _i25.BrowserHistoryStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i26.BrowserBookmarksStorageService>(
        () => _i26.BrowserBookmarksStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i27.GeneralStorageService>(
        () => _i27.GeneralStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i28.ConnectionService>(() => _i28.ConnectionService(
          gh<_i29.ConnectionsStorageService>(),
          gh<_i30.NekotonRepository>(),
          gh<_i29.HttpService>(),
        ));
    gh.singleton<_i31.AssetsService>(() => _i31.AssetsService(
          gh<_i30.NekotonRepository>(),
          gh<_i29.HttpService>(),
          gh<_i29.GeneralStorageService>(),
        ));
    gh.singleton<_i32.PermissionsService>(() => _i32.PermissionsService(
          gh<_i29.BrowserPermissionsStorageService>(),
          gh<_i30.NekotonRepository>(),
        ));
    gh.singleton<_i33.StakingService>(() => _i33.StakingService(
          gh<_i30.NekotonRepository>(),
          gh<_i29.HttpService>(),
        ));
    gh.singleton<_i34.NtpService>(
      () => _i34.NtpService(gh<_i29.AppLifecycleService>()),
      dispose: (i) => i.dispose(),
    );
    gh.singleton<_i35.NekotonRepositoryStorageService>(() =>
        _i35.NekotonRepositoryStorageService(gh<_i30.NekotonRepository>()));
    gh.singleton<_i36.CurrentKeyService>(() => _i36.CurrentKeyService(
          gh<_i29.GeneralStorageService>(),
          gh<_i30.NekotonRepository>(),
        ));
    gh.singleton<_i37.NekotonStorageService>(
        () => _i37.NekotonStorageService(gh<_i20.EncryptedStorage>()));
    gh.singleton<_i38.BiometryService>(() => _i38.BiometryService(
          gh<_i29.GeneralStorageService>(),
          gh<_i29.AppLifecycleService>(),
        ));
    gh.singleton<_i39.CurrentSeedService>(() => _i39.CurrentSeedService(
          gh<_i30.NekotonRepository>(),
          gh<_i29.CurrentKeyService>(),
        ));
    gh.singleton<_i40.StorageManagerService>(() => _i40.StorageManagerService(
          gh<_i29.GeneralStorageService>(),
          gh<_i29.BrowserTabsStorageService>(),
          gh<_i29.BrowserHistoryStorageService>(),
          gh<_i29.BrowserBookmarksStorageService>(),
          gh<_i29.BrowserPermissionsStorageService>(),
          gh<_i29.BrowserFaviconURLStorageService>(),
          gh<_i29.NekotonStorageService>(),
          gh<_i29.NekotonRepositoryStorageService>(),
          gh<_i29.TonWalletStorageService>(),
          gh<_i29.TokenWalletStorageService>(),
          gh<_i29.ConnectionsStorageService>(),
          gh<_i29.BalanceStorageService>(),
        ));
    gh.singleton<_i41.CurrentAccountsService>(() => _i41.CurrentAccountsService(
          gh<_i30.NekotonRepository>(),
          gh<_i29.CurrentKeyService>(),
        ));
    gh.singleton<_i42.CurrenciesService>(() => _i42.CurrenciesService(
          httpService: gh<_i29.HttpService>(),
          nekotonRepository: gh<_i30.NekotonRepository>(),
          currentAccounts: gh<_i29.CurrentAccountsService>(),
          storageService: gh<_i29.GeneralStorageService>(),
          appLifecycle: gh<_i29.AppLifecycleService>(),
        ));
    gh.singleton<_i43.BalanceService>(() => _i43.BalanceService(
          gh<_i30.NekotonRepository>(),
          gh<_i29.CurrenciesService>(),
        ));
    return this;
  }
}
