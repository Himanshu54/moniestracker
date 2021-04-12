import 'package:flutter/material.dart';

class CategoryPicker extends StatefulWidget {
  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  var txt = TextEditingController();
  List<SimpleDialogItem> row = [];

  @override
  Widget build(BuildContext context) {
    row = [];
    for (var cat in ['transportaion', 'food']) {
      row.add(
        SimpleDialogItem(
          text: cat,
          onPressed: () {
            txt.text = cat;
            Navigator.pop(context, cat);
          },
        ),
      );
    }
    final SimpleDialog dialog = SimpleDialog(
      children: row,
    );
    return Container(
      margin: EdgeInsets.all(16.0),
      child: TextFormField(
        controller: txt,
        onTap: () {
          showDialog<void>(context: context, builder: (context) => dialog);
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

class SimpleDialogItem extends StatelessWidget {
  const SimpleDialogItem({Key key, this.text: '', this.onPressed})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 16.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
