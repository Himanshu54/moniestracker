import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';

class ExpenseInputForm extends StatefulWidget {
  @override
  ExpenseInputForm(this.expense);
  final Expense expense;
  _ExpenseInputFormState createState() {
    return _ExpenseInputFormState();
  }
}

class _ExpenseInputFormState extends State<ExpenseInputForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Expense e = Expense(null, null, null, DateTime.now(), null, null, null);
  String categoryDropdownValue = '1';
  String subCategoryDropdownValue;
  String accountDropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    e = widget.expense == null ? e : widget.expense;
    return Form(
      key: this._formKey,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text('Label'),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      initialValue: e.label,
                      onSaved: (String s) {
                        this.e.label = s;
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text('Amount'),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      initialValue: e.amount.toString(),
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: false),
                      onSaved: (String s) {
                        this.e.amount = double.parse(s);
                      },
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text('Date'),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 7,
                    child: DateTimeFormField(
                      onDateSelected: (DateTime d) {
                        this.e.date = d;
                      },
                      initialValue: this.e.date,
                      mode: DateTimeFieldPickerMode.date,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 1
                          ? 'Please not the first day'
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text('Account'),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 7,
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          e.account =
                              e.account == null ? snapshot.data[0] : e.account;
                          accountDropdownValue = e.account.id.toString();
                          return DropdownButton(
                            value: accountDropdownValue,
                            iconSize: 0,
                            onChanged: (String newValue) {
                              e.account = Account.fromObj(snapshot.data
                                  .where((Account c) =>
                                      c.id.toString() == newValue)
                                  .first);
                              setState(() {
                                accountDropdownValue = newValue;
                              });
                            },
                            items: snapshot.data
                                .map<DropdownMenuItem<String>>((Account cat) {
                              return DropdownMenuItem<String>(
                                value: cat.id.toString(),
                                child: Text(cat.name),
                              );
                            }).toList(),
                          );
                        }
                      },
                      future: getAllAccounts(),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text('Category'),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 7,
                    child: FutureBuilder(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          e.category = e.category == null
                              ? snapshot.data[0]
                              : e.category;
                          categoryDropdownValue = e.category.id.toString();
                          return DropdownButton(
                            value: categoryDropdownValue,
                            iconSize: 0,
                            onChanged: (String newValue) {
                              e.category = Category.fromObj(snapshot.data
                                  .where((Category c) =>
                                      c.id.toString() == newValue)
                                  .first);
                              setState(() {
                                categoryDropdownValue = newValue;
                              });
                            },
                            items: snapshot.data
                                .map<DropdownMenuItem<String>>((Category cat) {
                              return DropdownMenuItem<String>(
                                value: cat.id.toString(),
                                child: Text(cat.category),
                              );
                            }).toList(),
                          );
                        }
                      },
                      future: getAllCategory(),
                    ),
                  )
                ],
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Row(
                children: [
                  Expanded(
                    child: Text('SubCategory'),
                    flex: 3,
                  ),
                  Expanded(
                    flex: 7,
                    child: FutureBuilder(
                      future: getSubcategories(categoryDropdownValue),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          e.subcategory = e.subcategory == null
                              ? snapshot.data[0]
                              : snapshot.data
                                          .where((item) =>
                                              item.id == e.subcategory.id)
                                          .length ==
                                      1
                                  ? e.subcategory
                                  : snapshot.data[0];
                          subCategoryDropdownValue =
                              e.subcategory.id.toString();

                          return DropdownButton(
                            value: subCategoryDropdownValue,
                            iconSize: 0,
                            onChanged: (String newValue) {
                              e.subcategory = SubCategory.fromObj(snapshot.data
                                  .where((SubCategory c) =>
                                      c.id.toString() == newValue)
                                  .first);
                              setState(() {
                                subCategoryDropdownValue = newValue;
                              });
                            },
                            items: snapshot.data.map<DropdownMenuItem<String>>(
                                (SubCategory cat) {
                              return DropdownMenuItem<String>(
                                value: cat.id.toString(),
                                child: Text(cat.subcategory),
                              );
                            }).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        if (this._formKey.currentState.validate()) {
                          _formKey.currentState.save();
                        }
                        insertExpense(e);
                        Navigator.pushNamed(
                          context,
                          '/home',
                          arguments: null,
                        );
                      },
                      child: Text('Add'),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: () {
                        deleteExpense(e);
                        Navigator.pushNamed(
                          context,
                          '/home',
                          arguments: null,
                        );
                      },
                      child: Text('Delete'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
