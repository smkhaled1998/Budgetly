import 'package:budget_buddy/features/explore/data/datasources/budget_local_datasource.dart';
import 'package:budget_buddy/features/explore/data/repositories/category_repository_imp.dart';
import 'package:budget_buddy/features/explore/domain/entities/category_entity.dart';
import 'package:budget_buddy/features/explore/domain/usecases/get_category_data_usecase.dart';
import 'package:budget_buddy/features/explore/domain/usecases/insert_category_data_usecase.dart';
import 'package:budget_buddy/features/explore/presentation/cubit/explore_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreCubit extends Cubit<ExploreStates> {
  ExploreCubit() : super(ExploreInitialState());

  static ExploreCubit get(context) => BlocProvider.of(context);
  Future<void> insertCategoryData(CategoryEntity item) async {
    InsertCategoryDataUseCase(
            budgetRepository: CategoryRepositoryImpl(
                localDataSource: CategoryLocalDataSource()))
        .call(item);
  }

  getCategoryData() async {
    final response = await GetCategoryDataUseCase(
            categoryRepository: CategoryRepositoryImpl(
                localDataSource: CategoryLocalDataSource()))
        .call();

    response.fold(
            (failure) => emit(GetCategoryDataErrorState(errorMessage: failure.message)),  
            (data) => emit(GetCategoryDataSuccessState(items: data)));
         print("=====================Alhamdulillah===============================");

  }
}
