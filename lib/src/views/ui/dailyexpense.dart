import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';
import 'package:moniestracker/src/views/ui/expense.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';
import 'package:moniestracker/src/views/utils/constants.dart';

class DailyExpenseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpenseDataTable(),
    );
  }
}

class ExpenseDataTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Expense> data = snapshot.data;
          List<Widget> _rows = [];
          Set<DateTime> days = [for (Expense e in data) e.date].toSet();
          days.forEach((element) {
            List<Expense> dayItems = data
                .where((expense) => expense.date.day == element.day)
                .toList();
            int index = 0;
            List<Widget> t = [
              for (Expense e in dayItems)
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      InputExpenseCanvas.routeName,
                      arguments: e,
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      index += 1;
                      if (states.contains(MaterialState.selected))
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.08);
                      if (index % 2 == 0) return Colors.grey.withOpacity(0.09);
                      return null;
                    }),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(e.label),
                      ),
                      Expanded(
                        flex: 3,
                        child: CategoryCell(
                            category: e.category.category,
                            subcategory: e.subcategory.subcategory),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          e.amount.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ];
            double sum = 0;
            for (Expense e in dayItems) {
              sum += e.amount;
            }
            _rows.add(
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            element.day.toString(),
                            style: TextStyle(
                              color: Colors.amber[100],
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
                              CalenderHelper().getWeekDay(element),
                              style: TextStyle(color: Colors.amber[100]),
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
              ),
            );
          });

          return Container(
            child: Column(
              children: _rows,
            ),
          );
        } else {
          return Text('No data');
        }
      },
      future: getExpenseByMonth(DateTime.now()),
    );
  }
}
