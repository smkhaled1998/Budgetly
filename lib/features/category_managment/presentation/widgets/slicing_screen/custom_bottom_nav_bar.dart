import 'package:budget_buddy/core/data/models/category_model.dart';
import 'package:budget_buddy/core/domain/entities/category_entity.dart';
import 'package:budget_buddy/core/themes/app_color.dart';
import 'package:budget_buddy/features/category_managment/presentation/cubit/category_cubit.dart';
import 'package:budget_buddy/features/category_managment/presentation/screens/explore_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/Widgets/pickers/picker_dialog_helpers.dart';

class CustomSetUpBottomBar extends StatelessWidget {
  const CustomSetUpBottomBar({Key? key, required this.categoriesList, required this.categoryCubit}) : super(key: key);
  final CategoryCubit categoryCubit;
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
                CategoryCubit categoryCubit=CategoryCubit.get(context);

                if(categoryCubit.remainingBudget>0){
                   // _showBudgetAlertDialog(context,categoryCubit);
                }
                else{
                  await categoryCubit.initializeCategoriesStage(categoryCubit.fetchedCategories);

                  if (context.mounted) {

                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) =>  ExploreScreen())
                    );
                  }
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
            height:60 ,
            width: 60,
            decoration: BoxDecoration(
              color: AppColor.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () {

                CategoryCubit categoryCubit=BlocProvider.of(context);
                final CategoryEntity newItem = CategoryManagementModel(
                  categoryId: null,
                  // No ID yet since it's a new category
                  name: "",
                  allocatedAmount: 0.0,
                  storedSpentAmount: 0.0,
                  color: "",
                  icon: "", // Default icon (can be updated later)
                );

                    _showAddCategoryDialog(
                    categoryCubit: categoryCubit,
                    // categoryColor:categoryCubit.categoryColor ,
                    context:context );

                // CategoryCreationSheet.show(context,
                //     isSetting: true, item: newItem);
              },
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


  void _showAddCategoryDialog(
      {required CategoryCubit categoryCubit, context}) async {
    final result = await PickerDialogHelpers.showCategoryPickerDialog(

        pickerFunction: (newCategoryEntity){
        categoryCubit.addNewSettingUpCategory(newCategoryEntity);
        },
      context: context,
      title: "Add New Category",

    );
    if (result != null) {

    }
  }


// void _showBudgetAlertDialog(
  //     BuildContext context, CategoryCubit categoryCubit) {
  //   showGeneralDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     barrierLabel: '',
  //     barrierColor: Colors.black54,
  //     transitionDuration: const Duration(milliseconds: 300),
  //     pageBuilder: (context, animation1, animation2) {
  //       return Container();
  //     },
  //     transitionBuilder: (context, animation, secondaryAnimation, child) {
  //       return ScaleTransition(
  //         scale: Tween<double>(begin: 0.5, end: 1.0).animate(
  //           CurvedAnimation(
  //             parent: animation,
  //             curve: Curves.easeOutCubic,
  //           ),
  //         ),
  //         child: FadeTransition(
  //           opacity: animation,
  //           child: BlocProvider.value(
  //             value: categoryCubit,
  //             child: SavingBalanceDialog(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}