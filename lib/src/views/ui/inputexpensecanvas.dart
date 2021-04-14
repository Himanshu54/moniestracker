import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/expenseinputform.dart';

class InputExpenseCanvas extends StatefulWidget {
  @override
  _InputExpenseCanvasState createState() => _InputExpenseCanvasState();
}

class _InputExpenseCanvasState extends State<InputExpenseCanvas> {
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: EdgeInsets.only(top: 20.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             DateAndTimePicker(),
  //             CategoryPicker(),
  //             AmountInput(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ExpenseInputForm(),
      ),
    );
  }
}
