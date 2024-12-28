import 'package:budget_buddy/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../entities/user_info_entity.dart';
import '../repositories/user_info_repository.dart';

class GetUserInfoUseCase{

  final UserInfoRepository userInfoRepository;

  GetUserInfoUseCase({required this.userInfoRepository});

  Future<Either<Failure, List<UserInfoEntity>>> call()async{

    return await userInfoRepository.getUserInfo();
  }
}