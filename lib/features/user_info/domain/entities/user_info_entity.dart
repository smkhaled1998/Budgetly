
abstract class UserInfoEntity{
  final int? userId;
  final String userName;
  final String? userImg;
  final String monthlyBudget;
  final String currency;
  final String spentAmount;

  UserInfoEntity({
     this.userId,
    required this.monthlyBudget,
     this.currency="",
     this.spentAmount="",
     this.userImg,
    required this.userName});

}