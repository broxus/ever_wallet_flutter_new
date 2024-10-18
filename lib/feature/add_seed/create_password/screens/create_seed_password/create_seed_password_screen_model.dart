// ignore_for_file: use_build_context_synchronously

import 'package:app/app/service/service.dart';
import 'package:app/data/models/seed/seed_phrase_model.dart';
import 'package:app/feature/add_seed/create_password/screens/create_seed_password/create_seed_password_screen.dart';
import 'package:app/feature/constants.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nekoton_repository/nekoton_repository.dart' hide Message;

/// [ElementaryModel] for [CreateSeedPasswordScreen]
class CreateSeedPasswordScreenModel extends ElementaryModel {
  CreateSeedPasswordScreenModel(
    ErrorHandler errorHandler,
    this._biometryService,
    this._currentKeyService,
    this._currentAccountService,
    this._messengerService,
    this._nekotonRepository,
    this._phrase,
  ) : super(errorHandler: errorHandler);

  final BiometryService _biometryService;
  final CurrentKeyService _currentKeyService;
  final CurrentAccountsService _currentAccountService;
  final MessengerService _messengerService;
  final NekotonRepository _nekotonRepository;
  final SeedPhraseModel? _phrase;

  Future<void> next({
    required BuildContext context,
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

      await _currentAccountService.currentActiveAccountStream.firstWhere(
        (account) => account != null,
      );
    } catch (e) {
      Logger('CreateSeedPasswordCubit').severe(e);
      _messengerService.show(
        Message.error(context: context, message: e.toString()),
      );
    }
  }

  Future<SeedPhraseModel> _createSeed() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    return SeedPhraseModel.fromWords(seed.words);
  }
}
