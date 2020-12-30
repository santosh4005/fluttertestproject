import 'package:flutter/material.dart';

class ShowDatePickerControl extends StatefulWidget {
  @override
  _ShowDatePickerControlState createState() => _ShowDatePickerControlState();
}

class _ShowDatePickerControlState extends State<ShowDatePickerControl> {
  String selectedDate = "Pick a date";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Date Picker"),
        ),
        body: Center(
          child: RaisedButton(
              child: Text(selectedDate),
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year),
                        lastDate: DateTime(DateTime.now().year + 1))
                    .then((value) {
                  setState(() {
                    selectedDate = value.toString();
                  });
                });
              }),
        ),
      ),
    );
  }
}
