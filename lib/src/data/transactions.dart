import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';

class Transactions {
  Map<int, Category> categoryMap;
  Map<int, SubCategory> subCategoryMap;
  Map<int, Account> accountMap;
  Map<int, Entry> allEntries;

  Future<List<Category>> allCategories;
  Future<List<Entry>> entries;
  Future<List<Account>> allAccounts;
  Future<List<SubCategory>> allSubcategories;

  static final Transactions _transactions = Transactions._internal();

  factory Transactions() {
    return _transactions;
  }

  Transactions._internal();

  initTransaction() async {
    // await Future.delayed(Duration(seconds: 5));
    await buildAccountMap();
    await buildCategoryMap();
    await buildSubCategoryMap();
    await getAllEntries();
    return;
  }

  buildCategoryMap() async {
    allCategories = getAllCategory();
    await allCategories.then((value) {
      categoryMap = Map<int, Category>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to load Categories');
    });
  }

  buildSubCategoryMap() async {
    allSubcategories = getAllSubcategories();
    await allSubcategories.then((value) {
      subCategoryMap = Map<int, SubCategory>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to load SubCategories');
    });
  }

  buildAccountMap() async {
    allAccounts = getAllAccounts();
    await allAccounts.then((value) {
      accountMap = Map<int, Account>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to load Accounts');
    });
  }

  getAllEntries() async {
    entries = getAllTransactions();
    await entries.then((value) {
      allEntries = Map<int, Entry>.fromIterable(
        value,
        key: (item) => item.tId,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to get entries');
    });
  }
}
