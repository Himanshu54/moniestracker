import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:moniestracker/src/data/database.dart';
import 'package:moniestracker/src/data/models.dart';

class ExpenseInputForm extends StatefulWidget {
  @override
  _ExpenseInputFormState createState() {
    return _ExpenseInputFormState();
  }
}

class _ExpenseInputFormState extends State<ExpenseInputForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final Expense e = Expense(null, null, null, null, null, null, null);
  String categoryDropdownValue = '1';
  String subCategoryDropdownValue = '1';

  Future<List<Category>> categories = category();
  Future<List<SubCategory>> subcategories = subcategory(1);
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
                      initialValue: DateTime.now(),
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
                    child: Text('Category'),
                    flex: 3,
                  ),
                  Expanded(
                      flex: 7,
                      child: FutureBuilder(
                        future: categories,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            // while data is loading:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return DropdownButton(
                              value: categoryDropdownValue,
                              iconSize: 0,
                              onChanged: (String newValue) {
                                setState(() {
                                  categoryDropdownValue = newValue;
                                  subcategories =
                                      subcategory(int.parse(newValue));
                                });
                              },
                              items: snapshot.data
                                  .map<DropdownMenuItem<String>>(
                                      (Category cat) {
                                return DropdownMenuItem<String>(
                                  value: cat.id.toString(),
                                  child: Text(cat.category),
                                );
                              }).toList(),
                            );
                          }
                        },
                      )),
                ],
              ),
            ),
            // TODO:Handle empty subcategories
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
                        future: subcategories,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            // while data is loading:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return DropdownButton(
                              value: subCategoryDropdownValue,
                              iconSize: 0,
                              onChanged: (String newValue) {
                                setState(() {
                                  subCategoryDropdownValue = newValue;
                                });
                              },
                              items: snapshot.data
                                  .map<DropdownMenuItem<String>>(
                                      (SubCategory cat) {
                                return DropdownMenuItem<String>(
                                  value: cat.id.toString(),
                                  child: Text(cat.subcategory),
                                );
                              }).toList(),
                            );
                          }
                        },
                      )),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
