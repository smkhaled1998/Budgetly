
abstract class UserInfoEntity{
  final int? userId;
  final String userName;
  final String? userImg;
  final String currency;
  final String monthlySalary;
  final String spentAmount;

  UserInfoEntity({
     this.userId,
    required this.monthlySalary,
     this.currency="",
     this.spentAmount="",
     this.userImg,
     this.userName="There"});
}