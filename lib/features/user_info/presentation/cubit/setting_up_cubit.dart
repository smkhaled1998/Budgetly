
import 'package:budget_buddy/core/constances.dart';
import 'package:budget_buddy/features/user_info/data/datasources/user_info_datasource.dart';
import 'package:budget_buddy/features/user_info/data/repositories/user_info_repository_imp.dart';
import 'package:budget_buddy/features/user_info/domain/entities/user_info_entity.dart';
import 'package:budget_buddy/features/user_info/domain/usecases/insert_user_info_usecase.dart';
import 'package:budget_buddy/features/user_info/presentation/cubit/setting_up_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exceptions.dart';

class SettingCubit extends Cubit<SettingStates> {
  SettingCubit() : super(SettingInitialState());

  static SettingCubit get(context) => BlocProvider.of(context);
  int monthlySalary=0;

  Future<void> insertUserInfo(UserInfoEntity userInfo) async{
    final useCase= InsertUserInfoUseCase(
            userInfoRepository: UserInfoRepositoryImpl(
                localDataSource: UserInfoDataSource()));
        final response= await useCase.call(userInfo);

    response.fold(
          (failure) {
            print('Error occurred: ${failure.message}');
            if (failure is DataInsertionException) {
              print('Detailed error: ${failure.toString()}');
            }      },
          (_) {
        print('Category inserted successfully');
      },
    );
  }

  String? selectedCurrency;
  void selectCurrency(value){
    selectedCurrency=value;
    emit(SelectCurrencyState());
  }


}
