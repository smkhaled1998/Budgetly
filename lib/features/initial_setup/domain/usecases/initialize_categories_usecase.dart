//
// import 'package:dartz/dartz.dart';
//
// import '../../../../core/error/failures.dart';
// import '../entities/transaction_entity.dart';
// import '../repositories/transaction_repository.dart';
//
// class InitializeCategoriesUseCase{
//   final TransactionRepository categoryRepository;
//
//   InitializeCategoriesUseCase({required this.categoryRepository});
//
//   Future<Either<Failure, Unit>> call(List<TransactionEntity> categories) async {
//     return await categoryRepository.setCategoriesData(categories: categories);
//   }
// }