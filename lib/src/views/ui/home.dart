import 'package:flutter/material.dart';
import 'package:moniestracker/expense.dart';
import 'package:moniestracker/src/views/ui/fullscreendialog.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            Center(child: ExpenseCanvas()),
            Center(child: TestPage()),
            Center(child: InputExpenseCanvas()),
          ],
        ),
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('All my monies'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Today', icon: Icon(Icons.calendar_today)),
              Tab(text: 'This Week', icon: Icon(Icons.calendar_view_day)),
              Tab(text: 'This Month', icon: Icon(Icons.calendar_view_day)),
            ],
          ),
        ),
      ),
    );
  }
}
