import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/identy_colors.dart';

abstract interface class IIdentifyIconsService {
  abstract final List<IdentifyColor> availableColors;

  Stream<AccountsColorsCollection> get accountsColorsStream;

  IdentifyColor get initialColor;

  void setColor(String key, IdentifyColor color);

  Future<IdentifyColor> getColor(String key);
}
