
abstract class UserInfoEntity{
  final int? userId;
  final String userName;
  final String? userImg;
  final String currency;
  final String monthlyBudget;
  final String spentAmount;

  UserInfoEntity({
     this.userId,
    required this.monthlyBudget,
     this.currency="",
     this.spentAmount="",
     this.userImg,
     this.userName="There"});
}