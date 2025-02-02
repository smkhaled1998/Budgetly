import 'package:budget_buddy/features/category/domain/entities/category_entity.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_cubit.dart';
import 'package:budget_buddy/features/category/presentation/cubit/category_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../../../../../core/themes/app_color.dart';
import '../../../../../../core/constances.dart';

class EditableCategoryCard extends StatelessWidget {
  final bool isEditing;
  final String selectedColor;
  final String selectedIcon;
  final CategoryEntity item;
  final TextEditingController nameController;
  final TextEditingController budgetController;
  final VoidCallback onEditToggle;
  final double padding;

  const EditableCategoryCard({
    Key? key,
    required this.isEditing,
    required this.selectedColor,
    required this.selectedIcon,
    required this.nameController,
    required this.budgetController,
    required this.onEditToggle,
    required this.padding, required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEditing ? _buildEditingCard() : _buildDisplayCard();
  }

  Widget _buildEditingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 5),
          ),
        ],
        color: AppColor.backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: AppColor.primaryColor,
          width: 2,
        ),
      ),
      child: _buildCardContent(true),
    );
  }

  Widget _buildDisplayCard() {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: AppColor.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: _buildCardContent(false),
    );
  }

  Widget _buildCardContent(bool isEditing) {
    return BlocBuilder<CategoryCubit,CategoryStates>(
      builder: (context,state) {
        CategoryCubit categoryCubit=BlocProvider.of(context);
        return Row(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: categoryCubit.categoryColor,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  categoryCubit.categoryIcon!,
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildNameField(isEditing,categoryCubit),
                  if (isEditing) const SizedBox(height: 8),
                  _buildBudgetField(isEditing,categoryCubit),
                ],
              ),
            ),
            _buildEditButton(isEditing),
          ],
        );
      }
    );
  }

  Widget _buildNameField(bool isEditing, CategoryCubit categoryCubit) {
    if (isEditing) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: nameController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: const InputDecoration(
            hintText: "Category Name",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.edit, size: 16, color: Colors.grey),
          ),
        ),
      );
    }
    return Text(
      categoryCubit.updatedCategoryName!,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildBudgetField(bool isEditing, CategoryCubit categoryCubit) {
    if (isEditing) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: budgetController,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            hintText: "Allocated Amount",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            suffixIcon: Icon(Icons.edit, size: 16, color: Colors.grey),
          ),
        ),
      );
    }
    return Text(
      "Budget Slice is ${categoryCubit.updatedAllocatedAmount}",
      style: const TextStyle(
        color: AppColor.textLightColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildEditButton(bool isEditing) {
    return IconButton(
      onPressed: onEditToggle,
      icon: Icon(
        isEditing ? Icons.check_circle : Icons.edit,
        color: AppColor.primaryColor,
        size: isEditing ? 28 : 24,
      ),
    );
  }



}
