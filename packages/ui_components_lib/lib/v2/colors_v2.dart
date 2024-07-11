import 'package:flutter/material.dart';

class ColorsPaletteV2 {
  const ColorsPaletteV2({
    required this.primaryA,
    required this.primaryB,
    required this.accent,
    required this.negative,
    required this.warning,
    required this.positive,
    required this.background0,
    required this.background1,
    required this.background2,
    required this.background3,
    required this.backgroundAlpha,
    required this.backgroundNegativeAlpha,
    required this.backgroundWarningAlpha,
    required this.backgroundPositiveAlpha,
    required this.content0,
    required this.content1,
    required this.content2,
    required this.content3,
    required this.border0,
    required this.border1,
    required this.border2,
    required this.borderAlpha,
    required this.borderFocus,
    required this.backgroundOverlay,
    required this.backgroundNegative,
    required this.backgroundWarning,
    required this.backgroundPositive,
    required this.contentNegative,
    required this.contentWarning,
    required this.contentPositive,
    required this.contentNegative1,
    required this.contentWarning1,
    required this.contentPositive1,
    required this.borderNegative,
    required this.borderWarning,
    required this.borderPositive,
  });

  ///Core
  final Color primaryA;
  final Color primaryB;
  final Color accent;
  final Color negative;
  final Color warning;
  final Color positive;

  ///Background-semantic
  final Color background0;
  final Color background1;
  final Color background2;
  final Color background3;

  ///Content-semantic
  final Color content0;
  final Color content1;
  final Color content2;
  final Color content3;

  ///Border-semantic
  final Color border0;
  final Color border1;
  final Color border2;
  final Color borderAlpha;
  final Color borderFocus;

  ///Extensions-background
  final Color backgroundOverlay;
  final Color backgroundNegative;
  final Color backgroundWarning;
  final Color backgroundPositive;
  final Color backgroundAlpha;
  final Color backgroundNegativeAlpha;
  final Color backgroundWarningAlpha;
  final Color backgroundPositiveAlpha;

  ///Extensions-content
  final Color contentNegative;
  final Color contentNegative1;
  final Color contentWarning;
  final Color contentWarning1;
  final Color contentPositive;
  final Color contentPositive1;

  ///Extensions-border
  final Color borderNegative;
  final Color borderWarning;
  final Color borderPositive;
}

class ColorsResV2 {
  const ColorsResV2._();

  static const transparent = Color(0x00000000);

  ///primary
  static const p10 = Color(0xFF110A33);
  static const p20 = Color(0xFF211463);
  static const p30 = Color(0xFF311F90);
  static const p40 = Color(0xFF412AB8);
  static const p50 = Color(0xFF5237DA);
  static const p60 = Color(0xFF6347F5);
  static const p65 = Color(0xFF7459FF);
  static const p70 = Color(0xFF876FFF);
  static const p75 = Color(0xFF9D88FF);
  static const p80 = Color(0xFFB5A4FF);
  static const p85 = Color(0xFFCFC3FF);
  static const p90 = Color(0xFFDBD3FF);
  static const p95 = Color(0xFFE8E2FF);
  static const p99 = Color(0xFFF4F1FF);
  static const p100 = Color(0xFFFFFFFF);

  ///neutral
  static const n10 = Color(0xFF11142B);
  static const n15 = Color(0xFF1B1E3D);
  static const n20 = Color(0xFF272B4F);
  static const n30 = Color(0xFF353960);
  static const n35 = Color(0xFF444872);
  static const n40 = Color(0xFF555984);
  static const n50 = Color(0xFF686C95);
  static const n60 = Color(0xFF7D81A7);
  static const n65 = Color(0xFF9497B8);
  static const n70 = Color(0xFFACAECA);
  static const n80 = Color(0xFFC6C8DC);
  static const n90 = Color(0xFFE1E2ED);
  static const n95 = Color(0xFFF0F1F6);
  static const n99 = Color(0xFFF7F8FB);
  static const n100 = Color(0xFFFFFFFF);

  ///error
  static const e0 = Color(0xFF050101);
  static const e10 = Color(0xFF210A06);
  static const e15 = Color(0xFF3D120B);
  static const e20 = Color(0xFF581B10);
  static const e30 = Color(0xFF742615);
  static const e35 = Color(0xFF90331D);
  static const e40 = Color(0xFFAC4328);
  static const e50 = Color(0xFFC75737);
  static const e60 = Color(0xFFE3704C);
  static const e70 = Color(0xFFFF8F69);
  static const e80 = Color(0xFFFFAE96);
  static const e85 = Color(0xFFFFC0B1);
  static const e90 = Color(0xFFFFD3CB);
  static const e95 = Color(0xFFFFE8E5);
  static const e100 = Color(0xFFFFFFFF);

  ///success
  static const s5 = Color(0xFF08190E);
  static const s10 = Color(0xFF0F3019);
  static const s20 = Color(0xFF174725);
  static const s25 = Color(0xFF205E31);
  static const s30 = Color(0xFF2C753E);
  static const s40 = Color(0xFF398C4D);
  static const s45 = Color(0xFF4AA35E);
  static const s55 = Color(0xFF60B972);
  static const s65 = Color(0xFF7BD08B);
  static const s75 = Color(0xFF9DE7A9);
  static const s85 = Color(0xFFBEF3C2);
  static const s90 = Color(0xFFCEF6CE);
  static const s95 = Color(0xFFDFF9DE);
  static const s99 = Color(0xFFF0FCEE);
  static const s100 = Color(0xFFFFFFFF);

  ///warning
  static const w10 = Color(0xFF332C1F);
  static const w20 = Color(0xFF4C422B);
  static const w30 = Color(0xFF665737);
  static const w40 = Color(0xFF7F6D41);
  static const w50 = Color(0xFF99824B);
  static const w60 = Color(0xFFB29854);
  static const w65 = Color(0xFFE5C469);
  static const w70 = Color(0xFFFFDA76);
  static const w75 = Color(0xFFFFE393);
  static const w80 = Color(0xFFFFE393);
  static const w85 = Color(0xFFFFEEB3);
  static const w90 = Color(0xFFFFF1C7);
  static const w95 = Color(0xFFFFF5DA);
  static const w99 = Color(0xFFFFF9ED);
  static const w100 = Color(0xFFFFFFFF);

  ///monochrome
  static const m10 = Color(0xFF1A1A1A);
  static const m15 = Color(0xFF262626);
  static const m20 = Color(0xFF2F2F2F);
  static const m25 = Color(0xFF3C3C3C);
  static const m30 = Color(0xFF4C4C4C);
  static const m40 = Color(0xFF606060);
  static const m50 = Color(0xFF797979);
  static const m60 = Color(0xFF969696);
  static const m70 = Color(0xFFB7B7B7);
  static const m80 = Color(0xFFC9C9C9);
  static const m85 = Color(0xFFDBDBDB);
  static const m90 = Color(0xFFEDEDED);
  static const m100 = Color(0xFFFFFFFF);
}
