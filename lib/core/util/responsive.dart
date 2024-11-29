import 'package:flutter/widgets.dart';

class Responsive {
  static late double screenWidth;
  static late double screenHeight;

  // إعداد أبعاد الشاشة
  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  // حساب النسبة بناءً على العرض
  static double width(double percentage) {
    return screenWidth * percentage / 100;
  }

  // حساب النسبة بناءً على الارتفاع
  static double height(double percentage) {
    return screenHeight * percentage / 100;
  }

  // حساب حجم الخط بناءً على أصغر بُعد (عرض أو ارتفاع)
  static double fontSize(double percentage) {
    return (screenWidth < screenHeight ? screenWidth : screenHeight) *
        percentage /
        100;
  }
}
