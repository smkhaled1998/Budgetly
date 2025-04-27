import 'package:budget_buddy/core/data/repositories/category_repository_impl.dart';
import 'package:budget_buddy/features/category_managment/presentation/cubit/category_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constances.dart';
import '../../../../core/data/database/category_management_datasource.dart';
import '../../../../core/data/models/category_model.dart';
import '../../../../core/domain/entities/category_entity.dart';
import '../../../transaction/data/repositories/transaction_repository_imp.dart';
import '../../../transaction/domain/entities/transaction_entity.dart';
import '../../domain/usecases/delete_subcategory_data_usecase.dart';
import '../../domain/usecases/edit_subcategory_data_usecase.dart';
import '../../domain/usecases/get_subcategories_data_usecase.dart';
import '../../domain/usecases/insert_new_subcategory_usecase.dart';

class SubcategoryCubit extends Cubit<CategoryStates> {
  SubcategoryCubit() : super(CategoryManagementInitialStates());

  static SubcategoryCubit get(context) => BlocProvider.of(context);
  List<CategoryEntity> fetchedCategories = [];



}
