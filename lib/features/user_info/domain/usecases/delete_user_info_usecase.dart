import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import '../repositories/user_info_repository.dart';

class DeleteUserInfoUseCase {

  final UserInfoRepository userInfoRepository;
  final String categoryId;
  DeleteUserInfoUseCase({required this.userInfoRepository,required this.categoryId});

  Future<Either<Failure,Unit>> call(categoryId)async{
    return await userInfoRepository.deleteUserInfo(categoryId);
  }
}