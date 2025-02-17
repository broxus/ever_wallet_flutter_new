sealed class HistoryUiModel {}

class DateUiModel extends HistoryUiModel {
  DateUiModel(this.dateText);

  final String dateText;
}

class ItemUiModel extends HistoryUiModel {
  ItemUiModel({
    required this.id,
    required this.url,
    required this.title,
  });

  final String id;
  final Uri url;
  final String title;
  late final String subTitleText = url.toString();
}
