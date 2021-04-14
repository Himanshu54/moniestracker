import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/expensetabledata.dart';

class ExpenseCanvas extends StatefulWidget {
  const ExpenseCanvas({Key key}) : super(key: key);
  @override
  _ExpenseCanvasState createState() => _ExpenseCanvasState();
}

class _ExpenseCanvasState extends State<ExpenseCanvas> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ExpenseTableDataRows(),
    );
  }
}
