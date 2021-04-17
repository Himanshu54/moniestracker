import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/models.dart';
import 'package:moniestracker/src/views/ui/expenseinputform.dart';

class InputExpenseCanvas extends StatefulWidget {
  static const routeName = '/input_expense';

  @override
  _InputExpenseCanvasState createState() => _InputExpenseCanvasState();
}

class _InputExpenseCanvasState extends State<InputExpenseCanvas> {
  @override
  Widget build(BuildContext context) {
    final Expense expense =
        ModalRoute.of(context).settings.arguments as Expense;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('All my monies'),
      ),
      body: SingleChildScrollView(
        child: ExpenseInputForm(expense),
      ),
    );
  }
}
