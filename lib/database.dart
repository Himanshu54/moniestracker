import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Expense {
  final int? id;
  DateTime date;
  double amount;

  Expense(
    this.id,
    this.date,
    this.amount,
  ) {
    DateTime now = new DateTime.now();
    this.date = new DateTime(now.year, now.month, now.day);
    this.amount = 0;
  }

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
        json['id'] as int, json['date'] as DateTime, json['amount'] as double);
  }
}

late Future<Database> _database;
String? dbName = 'expense';
Future<Database> get database async {
  if (_database != null) return _database;
  await initDB();
  return _database;
}

initDB() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, dbName);

// Make sure the directory exists
  try {
    await Directory(databasesPath).create(recursive: true);
  } catch (_) {}
  // Open the database and store the reference.
  _database = openDatabase(
    path,
    onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      return await db.execute(
        "CREATE TABLE expense(id INTEGER  NOT NULL  IDENTITY  PRIMARY KEY, amount REAL  NOT NULL, date DATE  NOT NULL)",
      );
    },
    version: 4,
  );
}

// Define a function that inserts dogs into the database
Future<void> insertExpense(Expense e) async {
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'expense',
    e.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<Expense>> expense() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('expense');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Expense(
      maps[i]['id'],
      maps[i]['date'],
      double.parse(maps[i]['amount']),
    );
  });
}
