import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Expense {
  final int id;
  final String date;
  final double amount;

  Expense({this.id, this.date, this.amount});

  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'date': date,
    };
  }
}


class DBConnector {
    DBConnector._();
  static final DBConnector db = DBConnector._();
}

Future<Database> _database;

Future<Database> get database async {
  if(_database != null) return _database;
  _database = await initDB();
  return _database;
}

initDB() async {
  // Open the database and store the reference.
  _database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'expense_database.db'),

    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        "CREATE TABLE expense(id INTEGER PRIMARY KEY, amount TEXT, date DATE)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
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
