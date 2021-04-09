import 'package:flutter/material.dart';

import 'database.dart';
import 'expense.dart';
import 'expense_table.dart';

void main() async{
  initDB();
  runApp(MaterialApp(
    home: DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            Center(child: ExpenseCanvas()),
            Center(child: DataTableDemo()),
            Center(child: Text('BIRDS')),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('All my monies'),
          backgroundColor: Colors.blueGrey[900],
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
    ),
  ));
}
