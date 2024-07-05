import 'package:budget_buddy/features/explore/domain/entities/category_entity.dart';

abstract class ExploreStates{}

class ExploreInitialState extends ExploreStates {}

class InsertNewCategoryState extends ExploreStates {}

class GetCategoryDataSuccessState extends ExploreStates {
  final List<CategoryEntity> items;

  GetCategoryDataSuccessState({required this.items});
}

class GetCategoryDataErrorState extends ExploreStates {
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}

