import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [NoInternetScreen]
class NoInternetScreenModel extends ElementaryModel {
  NoInternetScreenModel(
    ErrorHandler errorHandler,
    this._networkConnectionService,
  ) : super(errorHandler: errorHandler);

  final NetworkConnectionService _networkConnectionService;

  Future<bool> get isExistInternet => _networkConnectionService.isExistInternet;
}
