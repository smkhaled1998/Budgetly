import 'package:budget_buddy/core/database_helper.dart';
import 'package:budget_buddy/features/explore/data/datasources/category_local_datasource.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  CategoryLocalDataSource localDataSource=CategoryLocalDataSource();
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
