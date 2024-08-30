import 'package:elementary/elementary.dart';

class ManualBackUpModel extends ElementaryModel {
  ManualBackUpModel(
    ErrorHandler errorHandler,
    this.phrases,
  ) : super(errorHandler: errorHandler);

  final List<String> phrases;
}
