import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

@singleton
class NetworkConnectionService {
  final _internetConnection = InternetConnection();

  Future<bool> get isExistInternet async =>
      _checkInternet(await _internetConnection.internetStatus);

  bool _checkInternet(InternetStatus status) {
    return switch (status) {
      InternetStatus.disconnected => false,
      _ => true,
    };
  }
}
