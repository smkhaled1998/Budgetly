import 'package:budget_buddy/core/domain/entities/category_management_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../expense_entry/presentation/cubit/expense_entry_states.dart';
import '../cubit/transaction_cubit.dart';

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

    return BlocProvider(
      create: (context)=>TransactionCubit(),
      child: BlocBuilder<TransactionCubit, TransactionStates>(
        builder: (context, state) {
          final cubit = TransactionCubit.get(context);

          return Scaffold(
            appBar: AppBar(title: Text(categoryManagementEntity.name!)),
            body: Column(
              children: [
                _buildHeader(context, percentSpent, cubit.showPieChart),
                _buildSubcategoriesList(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, double percentSpent, bool showPieChart) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: percentSpent,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          percentSpent > 0.9 ? Colors.red : Colors.blueAccent,
                        ),
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        categoryManagementEntity.icon!,
                        width: 32,
                        height: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categoryManagementEntity.name!,
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "\$${categoryManagementEntity.storedSpentAmount.toStringAsFixed(0)} / \$${categoryManagementEntity.allocatedAmount!.toStringAsFixed(0)}",
                        style: GoogleFonts.roboto(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, color: Colors.grey),
                ),
                InkWell(
                  onTap: () => TransactionCubit.get(context).togglePieChart(),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.pie_chart, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (showPieChart)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 180,
                  child: Center(child: Text("Pie Chart Here")),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubcategoriesList() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            width: double.infinity,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SUBCATEGORIES",
                  style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.settings, color: Colors.grey),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Container(height: 2, color: Colors.grey),
              padding: const EdgeInsets.only(top: 8, bottom: 80),
              itemCount: subCategories.length,
              itemBuilder: (context, index) {
                final subCat = subCategories[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: subCat.color.withOpacity(0.2),
                    child: Icon(subCat.icon, color: subCat.color),
                  ),
                  title: Text(
                    subCat.name,
                    style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
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
