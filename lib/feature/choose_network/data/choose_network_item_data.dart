import 'package:app/generated/generated.dart';

class ChooseNetworkItemData {
  ChooseNetworkItemData({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String id;
  final SvgGenImage icon;
  final String title;
  final String description;
}
