import 'package:app/app/service/connection/data/connection_data/connection_data.dart';
import 'package:app/app/service/service.dart';
import 'package:elementary/elementary.dart';
import 'package:rxdart/rxdart.dart';

class ConfigureNetworksModel extends ElementaryModel {
  ConfigureNetworksModel(
    ErrorHandler errorHandler,
    this._storageService,
  ) : super(errorHandler: errorHandler);

  final ConnectionsStorageService _storageService;

  BehaviorSubject<List<ConnectionData>> get connections =>
      _storageService.connectionsStream;
}
