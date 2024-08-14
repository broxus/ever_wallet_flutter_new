import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@singleton
class NetworkConnectionService {
  final _connectivity = Connectivity();

  Future<bool> get isConnected async {
    final connections = await _connectivity.checkConnectivity();

    return !connections.contains(ConnectivityResult.none);
  }
}
