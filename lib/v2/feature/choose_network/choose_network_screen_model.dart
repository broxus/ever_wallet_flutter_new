import 'package:app/data/models/network_type.dart';
import 'package:app/v2/feature/choose_network/choose_network_screen.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';

/// [ElementaryModel] for [ChooseNetworkScreen]
class ChooseNetworkScreenModel extends ElementaryModel {
  ChooseNetworkScreenModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);

  final connectionsState = StateNotifier<List<NetworkType>>(
    initValue: [],
  );

  @override
  void init() {
    // NetworkType
    connectionsState.accept(
      [
        NetworkType.ever,
        NetworkType.venom,
      ],
    );
    super.init();
  }

  @override
  void dispose() {
    connectionsState.dispose();
    super.dispose();
  }

  Future<bool> selectType(NetworkType type) async {
    try {
      // TODO(knightforce): logic
    } on Object catch (_) {
      // TODO(knightforce): show error with elementary error handler
      return false;
    }

    return true;
  }
}
