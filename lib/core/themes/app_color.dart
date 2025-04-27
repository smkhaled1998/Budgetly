import 'package:flutter/material.dart';

class AppColor {
  // Colors for Expense Tracking App based on primary color: 0xFF3B566D

  // Main Colors
  static const Color primaryColor = Color(0xFF3B566D);     // اللون الأساسي - أزرق مائل للرمادي
  static const Color secondaryColor = Color(0xFF2A3F50);   // نسخة أغمق من اللون الأساسي
  static const Color accentColor = Color(0xFF4F959D);      // لون فيروزي متباين للتأكيد
  static const Color expenseColor = Color(0xFFFF6B6B);     // لون أحمر للمصروفات

  static const Color categoryOthers = Color(0xFF90A4AE);   // رمادي مزرق للمتفرقات

  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F7FA);  // خلفية فاتحة
  static const Color cardBackground = Colors.white;        // خلفية بيضاء للبطاقات
  static const Color backgroundGlass = Color(0x1A3B566D);  // لون زجاجي نصف شفاف من اللون الأساسي
  static const Color backgroundCardShadow = Color(0x1A000000); // ظل البطاقات

  // Text Colors

  static const Color textPrimary = Color(0xFF263238);      // نص أساسي داكن
  static const Color textSecondary = Color(0xFF78909C);    // نص ثانوي رمادي
  static const Color textWhite = Colors.white;             // نص أبيض للخلفيات الداكنة

  // Bottom Bar Colors
  static const Color bottomWhiteBackGround = Colors.white;   // خلفية بيضاء للشريط السفلي
  static const Color bottomBarActive = Color(0xFF3B566D);  // لون أزرق للعناصر النشطة (اللون الأساسي)
  static const Color bottomBarInactive = Color(0xFFB0BEC5); // لون رمادي للعناصر غير النشطة

  // Others
  static const Color dividerColor = Color(0xFFECEFF1);     // لون فواصل فاتح
  static const Color incomeColor = Color(0xFF66BB6A);      // لون أخضر للدخل
  static const Color lightGray = Color(0x333B566D);        // رمادي فاتح مستوحى من اللون الأساسي
}