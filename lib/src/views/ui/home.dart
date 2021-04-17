import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/expense.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';

class HomeApp extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            Center(child: ExpenseCanvas()),
            Center(child: ExpenseCanvas()),
          ],
        ),
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('All my monies'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Today', icon: Icon(Icons.calendar_today)),
              Tab(text: 'Add Expense', icon: Icon(Icons.calendar_view_day)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => InputExpenseCanvas()));
          },
        ),
      ),
    );
  }
}
