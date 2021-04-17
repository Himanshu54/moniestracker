import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/expenseinputform.dart';

class InputExpenseCanvas extends StatefulWidget {
  @override
  _InputExpenseCanvasState createState() => _InputExpenseCanvasState();
}

class _InputExpenseCanvasState extends State<InputExpenseCanvas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ExpenseInputForm(),
      ),
    );
  }
}
