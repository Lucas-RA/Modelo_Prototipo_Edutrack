import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle display({
    double size = 22,
    FontWeight weight = FontWeight.w700,
    Color color = AppColors.ink900,
    FontStyle style = FontStyle.normal,
  }) =>
      GoogleFonts.fraunces(
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        color: color,
        height: 1.2,
      );

  static TextStyle body({
    double size = 14,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink900,
    double? height,
  }) =>
      GoogleFonts.inter(
        fontSize: size,
        fontWeight: weight,
        color: color,
        height: height,
      );

  static TextStyle mono({
    double size = 10.5,
    FontWeight weight = FontWeight.w600,
    Color color = AppColors.ink400,
    double letterSpacing = 0.6,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
      );
}
