
import '../../domain/entities/transaction_entity.dart';

class TransactionModel extends TransactionEntity {
  TransactionModel({
    required super.categoryId,
    required super.amount,
    required super.date,
    super.transactionId,
    super.note,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      categoryId: json['categoryId'],
      amount: json['amount'],
      date: DateTime.parse(json['date']), // تأكد من تحويل التاريخ إلى كائن DateTime
      transactionId: json['transactionId'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId, // تعديل المفتاح الفارغ
      'amount': amount,
      'date': date.toIso8601String(), // تأكد من تحويل التاريخ إلى صيغة مناسبة
      'transactionId': transactionId,
      'note': note,
    };
  }
}
