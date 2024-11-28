import 'package:budget_buddy/features/user_info/data/datasources/user_info_datasource.dart';
import 'package:budget_buddy/features/user_info/data/repositories/user_info_repository_imp.dart';
import 'package:budget_buddy/features/user_info/domain/usecases/insert_user_info_usecase.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<SettingUpStates> {
  SettingCubit() : super(SettingInitialState());

  static SettingCubit get(context) => BlocProvider.of(context);

  Future<void> insertUserInfo(user) async{
    final useCase= InsertUserInfoUseCase(
            userInfoRepository: UserInfoRepositoryImpl(
                localDataSource: UserInfoDataSource()));
        final response= await useCase.call(user);

    response.fold(
          (failure) {
        print('Error occurred: ${failure.message}');
      },
          (_) {
        print('Category inserted successfully');
      },
    );
  }
}
