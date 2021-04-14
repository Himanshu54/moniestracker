import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/models.dart';

class ExpenseInputForm extends StatefulWidget {
  @override
  ExpenseInputFormState createState() {
    return ExpenseInputFormState();
  }
}

class ExpenseInputFormState extends State<ExpenseInputForm> {
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      child: Column(
        children: <Widget>[
          ExpenseInputButton('Label'),
          ExpenseInputButton('Amount'),
          ExpenseInputButton('Category'),
          ExpenseInputButton('Date'),
          ExpenseInputButton('Account'),
          ElevatedButton(
            onPressed: () {},
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class ExpenseInputButton extends StatefulWidget {
  ExpenseInputButton(this.title);
  final String title;

  @override
  _ExpenseInputButtonState createState() => _ExpenseInputButtonState();
}

class _ExpenseInputButtonState extends State<ExpenseInputButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      child: Row(
        children: [
          Expanded(
            child: Text(widget.title),
            flex: 2,
          ),
          Expanded(
            flex: 7,
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
