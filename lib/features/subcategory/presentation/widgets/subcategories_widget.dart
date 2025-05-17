import 'package:budget_buddy/features/subcategory/presentation/cubit/subcategory_cubit.dart';
import 'package:budget_buddy/features/subcategory/presentation/cubit/subcategory_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constances.dart';
import '../../../../core/domain/entities/sub_category-entity.dart';
import '../../../../core/themes/app_color.dart';



class SubcategoriesWidget extends StatelessWidget {
  final bool isEditMode;
  final Color categoryColor;
  final Function(SubcategoryEntity, int) onEditSubcategory;
  final VoidCallback onToggleEditMode;
  final Function(SubcategoryEntity) onSubcategoryTap;

  const SubcategoriesWidget({
    Key? key,
    required this.isEditMode,
    required this.categoryColor,
    required this.onEditSubcategory,
    required this.onToggleEditMode,
    required this.onSubcategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SubcategoryCubit>(
      create: (BuildContext context)=>SubcategoryCubit(),
      child: Column(
        children: [
          _buildSubcategoriesHeader(context),
          Expanded(
            child: _buildSubcategoriesList(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcategoriesHeader(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      width: double.infinity,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "SUBCATEGORIES",
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColor.textPrimary,
            ),
          ),
          IconButton(
            icon: Icon(
              isEditMode ? Icons.close : Icons.settings,
              color: Colors.blueGrey[700],
              size: 20,
            ),
            onPressed: onToggleEditMode,
            tooltip: isEditMode ? "Exit Settings" : "Settings",
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcategoriesList(BuildContext context) {
    return BlocBuilder<SubcategoryCubit,SubcategoryStates>(
      builder: (context,state) {
        SubcategoryCubit subcategoryCubit=SubcategoryCubit.get(context);
        final fetchedSubcategories=subcategoryCubit.fetchedSubcategories;
        return Container(
          color: Colors.white,
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: fetchedSubcategories.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.grey[200],
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final subcategoryItem = fetchedSubcategories[index];
              return _buildSubcategoryItem(context, subcategoryItem, index);
            },
          ),
        );
      }
    );
  }

  Widget _buildSubcategoryItem(BuildContext context,SubcategoryEntity subcategoryItem, int index) {
    return InkWell(
      onTap: () {
        if (isEditMode) {
          onEditSubcategory(subcategoryItem, index);
        } else {
          onSubcategoryTap(subcategoryItem);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Subcategory Icon with Background
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: parseColorFromString(subcategoryItem.subcategoryColor!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(subcategoryItem.subcategoryIcon! as IconData?, color: parseColorFromString(subcategoryItem.subcategoryColor!), size: 24),
            ),
            const SizedBox(width: 16),
            // Subcategory Name
            Expanded(
              child: Text(
                subcategoryItem.subcategoryName!,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Edit Icon (Only in Edit Mode)
            if (isEditMode)
              Tooltip(
                message: "Edit",
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}