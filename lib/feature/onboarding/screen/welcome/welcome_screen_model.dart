import 'package:app/app/service/messenger/messenger.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/constants.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:app/generated/generated.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [WelcomeScreen]
class WelcomeScreenModel extends ElementaryModel {
  WelcomeScreenModel(
    ErrorHandler errorHandler,
    this._networkConnectionService,
    this._messengerService,
  ) : super(errorHandler: errorHandler);

  final NetworkConnectionService _networkConnectionService;
  final MessengerService _messengerService;

  Future<bool> get isConnected => _networkConnectionService.isConnected;

  Future<List<String>> createSeed() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    return seed.words;
  }

  void showConnectionError() {
    _messengerService.show(
      Message.error(
        message: LocaleKeys.connectingNetworkFailed.tr(),
      ),
    );
  }
}
