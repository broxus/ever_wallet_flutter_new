import 'package:app/app/service/biometry_service.dart';
import 'package:app/app/service/messenger/message.dart';
import 'package:app/app/service/messenger/service/messenger_service.dart';
import 'package:app/app/service/nekoton_related/current_key_service.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [CreateSeedPasswordScreen]
class CreateSeedPasswordScreenModel extends ElementaryModel {
  CreateSeedPasswordScreenModel(
    ErrorHandler errorHandler,
    this._biometryService,
    this._currentKeyService,
    this._messengerService,
    this._nekotonRepository,
    this._phrase,
  ) : super(errorHandler: errorHandler);

  final BiometryService _biometryService;
  final CurrentKeyService _currentKeyService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;
  final SeedPhraseModel? _phrase;

  Future<void> next({
    required String password,
  }) async {
    late SeedPhraseModel seed;

    try {
      if (_phrase?.isNotEmpty ?? false) {
        seed = _phrase!;
      } else {
        seed = await _createSeed();
      }

      final publicKey = await _nekotonRepository.addSeed(
        phrase: seed.words,
        password: password,
      );

      await _currentKeyService.changeCurrentKey(publicKey);

      await _biometryService.setKeyPassword(
        publicKey: publicKey,
        password: password,
      );
    } catch (e) {
      Logger('CreateSeedPasswordCubit').severe(e);
      _messengerService.show(Message.error(message: e.toString()));
    }
  }

  Future<SeedPhraseModel> _createSeed() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    return SeedPhraseModel.fromWords(seed.words);
  }
}
