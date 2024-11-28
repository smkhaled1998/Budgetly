import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constances.dart';
import '../../../../../core/themes/app_color.dart';

class CurrencyBottomSheet extends StatefulWidget {
  const CurrencyBottomSheet({super.key});

  @override
  State<CurrencyBottomSheet> createState() => _CurrencyBottomSheetState();
}

class _CurrencyBottomSheetState extends State<CurrencyBottomSheet> {
  String selectedCurrency = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select Currency',
            style: GoogleFonts.abel(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                String key = currencies.keys.elementAt(index);
                Map<String, String> currency = currencies[key]!;
                return ListTile(
                  leading: Text(currency['flag']!),
                  title: Text(currency['currencyName']!),
                  subtitle: Text(currency['currencySymbol']!),
                  onTap: () {
                    setState(() {
                      selectedCurrency = key;
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
