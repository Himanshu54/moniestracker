import 'package:flutter/material.dart';

class SubCategoryPicker extends StatefulWidget {
  @override
  _SubCategoryPickerState createState() => _SubCategoryPickerState();
}

class _SubCategoryPickerState extends State<SubCategoryPicker> {
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
          // showDialog<void>(
          // context: context,
          // builder: (context) => SelectCategoryDialog(updateCategory));
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
