import '../../domain/entities/user_info_entity.dart';

class UserInfoModel extends UserInfoEntity {
  UserInfoModel({
    super.userId,
     super.userName,
    super.userImg,
    required super.monthlySalary,
    super.currency,
    super.spentAmount,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
        userId: json["userId"],
        monthlySalary: json["monthlySalary"],
        currency: json["currency"],
        spentAmount: json["spentAmount"],
        userImg: json["userImg"],
        userName: json["userName"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": userName,
      "userImg": userImg,
      "monthlySalary": monthlySalary,
      "spentAmount": spentAmount,
      "currency": currency,
      "userId": userId,
    };
  }
}
