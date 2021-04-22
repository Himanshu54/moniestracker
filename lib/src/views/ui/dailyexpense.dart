import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/models.dart';
import 'package:moniestracker/src/data/transactions.dart';
import 'package:moniestracker/src/views/utils/constants.dart';

Transactions _transactions = Transactions();

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

class DailyExpenseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpenseDataTable(),
    );
  }
}

class ExpenseDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          {
            Set<MyDateTime> uniqueDates = [
              for (Entry e in _transactions.allEntries.values) e.tDate
            ].toSet();
            return Container(
              child: Column(
                children: [
                  for (MyDateTime date in uniqueDates)
                    EntriesRows(
                        Transactions()
                            .allEntries
                            .values
                            .where((element) => date == element.tDate)
                            .toList(),
                        date)
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      future: _transactions.initTransaction(),
    );
  }
}

class EntriesRows extends StatelessWidget {
  EntriesRows(this.entries, this.date);
  final List<Entry> entries;
  final MyDateTime date;
  @override
  Widget build(BuildContext context) {
    double sum = 0;
    List<Widget> t = [];
    for (Entry e in entries) {
      sum += e.tAmount;
      t.add(
        TextButton(
          onPressed: () {},
          style: AlternateColorButtonStyle(() => e.tId, context),
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(e.tLabel),
              ),
              Expanded(
                flex: 3,
                child: CategoryCell(
                  category: _transactions.categoryMap[e.ctId].category,
                  subcategory:
                      _transactions.subCategoryMap[e.sctId].subcategory,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  e.tAmount.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  date.getDate().day.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    CalenderHelper().getWeekDay(date.getDate()),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Text(
                  sum.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: t,
          ),
        ],
      ),
    );
  }
}

class AlternateColorButtonStyle extends ButtonStyle {
  final Function getIndex;
  final BuildContext context;
  AlternateColorButtonStyle(this.getIndex, this.context)
      : super(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected))
                return Theme.of(context).colorScheme.primary.withOpacity(0.08);
              if (getIndex() % 2 == 0) return Colors.grey.withOpacity(0.09);
              return null;
            },
          ),
        );
}
