import 'package:flutter/material.dart';

class AppColor {
  // Primary Color - أزرق داكن أنيق للخلفيات الرئيسية
  static const Color primaryColor = Color(0xFF164863); // Royal Blue

  // Secondary Color - أزرق كحلي أغمق للعمق البصري
  static const Color secondaryColor = Color(0xFF172B4D); // Navy Blue

  // Accent Color - لعناصر التفاعل مثل الأزرار
  static const Color accentColor = Color(0xFF00FFC8); // CyanAccent مميز (تماثل في الغالبية)

  // Backgrounds
  static const Color backgroundCircleWhite = Color(0x80FFFFFF); // أبيض شفاف للزخارف
  static const Color backgroundGlass = Color(0x1AFFFFFF); // خلفية زجاجية (شفافة)
  static const Color backgroundCardBorder = Color(0x33FFFFFF); // إطار شفاف للبطاقات
  static const Color backgroundCardShadow = Color(0x1A000000); // ظل داكن خفيف

  // Text Colors
  static const Color textColor = Colors.black;
  static const Color textSecondary = Colors.white70;
  static const Color textLight = Color(0xB3FFFFFF); // تقريبًا white.withOpacity(0.7)

  // Progress Indicator Colors
  static const Color progressBackground = Color(0x33FFFFFF); // شفاف
  static const Color progressSafe = Colors.greenAccent;
  static const Color progressWarning = Colors.redAccent;

  // Budget Info Icons
  static const Color iconSpent = Colors.redAccent;
  static const Color iconTotal = Colors.blueAccent;

  // Gradient Progress Bar
  static const List<Color> progressGradientSafe = [Colors.greenAccent, Colors.cyanAccent];
  static const List<Color> progressGradientWarning = [Colors.redAccent, Colors.orangeAccent];

  // Shadow color for progress bar
  static const Color progressShadowSafe = Color(0x8032CD32); // تقريباً greenAccent شفاف
  static const Color progressShadowWarning = Color(0x80FF5252); // تقريباً redAccent شفاف
}
