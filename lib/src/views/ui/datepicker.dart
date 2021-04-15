import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class DateAndTimePicker extends StatefulWidget {
  @override
  _DateAndTimePicker createState() => _DateAndTimePicker();
}

class _DateAndTimePicker extends State<DateAndTimePicker> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      initialValue: DateTime.now(),
      mode: DateTimeFieldPickerMode.date,
      decoration: const InputDecoration(
        border: InputBorder.none,
        suffixIcon: Icon(Icons.event_note),
      ),
      autovalidateMode: AutovalidateMode.always,
      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: (DateTime value) {
        print(value);
      },
    );
  }
}
