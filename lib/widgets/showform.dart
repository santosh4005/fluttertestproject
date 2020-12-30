import 'package:flutter/material.dart';

class ShowFormWidget extends StatefulWidget {
  @override
  _ShowFormWidgetState createState() => _ShowFormWidgetState();
}

class _ShowFormWidgetState extends State<ShowFormWidget> {
  final _form = GlobalKey<FormState>();

  TextEditingController _firstnamecontroller;
  TextEditingController _lastnamecontroller;

  FocusNode _lastnamefocusnode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _form,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.contains('santosh')) {
                    return "nah nah nah";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_lastnamefocusnode);
                },
                decoration: InputDecoration(
                  labelText: "First Name",
                ),
              ),
              TextFormField(
                focusNode: _lastnamefocusnode,
                decoration: InputDecoration(labelText: "Last Name"),
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Submit this shit!"),
                        actions: [
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(true);
                            },
                            child: Text("Yes"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}