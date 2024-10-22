import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TypographyX on TextStyle {
  TextStyle get inter => GoogleFonts.inter(textStyle: this);

  /// fontweight: 400
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// fontweight: 500
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// fontweight: 600
  TextStyle get semi => copyWith(fontWeight: FontWeight.w600);

  /// fontweight: 700
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// Italic
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// fontweight: 800
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  /// fontweight: 900
  TextStyle get black => copyWith(fontWeight: FontWeight.w900);

  /// underlined text
  TextStyle get underlined => copyWith(decoration: TextDecoration.underline);
}
