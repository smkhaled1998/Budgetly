import 'package:budget_buddy/core/data/database/database_helper.dart';
import 'package:budget_buddy/core/data/database/category_management_datasource.dart';
import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  CategoryManagementDataSource localDataSource=CategoryManagementDataSource();
   DatabaseHelper databaseHelper=DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(icon:const Icon(Icons.delete),onPressed: (){
        DatabaseHelper.removeDatabase();

      },),
    );
  }
}
