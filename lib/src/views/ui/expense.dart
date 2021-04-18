import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';

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
      child: FutureBuilder(
        future: expense(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
            value.forEach((value) => {
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
                      if (value.id % 2 == 0)
                        return Colors.grey.withOpacity(0.3);
                      return null; // Use default value for other states and odd rows.
                    }),
                    index: value.id,
                    selected: false,
                    onSelectChanged: (bool selected) {
                      Navigator.pushNamed(
                        context,
                        InputExpenseCanvas.routeName,
                        arguments: value,
                      );
                    },
                    cells: [
                      // DataCell(TableText(DateFormat.yMMMd().format(value.date))),

                      DataCell(
                        CategoryCell(
                            category: value.category.category,
                            subcategory: value.subcategory.subcategory),
                        placeholder: true,
                      ),
                      DataCell(
                        Container(
                          width: 70,
                          alignment: Alignment.centerLeft,
                          child: Text(value.label),
                        ),
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
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Label')),
                    DataColumn(label: Text('Amount'), numeric: true),
                  ],
                  rows: _tempRow,
                  showCheckboxColumn: false,
                ),
              ],
            );
          }
        },
      ),
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
          child: Text(category),
        ),
        Container(
          child: Text(subcategory),
        ),
      ],
    );
  }
}
