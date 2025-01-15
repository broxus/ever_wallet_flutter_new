import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/network_connection/network_connection_service.dart';
import 'package:app/feature/add_seed/enter_seed_phrase/enter_seed_phrase.dart';
import 'package:app/feature/constants.dart';
import 'package:app/utils/mixins/connection_mixin.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart' as nekoton;

/// [ElementaryModel] for [EnterSeedPhrase]
class EnterSeedPhraseModel extends ElementaryModel with ConnectionMixin {
  EnterSeedPhraseModel(
    ErrorHandler errorHandler,
    this.networkConnectionService,
    this.messengerService,
    this._nekotonRepository,
  ) : super(errorHandler: errorHandler);

  final actualSeedPhraseLength = 12;
  final legacySeedPhraseLength = 24;

  @override
  final NetworkConnectionService networkConnectionService;
  @override
  final MessengerService messengerService;
  final nekoton.NekotonRepository _nekotonRepository;

  late final List<int> seedPhraseWordsCount =
      _nekotonRepository.currentTransport.seedPhraseWordsCount;

  Future<nekoton.GeneratedKeyG> getKey(int currentValue) {
    return nekoton.generateKey(
      accountType: currentValue == legacySeedPhraseLength
          ? const nekoton.MnemonicType.legacy()
          : defaultMnemonicType,
    );
  }

  Future<List<String>> getHints(String text) => nekoton.getHints(input: text);

  /// [text] is valid if it is in list of hints for this word.
  Future<bool> checkIsWordValid(String text) async {
    final hints = await getHints(text);
    if (hints.contains(text)) {
      return true;
    }

    return false;
  }

  void showError(String text) => handleError(text);
}
