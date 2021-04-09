import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: ExpenseCanvas(),
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('All my monies'),
          backgroundColor: Colors.blueGrey[900],
        ),
      ),
    ),
  );
}

class ExpenseCanvas extends StatefulWidget {
  @override
  _ExpenseCanvasState createState() => _ExpenseCanvasState();
}

class _ExpenseCanvasState extends State<ExpenseCanvas> {
  void _addRow() {
    setState(() {
      print("pressed");
      _rows.add(
        TableRow(
          children: [
            Column(
              children: [Text('Hello')],
            ),
            Column(
              children: [Text('Hello')],
            ),
            Column(
              children: [Text('Hello')],
            )
          ],
        ),
      );
    });
  }

  var _rows = [
    TableRow(
      children: [
        Column(
          children: [Text('Hello')],
        ),
        Column(
          children: [Text('Hello')],
        ),
        Column(
          children: [Text('Hello')],
        )
      ],
    ),
    TableRow(
      children: [
        Column(
          children: [Text('Hello')],
        ),
        Column(
          children: [Text('Hello')],
        ),
        Column(
          children: [Text('Hello')],
        )
      ],
    ),
    TableRow(
      children: [
        Column(
          children: [Text('Hello')],
        ),
        Column(
          children: [Text('Hello')],
        ),
        Column(
          children: [Text('Hello')],
        )
      ],
    )
  ];
  @override
  Widget build(BuildContext context) {
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
