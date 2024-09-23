import 'package:app/app/service/identify/accounts_colors_collection.dart';
import 'package:app/app/service/identify/identy_icon_data.dart';

abstract interface class IIdentifyIconsService {
  abstract final List<IdentifyIconData> availableColors;

  Stream<AccountsColorsCollection> get accountsColorsStream;

  IdentifyIconData get initialColor;

  void setColor(String key, IdentifyIconData color);

  Future<IdentifyIconData> getColor(String key);
}
