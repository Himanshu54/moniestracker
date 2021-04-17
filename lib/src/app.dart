import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/home.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {'/': (BuildContext context) => HomeApp()},
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
    );
  }
}
