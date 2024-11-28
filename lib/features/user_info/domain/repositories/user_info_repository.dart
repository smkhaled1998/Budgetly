import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_info_entity.dart';

abstract class UserInfoRepository{

  Future<Either<Failure,List<UserInfoEntity>>> getUserInfo();
  Future<Either<Failure,Unit>> updateUserInfo(UserInfoEntity item);
  Future<Either<Failure,Unit>> deleteUserInfo(int userId);
  Future<Either<Failure,Unit>> insertUserInfo(UserInfoEntity item);


}