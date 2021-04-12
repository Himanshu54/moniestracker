import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/addcategory.dart';
import 'package:moniestracker/src/views/ui/expense.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';
import 'package:moniestracker/src/views/ui/subcategorypicker.dart';

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: [
            Center(child: ExpenseCanvas()),
            Center(child: AddCategoryForm()),
            Center(child: InputExpenseCanvas()),
            Center(child: SubCategoryPicker()),
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
              Tab(text: 'This Year', icon: Icon(Icons.calendar_view_day)),
            ],
          ),
        ),
      ),
    );
  }
}
