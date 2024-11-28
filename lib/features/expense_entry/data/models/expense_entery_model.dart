import 'package:budget_buddy/features/expense_entry/domain/entities/expense_entry_entity.dart';

class ExpenseEntryModel extends ExpenseEntryEntity {
  ExpenseEntryModel({
    required super.categoryId,
    required super.amount,
    required super.date,
    super.expenseEntryId,
    super.note,
  });

  factory ExpenseEntryModel.fromJson(Map<String, dynamic> json) {
    return ExpenseEntryModel(
      categoryId: json['categoryId'],
      amount: json['amount'],
      date: DateTime.parse(json['date']), // تأكد من تحويل التاريخ إلى كائن DateTime
      expenseEntryId: json['expenseEntryId'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId, // تعديل المفتاح الفارغ
      'amount': amount,
      'date': date.toIso8601String(), // تأكد من تحويل التاريخ إلى صيغة مناسبة
      'expenseEntryId': expenseEntryId,
      'note': note,
    };
  }
}
