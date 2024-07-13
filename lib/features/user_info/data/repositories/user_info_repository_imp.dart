import 'package:budget_buddy/features/user_info/data/models/user_info_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_info_entity.dart';
import '../../domain/repositories/user_info_repository.dart';
import '../datasources/user_info_local_datasource.dart';

class UserInfoRepositoryImpl implements UserInfoRepository {
  final UserInfoLocalDataSource localDataSource;

  UserInfoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<UserInfoEntity>>> getUserInfo() async {
    try {
      final response = await localDataSource.getUserData('''
        SELECT * FROM `userInfo`
      ''');

      final users = response.map((data) => UserInfoModel(
        userId: data['userId'],
        userName: data['userName'],
        userImg: data['userImg'],
        monthlyBudget: data['monthlyBudget'],
        currency: data['currency'],
        spentAmount: data['spentAmount'],
      )).toList();
      return Right(users);
    } on DataRetrievalException catch (e) {
      return Left(DataRetrievalFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> insertUserInfo(UserInfoEntity user) async {
    try {
      await localDataSource.insertUserData('''
        INSERT INTO `userInfo` (
          `userName`, `userImg`, `monthlyBudget`, `currency`, `spentAmount`
        ) VALUES (
          "${user.userName}", "${user.userImg}", "${user.monthlyBudget}", "${user.currency}", "${user.spentAmount}"
        )
      ''');
      return const Right(unit);
    } on DataInsertionException catch (e) {
      return Left(DataInsertionFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserInfo(UserInfoEntity user) async {
    try {
      await localDataSource.updateUserData('''
        UPDATE `userInfo`
        SET `userName` = "${user.userName}", `userImg` = "${user.userImg}", `monthlyBudget` = "${user.monthlyBudget}", `currency` = "${user.currency}", `spentAmount` = "${user.spentAmount}"
        WHERE `userId` = ${user.userId}
      ''');
      return const Right(unit);
    } on DataUpdateException catch (e) {
      return Left(DataUpdateFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUserInfo(int userId) async {
    try {
      await localDataSource.deleteUserData('''
        DELETE FROM `userInfo`
        WHERE `userId` = $userId
      ''');
      return const Right(unit);
    } on DataDeletionException catch (e) {
      return Left(DataDeletionFailure(errorMessage: e.toString()));
    } on DatabaseInitializationException catch (e) {
      return Left(DatabaseInitializationFailure(errorMessage: e.toString()));
    } on SQLSyntaxException catch (e) {
      return Left(SQLSyntaxFailure(errorMessage: e.toString()));
    } on QueryExecutionException catch (e) {
      return Left(QueryExecutionFailure(errorMessage: e.toString()));
    }
  }
}
