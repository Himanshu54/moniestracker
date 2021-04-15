class Expense {
  final int id;
  String category;
  double amount;
  DateTime date;
  String subcategory;
  String account;
  String label;

  Expense(this.id, this.category, this.amount, this.date, this.subcategory,
      this.account, this.label);

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'amount': amount,
      'date': date,
      'subcategory': subcategory,
      'account': account,
      'label': label
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        json['id'] as int,
        json['category'] as String,
        json['amount'] as double,
        DateTime.parse(json['date']),
        json['subcategory'] as String,
        json['account'] as String,
        json['label'] as String);
  }
}

class Category {
  final int id;
  String category;

  Category(this.id, this.category);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(json['ct_id'] as int, json['ct_category'] as String);
  }
}

class SubCategory {
  final int id;
  String subcategory;

  SubCategory(this.id, this.subcategory);

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
        json['sct_id'] as int, json['sct_subcategory'] as String);
  }
}
