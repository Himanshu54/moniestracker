import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataTableDemo extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            columns: [
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Category')),
              DataColumn(label: Text('Amount')),
            ],
            source: _DataSource(context),
            showCheckboxColumn: false,
          ),
        ],
      ),
    );
  }
}

class _Row {
  _Row(
    this.valueB,
    this.valueC,
    this.valueD,
  );

  final String valueB;
  final String valueC;
  final int valueD;

  bool selected = false;
}

class _DataSource extends DataTableSource {
  _DataSource(this.context) {
    _rows = <_Row>[
      _Row('CellB1', 'CellC1', 1),
      _Row('CellB2', 'CellC2', 2),
      _Row('CellB3', 'CellC3', 3),
      _Row('CellB4', 'CellC4', 4),
    ];
  }

  final BuildContext context;
  late List<_Row> _rows;

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null as DataRow;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        notifyListeners();
      },
      cells: [
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
