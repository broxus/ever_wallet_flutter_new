import 'package:app/app/service/messenger/messenger.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/constants.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [WelcomeScreen]
class WelcomeScreenModel extends ElementaryModel with ConnectionMixin {
  WelcomeScreenModel(
    ErrorHandler errorHandler,
    this.networkConnectionService,
    this.messengerService,
  ) : super(errorHandler: errorHandler);

  @protected
  @override
  final NetworkConnectionService networkConnectionService;

  @protected
  @override
  final MessengerService messengerService;

  Future<List<String>> createSeed() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    return seed.words;
  }
}
