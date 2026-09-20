import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const green900 = Color(0xFF0F3E2A);
  static const green800 = Color(0xFF1B5E3F);
  static const green700 = Color(0xFF236B49);
  static const green600 = Color(0xFF2E8A57);

  static const lime = Color(0xFFBADB42);
  static const teal = Color(0xFF40B5C6);
  static const blue = Color(0xFF0F8FDA);
  static const deep = Color(0xFF1F567F);

  static const amber500 = Color(0xFFD4A436);
  static const amber100 = Color(0xFFFBEDC8);
  static const red500 = Color(0xFFEE534F);
  static const red100 = Color(0xFFFCE3E2);
  static const green100 = Color(0xFFE8F6E9);
  static const blue100 = Color(0xFFE6EFFA);

  static const ink50 = Color(0xFFF5F7F6);
  static const ink400 = Color(0xFF94A39C);
  static const ink600 = Color(0xFF5B6B63);
  static const ink900 = Color(0xFF1B2320);

  static const line = Color(0xFFE4E9E5);
  static const card = Color(0xFFFFFFFF);

  static const levelCardGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [green600, green900],
  );

  static const xpBarGradient = LinearGradient(
    colors: [amber500, lime],
  );
}
