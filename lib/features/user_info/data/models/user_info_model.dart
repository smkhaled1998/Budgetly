import '../../domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    super.userId,
     super.userName,
    super.userImg,
    required super.monthlyBudget,
    super.currency,
    super.spentAmount,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        userId: json["userId"],
        monthlyBudget: json["monthlyBudget"],
        currency: json["currency"],
        spentAmount: json["spentAmount"],
        userImg: json["userImg"],
        userName: json["userName"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": userName,
      "userImg": userImg,
      "monthlyBudget": monthlyBudget,
      "spentAmount": spentAmount,
      "currency": currency,
      "userId": userId,
    };
  }
}
