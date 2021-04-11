import 'package:flutter/material.dart';
import 'package:moniestracker/database.dart';

class ExpenseCanvas extends StatefulWidget {
  const ExpenseCanvas({Key? key}) : super(key: key);
  @override
  _ExpenseCanvasState createState() => _ExpenseCanvasState();
}

class _ExpenseCanvasState extends State<ExpenseCanvas> {
  List<Expense> _rows = [];

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _loadData() async {
    List<Expense> _tempRows = await expense();
    setState(() {
      _rows = _tempRows;
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => FullScreenDialog(),
              fullscreenDialog: true,
            ),
          );
        },
        label: Text('Add'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DataTable(
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Amount')),
              DataColumn(label: Text('Category'))
            ],
            rows: buildRows(_rows),
            showCheckboxColumn: false,
          ),
        ],
      ),
    );
  }
}

List<DataRow> buildRows(_rows) {
  List<DataRow> _tempRow = [];
  _rows.asMap().forEach((index, value) => {
        _tempRow.add(DataRow.byIndex(
          index: index,
          selected: false,
          onSelectChanged: (value) {
            print('selected');
          },
          cells: [
            DataCell(Text(value.date)),
            DataCell(Text(value.amount.toString())),
            DataCell(Text(value.category))
          ],
        ))
      });
  return _tempRow;
}

class FullScreenDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[800],
        title: Text('New Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputDatePickerFormField(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now(),
            ),
            TextFormField(
              initialValue: 'Input text',
              maxLength: 20,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_view_day),
                labelText: 'Label text',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6200EE)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
