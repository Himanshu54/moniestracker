
class Expense {
  final int id;
  DateTime date;
  double amount;
  String category;

  Expense(this.id, this.category, this.amount, this.date) {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    this.amount = 0;
    this.category = '';
  }

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(json['id'] as int, json['category'] as String,
        json['amount'] as double, json['date'] as DateTime);
  }
}
