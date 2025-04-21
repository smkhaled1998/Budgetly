import 'dart:ui';
import 'package:budget_buddy/core/domain/entities/category_management_entity.dart';
import 'package:budget_buddy/features/category_managment/presentation/screens/explore_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constances.dart';
import '../../../../core/themes/app_color.dart';
import '../../../expense_entry/presentation/cubit/expense_entry_states.dart';
import '../cubit/transaction_cubit.dart';
import '../cubit/transaction_states.dart';

class NewExpenseEntryScreen extends StatelessWidget {
  final CategoryManagementEntity categoryManagementEntity;
  final List<Subcategory> subCategories;

  const NewExpenseEntryScreen({
    super.key,
    required this.subCategories,
    required this.categoryManagementEntity,
  });

  @override
  Widget build(BuildContext context) {
    final percentSpent = categoryManagementEntity.storedSpentAmount / categoryManagementEntity.allocatedAmount!;
    final Color categoryColor = parseColorFromString(categoryManagementEntity.color ?? '#1E88E5');
    final double remainingAmount = categoryManagementEntity.allocatedAmount! - categoryManagementEntity.storedSpentAmount;

    return BlocProvider(
      create: (context) => TransactionCubit(),
      child: BlocBuilder<TransactionCubit, TransactionStates>(
        builder: (context, state) {
          final cubit = TransactionCubit.get(context);
          final bool isEditMode = state is TransactionEditModeState;

          return Scaffold(
            appBar: AppBar(
               leading: IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ExploreScreen()));
               }, icon: Icon(Icons.arrow_back_ios_new_outlined,color: Colors.white,)),
              title: Text(
                categoryManagementEntity.name!,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              elevation: 0,
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.black,
            ),
            backgroundColor: Colors.white,
            body: Column(
              children: [
                _buildHeader(context, percentSpent, cubit.showPieChart, categoryColor, remainingAmount),
                _buildSubcategoriesHeader(context, isEditMode),
                _buildSubcategoriesList(context, isEditMode, categoryColor),
              ],
            ),
            floatingActionButton: isEditMode ? FloatingActionButton(
              onPressed: () => _showAddSubcategoryDialog(cubit, context, categoryColor),
              backgroundColor: categoryColor,
              child: const Icon(Icons.add),
            ) : null,
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double percentSpent, bool showPieChart, Color categoryColor, double remainingAmount) {
    final double progressValue = percentSpent.clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row: Icon and Category name
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey.withOpacity(0.15),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progressValue >= 1 ? Colors.red : categoryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: categoryColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      categoryManagementEntity.icon!,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryManagementEntity.name!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: remainingAmount < 0
                                ? Colors.red.withOpacity(0.15)
                                : categoryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  Text(
                            "\$${remainingAmount.toStringAsFixed(0)} ${remainingAmount < 0 ? 'over' : 'left'}",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => TransactionCubit.get(context).togglePieChart(),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.pie_chart,
                              color: categoryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            // Edit category action
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Optional pie chart
          if (showPieChart)
            Container(
              height: 180,
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  "Pie Chart Here",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSubcategoriesHeader(BuildContext context, bool isEditMode) {
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
              color: AppColor.textColor,
            ),
          ),
          IconButton(
            icon: Icon(
              isEditMode ? Icons.close : Icons.settings,
              color: Colors.blueGrey[700],
              size: 20,
            ),
            onPressed: () {
              // Toggle edit mode
              final cubit = TransactionCubit.get(context);
              if (isEditMode) {
                cubit.emit(TransactionInitialState());
              } else {
                cubit.emit(TransactionEditModeState());
              }
            },
            tooltip: isEditMode ? "Exit Settings" : "Settings",
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
///****************
  Widget _buildSubcategoriesList(BuildContext context, bool isEditMode, Color categoryColor) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: isEditMode ? _buildEditModeList(context, categoryColor) : _buildViewModeList(context, categoryColor),
      ),
    );
  }

  Widget _buildViewModeList(BuildContext context, Color categoryColor) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: subCategories.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[200],
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final subCat = subCategories[index];
        return _buildSubcategoryItem(context, subCat, false, index, categoryColor);
      },
    );
  }

  Widget _buildEditModeList(BuildContext context, Color categoryColor) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: subCategories.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.grey[200],
        height: 1,
        indent: 16,
        endIndent: 16,
      ),
      itemBuilder: (context, index) {
        final subCat = subCategories[index];
        return _buildSubcategoryItem(context, subCat, true, index, categoryColor);
      },
    );
  }

  Widget _buildSubcategoryItem(BuildContext context, Subcategory subCat, bool isEditMode, int index, Color categoryColor) {
    return InkWell(
      onTap: () {
        if (isEditMode) {
          _showEditSubcategoryDialog(TransactionCubit.get(context), subCat, index, context, categoryColor);
        } else {
          // Navigate to subcategory details or add transaction
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
  ///****************
  void _showEditSubcategoryDialog(TransactionCubit cubit, Subcategory subCat, int index, context, Color categoryColor) {
    final TextEditingController nameController = TextEditingController(text: subCat.name);
    Color selectedColor = subCat.color;
    IconData selectedIcon = subCat.icon;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Edit Subcategory",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Select Color", style: GoogleFonts.roboto(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    _buildColorPicker(selectedColor, (color) {
                      setState(() {
                        selectedColor = color;
                      });
                    }),
                    const SizedBox(height: 20),
                    Text("Select Icon", style: GoogleFonts.roboto(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    _buildIconPicker(selectedIcon, selectedColor, (icon) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    }),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: categoryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // Here you would update the subcategory in your data model
                    Navigator.pop(context);
                    // cubit.updateSubcategory(index, nameController.text, selectedColor, selectedIcon);
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddSubcategoryDialog(TransactionCubit cubit, context, Color categoryColor) {
    final TextEditingController nameController = TextEditingController();
    Color selectedColor = categoryColor;
    IconData selectedIcon = Icons.category;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                "Add New Subcategory",
                style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Select Color", style: GoogleFonts.roboto(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    _buildColorPicker(selectedColor, (color) {
                      setState(() {
                        selectedColor = color;
                      });
                    }),
                    const SizedBox(height: 20),
                    Text("Select Icon", style: GoogleFonts.roboto(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 10),
                    _buildIconPicker(selectedIcon, selectedColor, (icon) {
                      setState(() {
                        selectedIcon = icon;
                      });
                    }),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: categoryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (nameController.text.trim().isNotEmpty) {
                      // Here you would add the subcategory to your data model
                      Navigator.pop(context);
                      // cubit.addSubcategory(nameController.text, selectedColor, selectedIcon);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Color picker widget
  Widget _buildColorPicker(Color currentColor, Function(Color) onColorSelected) {
    final List<Color> colorOptions = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: colorOptions.map((color) {
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: currentColor == color ? Colors.white : Colors.transparent,
                width: 2,
              ),
              boxShadow: currentColor == color
                  ? [BoxShadow(color: color.withOpacity(0.6), blurRadius: 8, spreadRadius: 2)]
                  : null,
            ),
            child: currentColor == color
                ? const Icon(Icons.check, color: Colors.white, size: 20)
                : null,
          ),
        );
      }).toList(),
    );
  }

  // Icon picker widget
  Widget _buildIconPicker(IconData currentIcon, Color currentColor, Function(IconData) onIconSelected) {
    final List<IconData> iconOptions = [
      Icons.shopping_bag,
      Icons.shopping_cart,
      Icons.restaurant,
      Icons.local_cafe,
      Icons.directions_car,
      Icons.directions_bus,
      Icons.local_taxi,
      Icons.local_hospital,
      Icons.school,
      Icons.book,
      Icons.movie,
      Icons.sports_esports,
      Icons.fitness_center,
      Icons.sports,
      Icons.home,
      Icons.house,
      Icons.smartphone,
      Icons.computer,
      Icons.tv,
      Icons.card_giftcard,
      Icons.airplanemode_active,
      Icons.hotel,
      Icons.beach_access,
      Icons.category,
    ];

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: iconOptions.map((icon) {
        final isSelected = currentIcon == icon;
        return GestureDetector(
          onTap: () => onIconSelected(icon),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isSelected ? currentColor.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? currentColor : Colors.transparent,
                width: 2,
              ),
            ),
            child: Icon(
              icon,
              color: isSelected ? currentColor : Colors.grey[600],
              size: 24,
            ),
          ),
        );
      }).toList(),
    );
  }
}

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