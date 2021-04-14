import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';

class SelectCategoryDialog extends StatefulWidget {
  SelectCategoryDialog(this.updateCategory);
  final Function updateCategory;

  @override
  _SelectCategoryDialogState createState() => _SelectCategoryDialogState();
}

class _SelectCategoryDialogState extends State<SelectCategoryDialog> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(),
          title: Text(
            'Select Category/Sub-Category',
            textScaleFactor: 0.7,
          ),
        ),
        body: CategoryBar(widget.updateCategory),
      ),
    );
  }
}

class CategoryBar extends StatefulWidget {
  CategoryBar(this.updateCategory);
  final Function updateCategory;
  @override
  _CategoryBarState createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  Future<List<Category>> categories = category();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final value = snapshot.data;
          List<DataRow> _tempRow = [];
          value.asMap().forEach((index, value) => {
                _tempRow.add(DataRow.byIndex(
                  index: index,
                  selected: false,
                  cells: [
                    DataCell(
                      Text(value.category),
                      onTap: () {
                        widget.updateCategory(value.category);
                        // Navigator.of(context).push(SubCategoryPicker());
                      },
                    )
                  ],
                ))
              });
          return ListView(
            children: [
              DataTable(
                columns: [
                  DataColumn(label: Text('Category')),
                ],
                rows: _tempRow,
                showCheckboxColumn: false,
              ),
            ],
          );
        }
      },
      future: categories,
    );
  }
}
