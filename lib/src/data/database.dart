import 'dart:async';
import 'dart:io';
import 'package:moniestracker/src/data/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> _database;
String dbName = 'MT_EXPENSE';
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
    '/Users/hgusain/repo/himanhsu54/moneymanager_analyzer/moniestracker/test/MT_EXPENSE',
    // path,
    onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      await db.execute(
        """
CREATE TABLE MT_CATEGORY(
  ct_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ct_category TEXT NOT NULL
);

CREATE TABLE MT_TRANSACTION(
  t_id INTEGER PRIMARY KEY AUTOINCREMENT,
  ct_id INTEGER NOT NULL,
  sct_id INTEGER NOT NULL,
  t_amount REAL  NOT NULL,
  t_label TEXT,
  ac_id INTEGER NOT NULL,
  t_date DATE  DEFAULT CURRENT_TIMESTAMP NOT NULL,
  FOREIGN KEY (sct_id)REFERENCES MT_SUBCATEGORY(sct_id),
  FOREIGN KEY (ct_id)REFERENCES MT_CATEGORY(ct_id),
  FOREIGN KEY (ac_id)REFERENCES MT_ACCOUNTS(ac_id)
 );
 
 CREATE TABLE MT_ACCOUNT(
   ac_id INTEGER PRIMARY KEY AUTOINCREMENT,
   ac_name TEXT NOT NULL
 );
 CREATE TABLE MT_SUBCATEGORY(
   sct_id INTEGER PRIMARY KEY AUTOINCREMENT,
   ct_id INTEGER,
   sct_subcategory  TEXT  NOT NULL,
   FOREIGN KEY (ct_id)REFERENCES MT_CATEGORY(ct_id)
 );
 """,
      );
    },
    version: 1,
  );
  return _database;
}

Future<void> insertExpense(Expense e) async {
  final Database db = await database;

  // Insert
  await db.insert(
    'MT_TRANSACTION',
    e.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<void> deleteExpense(Expense e) async {
  final Database db = await database;

  // Insert
  return await db
      .delete('MT_TRANSACTION', where: 't_id = ?', whereArgs: [e.id]);
}

Future<List<Expense>> expense() async {
  // Get a reference to the database.
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.rawQuery("""
SELECT t_id,t_label,t_amount, mc.ct_category, mt.ct_id, t_date, ms.sct_subcategory, ms.sct_id, ma.ac_id, ma.ac_name FROM MT_TRANSACTION mt
JOIN MT_CATEGORY mc ON mc.ct_id=mt.ct_id
JOIN MT_SUBCATEGORY ms on ms.sct_id=mt.sct_id
JOIN MT_ACCOUNT ma on ma.ac_id=mt.ac_id  
""");

  return List.generate(maps.length, (i) {
    return Expense.fromJson(maps[i]);
  });
}

Future<List<Category>> getAllCategory() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('MT_CATEGORY');

  return List.generate(maps.length, (index) {
    return Category.fromJson(maps[index]);
  });
}

Future<Category> getCategory(String id) async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db
      .rawQuery('select * from MT_CATEGORY where ct_id=? Limit 1;', [id]);

  return Category.fromJson(maps[0]);
}

Future<SubCategory> getSubategory(String id) async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db
      .rawQuery('select * from MT_SUBCATEGORY where sct_id=? Limit 1;', [id]);

  return SubCategory.fromJson(maps[0]);
}

Future<List<SubCategory>> getSubcategories(String categoryId) async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db
      .rawQuery('select * from MT_SUBCATEGORY where ct_id=?;', [categoryId]);

  return List.generate(maps.length, (index) {
    return SubCategory.fromJson(maps[index]);
  });
}

Future<List<SubCategory>> getAllSubcategories() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('MT_SUBCATEGORY');

  return List.generate(maps.length, (index) {
    return SubCategory.fromJson(maps[index]);
  });
}

Future<List<Account>> getAllAccounts() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('MT_ACCOUNT');

  return List.generate(maps.length, (index) {
    return Account.fromJson(maps[index]);
  });
}

Future<List<Expense>> getExpenseByMonth(DateTime d) async {
  final Database db = await database;
  String date = d.toIso8601String().substring(0, 10);

  final List<Map<String, dynamic>> maps = await db.rawQuery("""
SELECT t_id, t_label, t_amount, mc.ct_category, mt.ct_id, t_date, ms.sct_subcategory, ms.sct_id, ma.ac_id, ma.ac_name FROM MT_TRANSACTION mt
JOIN MT_CATEGORY mc ON mc.ct_id=mt.ct_id
JOIN MT_SUBCATEGORY ms on ms.sct_id=mt.sct_id
JOIN MT_ACCOUNT ma on ma.ac_id=mt.ac_id
WHERE STRFTIME('%m',t_date) = STRFTIME('%m',?)
""", [date]);

  return List.generate(maps.length, (index) {
    return Expense.fromJson(maps[index]);
  });
}
