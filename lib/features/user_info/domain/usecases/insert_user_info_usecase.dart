import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/user_info_entity.dart';
import '../repositories/user_info_repository.dart';

class InsertUserInfoUseCase {
  final UserInfoRepository userInfoRepository;

  InsertUserInfoUseCase({required this.userInfoRepository});

  Future<Either<Failure, Unit>> call(UserInfoEntity user) async {
    return await userInfoRepository.insertUserInfo( user);
  }
}
