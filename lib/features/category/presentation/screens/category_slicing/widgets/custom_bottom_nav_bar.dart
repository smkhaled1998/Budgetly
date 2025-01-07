import 'package:budget_buddy/core/main_navigator.dart';
import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../domain/entities/category_entity.dart';
import '../../../widgets/category_creation.dart';

class CustomSetUpBottomBar extends StatelessWidget {
  const CustomSetUpBottomBar({Key? key, required this.categoriesList}) : super(key: key);

  final List<CategoryEntity> categoriesList;

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
              onPressed: () async {
                CategoryCubit categoryCubit = CategoryCubit.get(context);

                // Initialize/update all categories at once
                await categoryCubit.initializeCategories(categoryCubit.fetchedCategories);

                // Navigate to main screen after successful update
                if (context.mounted) {

                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => const MainNavigator())
                  );
                }
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