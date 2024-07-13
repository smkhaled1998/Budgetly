import 'package:budget_buddy/features/explore/domain/entities/category_entity.dart';

// Define states for the Explore Cubit
abstract class ExploreStates{}

class ExploreInitialState extends ExploreStates {}

class ChangeIconState extends ExploreStates {}
class ChangeColorState extends ExploreStates {}
class DefineCalculatedValueState extends ExploreStates {}
class DefineSelectedCategoryStateName extends ExploreStates {}

class InsertNewCategoryState extends ExploreStates {}

class GetCategoryDataSuccessState extends ExploreStates {
  final List<CategoryEntity> items;

  GetCategoryDataSuccessState({required this.items});
}

class GetCategoryDataLoadingState extends ExploreStates {}
class GetCategoryDataErrorState extends ExploreStates {
  final String errorMessage;
  GetCategoryDataErrorState({required this.errorMessage});
}