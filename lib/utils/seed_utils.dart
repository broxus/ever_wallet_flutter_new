import 'package:app/utils/clipboard_utils.dart';

final _separatorRegExp = RegExp(r'\W+');

Future<List<String>> getSeedListFromClipboard() async {
  final text = await getClipBoardText();
  if (text == null) {
    return [];
  }

  return text.split(_separatorRegExp).where((word) => word.isNotEmpty).toList();
}

Future<String> getSeedTextFromClipboard() async {
  return (await getSeedListFromClipboard()).join(' ');
}
