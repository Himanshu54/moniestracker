import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/home.dart';
import 'package:moniestracker/src/views/ui/inputexpensecanvas.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeApp.routeName,
      routes: {
        HomeApp.routeName: (BuildContext context) => HomeApp(),
        InputExpenseCanvas.routeName: (BuildContext context) =>
            InputExpenseCanvas(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
    );
  }
}
