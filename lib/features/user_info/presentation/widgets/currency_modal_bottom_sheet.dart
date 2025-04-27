import 'package:budget_buddy/core/constances.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/themes/app_color.dart';



class CurrencyBottomSheet extends StatelessWidget {
  CurrencyBottomSheet({required this.settingCubit});
  final SettingCubit settingCubit;


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
                String currenciesKey = currencies.keys.elementAt(index);
                Map<String, String> currency = currencies[currenciesKey]!;
                return ListTile(
                  leading: Text(currency['flag']!),
                  title: Text(currency['currencyName']!),
                  subtitle: Text(currency['currencySymbol']!),
                  onTap: () {
                     settingCubit.selectCurrency(currenciesKey);
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
