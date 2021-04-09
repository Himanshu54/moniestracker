import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ExpenseCanvas extends StatefulWidget {
  @override
  _ExpenseCanvasState createState() => _ExpenseCanvasState();
}

class _ExpenseCanvasState extends State<ExpenseCanvas> {
  List<TableRow> _rows = [];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _addRow() {
    setState(() {
      print("pressed");
    });
  }

  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString('assets/test_data.json');
  }

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    final _expenseRaw = jsonDecode(jsonString).cast<Map<String, dynamic>>();
    List<Expense> _expenseList =
        _expenseRaw.map<Expense>((json) => Expense.fromJson(json)).toList();
    setState(() {
      for (var item in _expenseList) {
        TableRow t = TableRow(children: [
          Text(item.id),
          Text(item.date),
          Text(item.amount.toString())
        ]);
        _rows.add(t);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    parseJson();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _addRow();
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
      body: Table(
        border: TableBorder.all(color: Colors.black),
        children: _rows,
      ),
    );
  }
}

class Expense {
  final String id;
  final String date;
  final int amount;

  Expense({this.id, this.amount, this.date});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      amount: json['amount'] as int,
      id: json['_id'] as String,
      date: json['date'] as String,
    );
  }
}
