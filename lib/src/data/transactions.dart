import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';

Transactions _transactions = Transactions();
class Transactions {
  Map<int, Category> categoryMap;
  Map<int, SubCategory> subCategoryMap;
  Map<int, Account> accountMap;
  Map<int, Entries> allEntries;

  buildCategoryMap() {
    Future<List<Category>> allCategories = getAllCategory();
    allCategories.then((value) {
      categoryMap = Map<int, Category>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to load Categories');
    });
  }

  buildSubCategoryMap() {
    Future<List<SubCategory>> allSubcategories = getAllSubcategories();
    allSubcategories.then((value) {
      subCategoryMap = Map<int, SubCategory>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to load SubCategories');
    });
  }

  buildAccountMap() {
    Future<List<Account>> allAccounts = getAllAccounts();
    allAccounts.then((value) {
      accountMap = Map<int, Account>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to load Accounts');
    });
  }

  getAllEntries() {
    Future<List<Entries>> entries = getAllEntries();
    entries.then((value) {
      allEntries = Map<int, Entries>.fromIterable(
        value,
        key: (item) => item.id,
        value: (item) => item,
      );
    }).onError((error, stackTrace) {
      print('Unable to get entries');
    });
  }

  Transactions() {
    getAllEntries();
    buildCategoryMap();
  }
}
