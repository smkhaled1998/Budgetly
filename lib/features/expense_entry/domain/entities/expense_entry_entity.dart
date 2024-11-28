
class ExpenseEntryEntity {
  final int? expenseEntryId;
  final int categoryId;
  final double amount;
  final DateTime date;
  final String? note;

  ExpenseEntryEntity({
    this.expenseEntryId,
    required this.categoryId,
    required this.amount,
    required this.date,
    this.note,
  });
}
