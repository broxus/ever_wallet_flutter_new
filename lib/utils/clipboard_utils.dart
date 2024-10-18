import 'package:flutter/services.dart';

Future<ClipboardData?> getClipBoardData() async {
  return Clipboard.getData(Clipboard.kTextPlain);
}

Future<String?> getClipBoardText() async {
  return (await getClipBoardData())?.text;
}
