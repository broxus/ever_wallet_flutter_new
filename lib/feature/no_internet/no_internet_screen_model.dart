import 'package:app/feature/no_internet/no_internet_screen.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [NoInternetScreen]
class NoInternetScreenModel extends ElementaryModel {
  NoInternetScreenModel(
    ErrorHandler errorHandler,
  ) : super(errorHandler: errorHandler);
}
