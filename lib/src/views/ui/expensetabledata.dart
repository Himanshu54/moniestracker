import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';

class ExpenseTableDataRows extends StatefulWidget {
  @override
  _ExpenseTableDataRowsState createState() => _ExpenseTableDataRowsState();
}

class _ExpenseTableDataRowsState extends State<ExpenseTableDataRows> {
  Future<List<Expense>> _expense = expense();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Expense>>(
      future: _expense,
      builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
        if (!snapshot.hasData) {
          // while data is loading:
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          // data loaded:
          //
          final value = snapshot.data;
          List<DataRow> _tempRow = [];
          value.asMap().forEach((index, value) => {
                _tempRow.add(DataRow.byIndex(
                  color: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    // All rows will have the same selected color.
                    if (states.contains(MaterialState.selected))
                      return Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.08);
                    // Even rows will have a grey color.
                    if (index % 2 == 0) return Colors.grey.withOpacity(0.3);
                    return null; // Use default value for other states and odd rows.
                  }),
                  index: index,
                  selected: false,
                  onSelectChanged: (value) {
                    print('selected');
                  },
                  cells: [
                    // DataCell(TableText(DateFormat.yMMMd().format(value.date))),
                    DataCell(
                      Container(
                        width: 70,
                        alignment: Alignment.centerLeft,
                        child: Text(value.label),
                      ),
                      placeholder: true,
                    ),
                    DataCell(
                      CategoryCell(
                          category: value.category,
                          subcategory: value.subcategory),
                      placeholder: true,
                    ),
                    DataCell(
                      Text(
                        value.amount.toString(),
                        style: TextStyle(color: Colors.red),
                      ),
                      placeholder: true,
                    ),
                  ],
                ))
              });
          return ListView(
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('Label')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('Amount'), numeric: true),
                ],
                rows: _tempRow,
                showCheckboxColumn: false,
              ),
            ],
          );
        }
      },
    );
  }
}

class CategoryCell extends StatelessWidget {
  CategoryCell({this.category, this.subcategory});

  final String category;
  final String subcategory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.all(2),
          color: Colors.black26,
          child: Text(category),
        ),
        Container(
          width: 100,
          padding: EdgeInsets.all(2),
          color: Colors.black12,
          child: Text(subcategory),
        ),
      ],
    );
  }
}
