import 'package:budget_buddy/core/main_navigator.dart';
import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../widgets/new_category_dialog.dart';

class CustomSetUpBottomBar extends StatelessWidget {
  const CustomSetUpBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {

                Navigator.push(context,   MaterialPageRoute(builder: (ctx)=>MainNavigator()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle_outline, size: 20),
                  const Gap(8),
                  Text(
                    "Confirm Budget",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Gap(12),
          Container(
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () => CategoryCreationSheet.show(context, isSetting: true),
              icon: const Icon(Icons.add),
              color: AppColor.primaryColor,
              iconSize: 24,
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}