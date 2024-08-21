import 'package:ui_components_lib/utils/view_utils.dart';

enum AppLayout {
  phone,
  tablet;
}

final currentAppLayout =
    initialScreenWidth >= minTabletWidth ? AppLayout.tablet : AppLayout.phone;

final isPhoneL = currentAppLayout == AppLayout.phone;
