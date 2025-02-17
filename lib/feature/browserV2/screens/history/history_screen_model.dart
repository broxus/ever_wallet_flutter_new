import 'package:app/app/service/localization/service/localization_service.dart';
import 'package:app/data/models/browser_history_item.dart';
import 'package:app/feature/browserV2/screens/history/history_screen.dart';
import 'package:app/feature/browserV2/service/browser_service.dart';
import 'package:elementary/elementary.dart';

/// [ElementaryModel] for [HistoryScreen]
class HistoryScreenModel extends ElementaryModel {
  HistoryScreenModel(
    ErrorHandler errorHandler,
    this._browserService,
    this._localizationService,
  ) : super(errorHandler: errorHandler);

  late final localeCode = _localizationService.localeCode.name;

  final BrowserService _browserService;
  final LocalizationService _localizationService;

  Stream<List<BrowserHistoryItem>> get originalBrowserHistoryStream =>
      _browserService.hM.browserHistoryStream;

  List<BrowserHistoryItem> get originalBrowserHistoryItems =>
      _browserService.hM.browserHistoryItems;

  void removeHistoryItem(String id) => _browserService.hM.removeHistoryItem(id);

  void clearHistory() => _browserService.hM.clearHistory();
}
