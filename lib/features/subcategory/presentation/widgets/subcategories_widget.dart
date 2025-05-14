import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/themes/app_color.dart';

class Subcategory {
  final String name;
  final IconData icon;
  final Color color;

  Subcategory({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class SubcategoriesWidget extends StatelessWidget {
  final List<Subcategory> subcategories;
  final bool isEditMode;
  final Color categoryColor;
  final Function(Subcategory, int) onEditSubcategory;
  final VoidCallback onToggleEditMode;
  final Function(Subcategory) onSubcategoryTap;

  const SubcategoriesWidget({
    Key? key,
    required this.subcategories,
    required this.isEditMode,
    required this.categoryColor,
    required this.onEditSubcategory,
    required this.onToggleEditMode,
    required this.onSubcategoryTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSubcategoriesHeader(context),
        Expanded(
          child: _buildSubcategoriesList(context),
        ),
      ],
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
    return Container(
      color: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: subcategories.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[200],
          height: 1,
          indent: 16,
          endIndent: 16,
        ),
        itemBuilder: (context, index) {
          final subCat = subcategories[index];
          return _buildSubcategoryItem(context, subCat, index);
        },
      ),
    );
  }

  Widget _buildSubcategoryItem(BuildContext context, Subcategory subCat, int index) {
    return InkWell(
      onTap: () {
        if (isEditMode) {
          onEditSubcategory(subCat, index);
        } else {
          onSubcategoryTap(subCat);
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
                color: subCat.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(subCat.icon, color: subCat.color, size: 24),
            ),
            const SizedBox(width: 16),
            // Subcategory Name
            Expanded(
              child: Text(
                subCat.name,
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