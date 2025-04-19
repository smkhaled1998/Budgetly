
class TransactionEntity {
  final int? transactionId;
  final int categoryId;
  final double amount;
  final DateTime date;
  final String? note;

  TransactionEntity({
    this.transactionId,
    required this.categoryId,
    required this.amount,
    required this.date,
    this.note,
  });
}
