
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/themes/app_color.dart';
import '../../../../domain/entities/category_entity.dart';
import '../../../cubit/category_cubit.dart';


class BuildSlicingCategoryCard extends StatelessWidget {
  final CategoryEntity categoryEntity;
  final TextEditingController controller;
  final int index;
  final double monthlySalary;
  final Map<int, double> previousValues;
  final Function(CategoryCubit, CategoryEntity, double) onUpdateCategory;

  const BuildSlicingCategoryCard({
    Key? key,
    required this.categoryEntity,
    required this.controller,
    required this.index,
    required this.monthlySalary,
    required this.previousValues,
    required this.onUpdateCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryCubit = CategoryCubit.get(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: AppColor.lightGray,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColor.secondaryColor.withOpacity(0.1),
          child: Image.asset(
            categoryEntity.icon!,
            width: 25,
            height: 25,
          ),
        ),
        title: Text(
          categoryEntity.name!,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            color: AppColor.textColor,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              prefixText: '\$ ',
              prefixStyle: GoogleFonts.roboto(
                color: AppColor.accentColor,
                fontWeight: FontWeight.w600,
              ),
              hintText: '0.00',
              hintStyle: GoogleFonts.roboto(color: AppColor.textLightColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColor.lightGray,
            ),
            keyboardType: TextInputType.number,
            style: GoogleFonts.roboto(
              color: AppColor.textColor,
              fontWeight: FontWeight.w600,
            ),
            onChanged: (value) {
              // calculateCategoryAllocation
              _handleValueChange(value, categoryCubit, context);
              // categoryCubit.calculateCategoryAllocation(
              //     index, double.parse(value)??0.0);
            },
          ),
        ),
      ),
    );
  }

  void _handleValueChange(
      String value,
      CategoryCubit categoryCubit,
      BuildContext context,
      ) {
    if (value.isEmpty) {
      double difference = previousValues[index] ?? 0.0;
      categoryCubit.updateRemainingBudgetForProgressBar(difference);
      previousValues[index] = 0.0;
      categoryCubit.currentCategoryValue=0.0;
      onUpdateCategory(categoryCubit, categoryEntity, 0.0);
      return;
    }

    try {
      double newAllocation = double.parse(value);
      double previousAllocation = previousValues[index] ?? 0.0;
      double difference = previousAllocation - newAllocation;

      if(categoryCubit.currentCategoryIndex==index){
        categoryCubit.calculateCategoryAllocation(index, difference);

      }else{
        categoryCubit.currentCategoryIndex=index;
        categoryCubit.currentCategoryValue=categoryCubit.allocatedCategoryAmount[index]??0.0;
        print("When Change Index ${categoryCubit.allocatedCategoryAmount[index]??0.0}");

        categoryCubit.calculateCategoryAllocation(index, difference);
      }

      if (categoryCubit.remainingBudget + difference < 0) {
        _showBudgetAlertDialog(context, categoryCubit);
      }
      else {
        categoryCubit.updateRemainingBudgetForProgressBar(difference);
        previousValues[index] = newAllocation;
        onUpdateCategory(categoryCubit, categoryEntity, newAllocation);
      }
    } catch (e) {
      print('Invalid number format in field $index');
    }
  }

  void _showBudgetAlertDialog(
      BuildContext context, CategoryCubit categoryCubit){
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
          ),
          child: FadeTransition(
            opacity: animation,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: AppColor.backgroundColor,
              contentPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.warning_rounded,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      "Insufficient Balance",
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textBoldColor,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      "Your remaining balance is",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: AppColor.textColor,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      "\$${monthlySalary + categoryCubit.totalAllocatedBudget}",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const Gap(24),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: AppColor.primaryColor.withOpacity(0.5),
                                ),
                              ),
                            ),
                            child: Text(
                              "Update Categories",
                              style: GoogleFonts.roboto(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Set the value in the TextField
                              double newValue = monthlySalary + categoryCubit.totalAllocatedBudget;
                              controller.text = newValue.toStringAsFixed(2);

                              // Trigger the onChanged callback
                              _handleValueChange(newValue.toStringAsFixed(2), categoryCubit, context);

                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              "Set \$${monthlySalary + categoryCubit.totalAllocatedBudget}",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}