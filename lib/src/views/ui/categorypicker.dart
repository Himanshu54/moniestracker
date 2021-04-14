import 'package:flutter/material.dart';
import 'package:moniestracker/src/views/ui/categorypickerdialog.dart';

class CategoryPicker extends StatefulWidget {
  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  var txt = TextEditingController();

  void updateCategory(String text) {
    txt.text = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: TextFormField(
        controller: txt,
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (context) => SelectCategoryDialog(updateCategory));
        },
        decoration: InputDecoration(
          labelText: 'Category',
          suffixIcon: Icon(
            Icons.check_circle,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
