import 'package:moniestracker/src/data/database.dart';

class Expense {
  final int id;
  Category category;
  double amount;
  DateTime date;
  SubCategory subcategory;
  Account account;
  String label;

  factory Expense.fromObject(Expense e) {
    return Expense(
        e.id, e.category, e.amount, e.date, e.subcategory, e.account, e.label);
  }
  Expense(this.id, this.category, this.amount, this.date, this.subcategory,
      this.account, this.label);

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      't_id': id,
      'ct_id': category.id,
      't_amount': amount,
      't_date': date.toString(),
      'sct_id': subcategory.id,
      'ac_id': account.id,
      't_label': label
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        json['t_id'] as int,
        Category(
          json['ct_id'],
          json['ct_category'],
        ),
        json['t_amount'] as double,
        DateTime.parse(json['t_date']),
        SubCategory(
          json['sct_id'],
          json['sct_subcategory'],
          json['ct_id'],
        ),
        Account(json['ac_id'], json['ac_name']),
        json['t_label'] as String);
  }
}

class Category {
  final int id;
  String category;

  Category(this.id, this.category);

  List<SubCategory> subcategories() {
    return getSubcategories(id.toString()) as List<SubCategory>;
  }

  factory Category.fromObj(Category s) {
    return Category(s.id, s.category);
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['ct_id'] as int,
      json['ct_category'] as String,
    );
  }
}

class SubCategory {
  final int id;
  final int ctId;
  String subcategory;

  SubCategory(this.id, this.subcategory, this.ctId);

  factory SubCategory.fromObj(SubCategory s) {
    return SubCategory(s.id, s.subcategory, s.ctId);
  }

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      json['sct_id'] as int,
      json['sct_subcategory'] as String,
      json['ct_id'] as int,
    );
  }
}

class Account {
  final int id;
  final String name;

  Account(this.id, this.name);

  balance(String id) {}

  factory Account.fromObj(Account ac) {
    return Account(ac.id, ac.name);
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(json['ac_id'], json['ac_name']);
  }
}
