import 'package:flutter/material.dart';

class AddCategoryForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: TextFormField(
        onTap: (){
          
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: null,
        ),
      ),
    );
  }
}