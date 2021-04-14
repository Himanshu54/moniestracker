import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountInput extends StatefulWidget {
  @override
  _AmountInputState createState() => _AmountInputState();
}

class _AmountInputState extends State<AmountInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Amount',
        ),
      ),
    );
  }
}
