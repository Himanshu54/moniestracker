import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/dailyexpense.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';
import 'package:moniestracker/src/views/utils/constants.dart';

class HomeApp extends StatelessWidget {
  static const routeName = '/home';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: TabBarView(
          children: [
            Center(child: DailyExpenseCard()),
          ],
        ),
        appBar: AppBar(
          leading: Icon(Icons.menu),
          title: Text('All my monies'),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                  text: CalenderHelper().getMonthAndYear(DateTime.now()),
                  icon: Icon(Icons.table_chart_outlined)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.white70,
          onPressed: () {
            Navigator.pushNamed(context, InputExpenseCanvas.routeName);
          },
        ),
      ),
    );
  }
}
