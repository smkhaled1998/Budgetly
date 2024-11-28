import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import '../repositories/user_info_repository.dart';

class DeleteUserInfoUseCase {

  final UserInfoRepository userInfoRepository;
  DeleteUserInfoUseCase({required this.userInfoRepository});

  Future<Either<Failure,Unit>> call(userId)async{
    return await userInfoRepository.deleteUserInfo(userId);
  }
}