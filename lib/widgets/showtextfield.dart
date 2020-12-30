import 'package:flutter/material.dart';

class ShowTextField extends StatefulWidget {
  @override
  _ShowTextFieldState createState() => _ShowTextFieldState();
}

class _ShowTextFieldState extends State<ShowTextField> {
  TextEditingController ctrller = TextEditingController();
  @override
  void initState() {
    ctrller.text = "dingis";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text Field"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              RaisedButton(
                  child: Text("Print"),
                  onPressed: () {
                    print(ctrller.text);
                  }),
              TextField(
                controller: ctrller,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "hint",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
