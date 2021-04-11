import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/categorypicker.dart';
import 'package:moniestracker/src/views/ui/datepicker.dart';

class InputExpenseCanvas extends StatefulWidget {
  @override
  _InputExpenseCanvasState createState() => _InputExpenseCanvasState();
}

class _InputExpenseCanvasState extends State<InputExpenseCanvas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top:20.0),
        child: Column(
          children: [
            DateAndTimePicker(),
            CategoryPicker(),
          ],
        ),
      ),
    );
  }
}
