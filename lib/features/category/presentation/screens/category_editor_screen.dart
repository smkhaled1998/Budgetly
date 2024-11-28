import 'package:budget_buddy/features/category/data/models/category_model.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/themes/app_color.dart';
import '../../../../core/constances.dart';
import '../../domain/entities/category_entity.dart';
import '../cubit/category_states.dart';
import '../widgets/category_manager/color_icon_picker_dialog.dart';
import '../widgets/category_manager/editable_category_card.dart';

class CategoryEditorScreen extends StatelessWidget {
  CategoryEditorScreen({Key? key, required this.item}) : super(key: key);
  final CategoryEntity item;



  double padding=16;
  TextEditingController nameController = TextEditingController();
  TextEditingController budgetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CategoryCubit categoryCubit=BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "Edit Category",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton.icon(
            onPressed: () {

              saveUpdatedCategory(categoryCubit);

            },
            icon: const Icon(Icons.check, color: Colors.white),
            label: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<CategoryCubit,CategoryStates>(
          builder: (context,state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                EditableCategoryCard(
                  item: item,
                  padding: padding,
                  budgetController:budgetController ,
                  isEditing: categoryCubit.isCategoryEditMode,
                  nameController: nameController,
                  onEditToggle: (){
                    categoryCubit.toggleCategoryEditMode();
                    categoryCubit.categoryName=nameController.text;
                    categoryCubit.allocatedAmount = double.tryParse(budgetController.text) ?? item.allocatedAmount;
                  },
                  selectedColor: item.color!,
                  selectedIcon: item.icon!,
                ),
                categoryCubit.isCategoryEditMode ?Container():Container(),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: padding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionButton(
                        icon: Icons.color_lens,
                        label: "Change Color",
                        onPressed: (){
                          return ColorPickerDialog.show(context,categoryCubit);
                        },
                      ),
                      const SizedBox(width: 16),
                      _buildActionButton(
                        icon: Icons.image,
                        label: "Change Icon",
                        onPressed: (){
                          return IconPickerDialog.show(context,categoryCubit);
                        },                      ),
                    ],
                  ),
                ),
                const Gap(15),
                categoryCubit.isCategoryEditMode?Container():  const Divider(
                  height: 5,
                ),
                categoryCubit.isCategoryEditMode?Container():   _buildCategoryVisibilityWidget(),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: padding, vertical: 5),
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Text(
                    "SUBCATEGORIES",
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textBoldColor,
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: Icon(icon, size: 20, color: AppColor.primaryColor),
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: AppColor.primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCategoryVisibilityWidget(){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,


      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Show Category",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch.adaptive(
              value: true,
              activeColor: AppColor.primaryColor,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }

  void saveUpdatedCategory(CategoryCubit categoryCubit){
    categoryCubit.isCategoryEditMode = false;
    CategoryEntity updatedItem=CategoryModel(
      name:categoryCubit.categoryName ,
      allocatedAmount: categoryCubit.allocatedAmount,
      color: categoryCubit.categoryColor.toString(),
      icon: categoryCubit.categoryIcon,

    );
    categoryCubit.updateCategoryData(updatedItem, item.categoryId!);
  }
}