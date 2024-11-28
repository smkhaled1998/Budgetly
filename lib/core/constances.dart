import 'package:flutter/material.dart';

Map<String, Map<String, String>> currencies = {
  "OMR": {
    "currencyName": "Omani Rial",
    "currencySymbol": "﷼",
    "flag": "🇴🇲"
  },
  "TRY": {
    "currencyName": "Turkish Lira",
    "currencySymbol": "₺",
    "flag": "🇹🇷"
  },
  "EGP": {
    "currencyName": "Egyptian Pound",
    "currencySymbol": "£",
    "flag": "🇪🇬"
  },
  "QAR": {
    "currencyName": "Qatari Riyal",
    "currencySymbol": "﷼",
    "flag": "🇶🇦"
  },
  "KWD": {
    "currencyName": "Kuwaiti Dinar",
    "currencySymbol": "د.ك",
    "flag": "🇰🇼"
  },

  "USD": {
    "currencyName": "United States Dollar",
    "currencySymbol": "\$",
    "flag": "🇺🇸"
  },
  "EUR": {
    "currencyName": "Euro",
    "currencySymbol": "€",
    "flag": "🇪🇺"
  },
  "JPY": {
    "currencyName": "Japanese Yen",
    "currencySymbol": "¥",
    "flag": "🇯🇵"
  },

  "BRL": {
    "currencyName": "Brazilian Real",
    "currencySymbol": "R\$",
    "flag": "🇧🇷"
  },
  "SAR": {
    "currencyName": "Saudi Riyal",
    "currencySymbol": "﷼",
    "flag": "🇸🇦"
  },

};
List<String> iconImages = [
  "assets/housing.png",
  "assets/saving.png",
  "assets/transportation.png",
  "assets/entertainment.png",
  "assets/healthcare.png",
  "assets/food&drink.png",
];
Color parseColorFromString(String colorString) {
  try {
    // إزالة "Color(" و ")" إن وجدت
    colorString = colorString.replaceAll("Color(", "").replaceAll(")", "");

    // التعامل مع صيغ مختلفة من اللون
    if (colorString.startsWith('0x')) {
      // إذا كان اللون بصيغة hexadecimal
      return Color(int.parse(colorString));
    } else if (colorString.startsWith('MaterialAccent')) {
      // التعامل مع ألوان Material Accent
      switch (colorString) {
        case 'MaterialAccentprimary':
          return Colors.blueAccent;
      // يمكنك إضافة المزيد من الحالات حسب الحاجة
        default:
          return Colors.blue; // لون افتراضي
      }
    } else {
      // محاولة التعامل مع الصيغ الأخرى
      return Color(int.parse('0xff${colorString.padLeft(6, '0')}'));
    }
  } catch (e) {
    print('Error parsing color: $colorString - $e');
    return Colors.blue; // لون افتراضي في حالة الخطأ
  }
}