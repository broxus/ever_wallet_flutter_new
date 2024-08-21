// All the sizes available in the application.
// If you need add custom size or radius, that is not fit guideline,
// add it in the page you wanna use it.

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ui_components_lib/utils/platform_utils.dart';

/// Class that contains all the size used in the app.
/// If you need add custom size, please add it in page where it's used.
///
/// All sizes must be multiple of 4 or 8.
class DimensSize {
  const DimensSize._();

  static const double d4 = 4;
  static const double d8 = 8;
  static const double d10 = 10;
  static const double d12 = 12;
  static const double d14 = 14;
  static const double d16 = 16;
  static const double d18 = 18;
  static const double d20 = 20;
  static const double d22 = 22;
  static const double d24 = 24;
  static const double d28 = 28;
  static const double d32 = 32;
  static const double d36 = 36;
  static const double d38 = 38;
  static const double d40 = 40;
  static const double d44 = 44;
  static const double d48 = 48;
  static const double d56 = 56;
  static const double d64 = 64;
  static const double d68 = 68;
  static const double d72 = 72;
  static const double d76 = 76;
  static const double d92 = 92;
  static const double d100 = 100;
  static const double d132 = 132;
  static const double d148 = 148;
  static const double d168 = 168;
  static const double d200 = 200;
  static const double d220 = 220;
}

class DimensAdaptiveSize {
  DimensAdaptiveSize._(this.v);

  final double v;

  late final double wp = v.wp;
  late final double hp = v.hp;

  static final d4 = DimensAdaptiveSize._(4);
  static final d8 = DimensAdaptiveSize._(8);
  static final d10 = DimensAdaptiveSize._(10);
  static final d12 = DimensAdaptiveSize._(12);
  static final d14 = DimensAdaptiveSize._(14);
  static final d16 = DimensAdaptiveSize._(16);
  static final d18 = DimensAdaptiveSize._(18);
  static final d20 = DimensAdaptiveSize._(20);
  static final d22 = DimensAdaptiveSize._(22);
  static final d24 = DimensAdaptiveSize._(24);
  static final d28 = DimensAdaptiveSize._(28);
  static final d32 = DimensAdaptiveSize._(32);
  static final d36 = DimensAdaptiveSize._(36);
  static final d38 = DimensAdaptiveSize._(38);
  static final d40 = DimensAdaptiveSize._(40);
  static final d44 = DimensAdaptiveSize._(44);
  static final d48 = DimensAdaptiveSize._(48);
  static final d56 = DimensAdaptiveSize._(56);
  static final d64 = DimensAdaptiveSize._(64);
  static final d68 = DimensAdaptiveSize._(68);
  static final d72 = DimensAdaptiveSize._(72);
  static final d76 = DimensAdaptiveSize._(76);
  static final d92 = DimensAdaptiveSize._(92);
  static final d100 = DimensAdaptiveSize._(100);
  static final d132 = DimensAdaptiveSize._(132);
  static final d148 = DimensAdaptiveSize._(148);
  static final d168 = DimensAdaptiveSize._(168);
  static final d200 = DimensAdaptiveSize._(200);
  static final d220 = DimensAdaptiveSize._(220);
}

/// Class that contains all the stroke used in the app.
class DimensStroke {
  const DimensStroke._();

  static const double small = 1;
  static const double medium = 2;
}

/// Class that contains all the radius used in the app.
/// If you need add custom radius, please add it in page where it's used.
class DimensRadius {
  const DimensRadius._();

  static const double xSmall = 4;
  static const double small = 8;
  static const double xMedium = 12;
  static const double medium = 16;
  static const double large = 24;
  static const double max = 90;
}

/// Class that contains all the elevation used in the app.
class DimensElevation {
  const DimensElevation._();

  static const double medium = 24;
}

// ignore_for_file: unused_element
extension on num {
  /// Width platform
  double get wp => isPhoneL ? w : toDouble();

  /// Height platform
  double get hp => isPhoneL ? h : toDouble();

  /// Radius platform
  double get rp => isPhoneL ? r : toDouble();

  /// sp platform
  double get spp => isPhoneL ? sp : toDouble();
}
