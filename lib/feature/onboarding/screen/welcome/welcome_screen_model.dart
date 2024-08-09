import 'package:app/feature/constants.dart';
import 'package:app/feature/onboarding/screen/welcome/welcome_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:nekoton_repository/nekoton_repository.dart';

/// [ElementaryModel] for [WelcomeScreen]
class WelcomeScreenModel extends ElementaryModel {
  WelcomeScreenModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  Future<List<String>> createSeed() async {
    final seed = await generateKey(accountType: defaultMnemonicType);
    return seed.words;
  }
}
