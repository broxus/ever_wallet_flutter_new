import 'package:app/app/service/service.dart';
import 'package:app/data/models/connection/connection_data.dart';
import 'package:elementary/elementary.dart';
import 'package:rxdart/rxdart.dart';

class SelectNetworkModel extends ElementaryModel {
  SelectNetworkModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  BehaviorSubject<String> get currentConnectionId =>
      _storageService.currentConnectionIdStream;

  BehaviorSubject<List<ConnectionData>> get connections =>
      _storageService.connectionsStream;

  void changeCurrentConnection(String id) {
    if (_storageService.currentConnectionId == id) return;
    _storageService.saveCurrentConnectionId(id);
  }
}
