import 'package:budget_buddy/core/database_helper.dart';
import 'package:flutter/material.dart';

import '../../../../category/data/datasources/category_datasource.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  CategoryDataSource localDataSource=CategoryDataSource();
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
