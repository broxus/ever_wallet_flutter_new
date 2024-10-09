import 'package:app/app/service/service.dart';
import 'package:app/feature/browser/utils.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

class ChangeNetworkModel extends ElementaryModel {
  ChangeNetworkModel(
    ErrorHandler errorHandler,
    this._messengerService,
    this._connectionsStorageService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final MessengerService _messengerService;
  final ConnectionsStorageService _connectionsStorageService;
  final NekotonRepository _nekotonRepository;

  Future<TransportStrategy> changeNetwork(String id) async {
    await _connectionsStorageService.saveCurrentConnectionId(id);
    return _nekotonRepository.currentTransportStream.firstWhere(
      (strategy) => strategy.connection?.id == id,
    );
  }

  void showError(BuildContext context, String message) {
    _messengerService.show(
      Message.error(context: context, message: message),
    );
  }
}
