import 'dart:async';
import 'dart:io';
import 'package:moniestracker/src/data/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _database;
String dbName = 'expense';
Future<Database> get database async {
  if (_database != null) return _database;
  return await initDB();
}

initDB() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, dbName);

  print(path);
// /Users/hgusain/Library/Developer/CoreSimulator/Devices/5BB719A3-527A-4DDF-BEBB-27D826DD3427/data/Containers/Data/Application/7A562483-E020-4B97-9BEE-C6D935E67E22/Documents/expense
  await deleteDatabase(path);
// Make sure the directory exists
  try {
    await Directory(databasesPath).create(recursive: true);
  } catch (_) {}
  // Open the database and store the reference.
  _database = openDatabase(
    path,
    onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
        """
CREATE TABLE MT_CATEGORY(
  ct_id INTEGER  NOT NULL PRIMARY KEY,
  ct_category TEXT NOT NULL
);

CREATE TABLE MT_TRANSACTION(
  t_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  ct_id INTEGER NOT NULL,
  t_amount REAL  NOT NULL,
  t_date DATE  DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ct_id)REFERENCES MT_CATEGORY(ct_id)
 );
 
 CREATE TABLE MT_SUBCATEGORY(
   sct_id INTEGER  NOT NULL PRIMARY KEY,
   ct_id INTEGER,
   sct_subcategory  TEXT  NOT NULL,
   FOREIGN KEY (ct_id)REFERENCES MT_CATEGORY(ct_id)
 );
 """,
      );
    },
    version: 2,
  );
  return _database;
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
  final List<Map<String, dynamic>> maps = await db.query('MT_TRANSACTION');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Expense(maps[i]['id'], maps[i]['category'],
        double.parse(maps[i]['amount']), maps[i]['date']);
  });
}
