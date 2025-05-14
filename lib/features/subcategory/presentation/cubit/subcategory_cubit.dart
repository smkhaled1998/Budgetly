import 'package:budget_buddy/core/data/database/sub_category_datasource.dart';
import 'package:budget_buddy/core/data/models/subcategory_model.dart';
import 'package:budget_buddy/core/data/repositories/sub_categories_repository_impl.dart';
import 'package:budget_buddy/features/subcategory/presentation/cubit/subcategory_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/domain/entities/sub_category-entity.dart';
import '../../domain/usecases/delete_subcategory_data_usecase.dart';
import '../../domain/usecases/edit_subcategory_data_usecase.dart';
import '../../domain/usecases/get_subcategories_data_usecase.dart';
import '../../domain/usecases/insert_new_subcategory_usecase.dart';

class SubcategoryCubit extends Cubit<SubcategoryStates> {
  SubcategoryCubit() : super(SubcategoryManagementInitialStates());

  static SubcategoryCubit get(context) => BlocProvider.of(context);
  List<SubcategoryEntity> fetchedSubcategories = [];


  Future<void> fetchSubcategories() async {
    emit(GetSubcategoryDataLoadingState()); // حالة التحميل
    final response = await GetSubCategoriesDataUseCase(
      subcategoryRepository : SubcategoryRepositoryImpl(localDataSource: SubcategoryDataSource(),),
    ).call();

    response.fold(
          (failure) {
        print(failure.message);
        emit(GetCategoryDataErrorState(errorMessage: failure.message));
      },
          (data) {
            fetchedSubcategories = data;
        emit(GetSubcategoryDataSuccessState(subcategories: data));
      },
    );
    print("=====================Alhamdulillah===============================");
  }

  Future<void> insertNewSubcategory(SubcategoryEntity subCategory) async {
    emit(SubcategoryInsertionLoadingState());

    // أضف الفئة الجديدة مباشرة إلى القائمة بدون انتظار معالجة قاعدة البيانات
    // نقوم بوضع ID مؤقت، سيتم تعويضه بعد الإدراج في قاعدة البيانات
    final newSubcategory = SubcategoryModel(
      subcategoryName: subCategory.subcategoryName,
      subcategoryColor: subCategory.subcategoryColor,
      subcategoryIcon: subCategory.subcategoryIcon,

    );

    fetchedSubcategories.add(newSubcategory);
    emit(SubcategoryInsertedState());

    // بعد إضافة الفئة مؤقتًا، نقوم بتنفيذ عملية الإدراج في قاعدة البيانات
    final useCase = InsertSubcategoryDataUseCase(
      subcategoryRepository: SubcategoryRepositoryImpl(localDataSource: SubcategoryDataSource(),),
    );

    final result = await useCase.call(subCategory);

    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(SubcategoryInsertionErrorState(failure.message));

        // في حالة الفشل، نزيل الفئة المؤقتة من القائمة
        fetchedSubcategories.removeWhere((category) =>
        category.parentCategoryId == newSubcategory.parentCategoryId);
        emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
      },
          (_) {
        print('Category inserted successfully');
        // بعد النجاح، نقوم بتحديث القائمة بالبيانات الحقيقية من قاعدة البيانات
        fetchSubcategories();
      },
    );
  }

  Future<void> removeSubcategory(int categoryId) async {
    emit(SubcategoryDeleteLoadingState()); // حالة التحميل

    // إزالة الفئة مؤقتًا من القائمة
    int index = fetchedSubcategories.indexWhere((subcategory) => subcategory.parentCategoryId == categoryId);
    SubcategoryEntity? removedSubcategory;

    if (index != -1) {
      removedSubcategory = fetchedSubcategories.removeAt(index);
      emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
    }

    final useCase = DeleteSubcategoryDataUseCase(
      subcategoryRepository: SubcategoryRepositoryImpl(
        localDataSource: SubcategoryDataSource(),
      ),
      categoryId: categoryId,
    );

    final result = await useCase.call(categoryId);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(SubcategoryDeleteErrorState(failure.message));

        // استعادة الفئة المحذوفة إذا فشلت عملية الحذف
        if (removedSubcategory != null) {
          fetchedSubcategories.insert(index, removedSubcategory);
          emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
        }
      },
          (_) {
        print('Category deleted successfully');
        emit(SubcategoryDeletedState());
        // تأكيد الحذف، لا نحتاج لتحديث القائمة مرة أخرى
      },
    );
  }

  Future<void> updateSubcategoryData(
      SubcategoryEntity item, int categoryId) async {
    emit(SubcategoryUpdateLoadingState()); // حالة التحميل

    // تحديث الفئة مؤقتًا في القائمة
    int index = fetchedSubcategories.indexWhere((category) => category.parentCategoryId == categoryId);
    SubcategoryEntity? oldCategory;

    if (index != -1) {
      oldCategory = fetchedSubcategories[index];
      fetchedSubcategories[index] = item;
      emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
    }

    final useCase = UpdateSubcategoryDataUseCase(
      subcategoryRepository: SubcategoryRepositoryImpl(
        localDataSource: SubcategoryDataSource(),
      ),
    );

    final result = await useCase.call(item, categoryId);
    result.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
        emit(SubcategoryUpdateErrorState(failure.message));

        // استعادة الفئة القديمة إذا فشل التحديث
        if (oldCategory != null && index != -1) {
          fetchedSubcategories[index] = oldCategory;
          emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
        }
      },
          (_) {
        print('Category updated successfully');
        emit(SubcategoryUpdatedState());
        // تم التحديث بنجاح، لا نحتاج لتحديث القائمة مرة أخرى
      },
    );
  }

  String? _subcategoryIcon;
  String get subcategoryIcon => _subcategoryIcon ?? Icons.category.codePoint.toString();
  void updateSubcategoryIcon(String updatedCategoryIcon) {
    _subcategoryIcon = updatedCategoryIcon;
    emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
  }
  Color subcategoryColor = Colors.blueAccent;

  void updateSubcategoryColor(Color color) {
    subcategoryColor = color;
    emit(ChangeSubcategoryAppearanceState(items: fetchedSubcategories));
  }


}
