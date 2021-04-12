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
          showDialog<void>(
              context: context,
              builder: (context) => SelectCategoryDialog(
                    updateCategory: updateCategory,
                  ));
        },
        decoration: InputDecoration(
          labelText: 'Sub-Category',
          suffixIcon: Icon(
            Icons.check_circle,
          ),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class SelectCategoryDialog extends SimpleDialog {
  SelectCategoryDialog({Key key, this.updateCategory}) : super(key: key);

  final void Function(String) updateCategory;

  @override
  Widget build(BuildContext context) {
    List<String> categories = ['Transportaion', 'Food'];
    List<SimpleDialogOption> categoriesOptions = categories
        .map((cat) => SimpleDialogOption(
              onPressed: () {
                updateCategory(cat);
                Navigator.pop(context, cat);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(cat),
                ],
              ),
            ))
        .toList();
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: categoriesOptions,
    );
  }
}
