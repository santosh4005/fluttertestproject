import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/helpers/constants.dart';
import 'package:testtodelete/helpers/dbhelper.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providerpersons.dart';

class ShowFormWidget extends StatefulWidget {
  @override
  _ShowFormWidgetState createState() => _ShowFormWidgetState();
}

class _ShowFormWidgetState extends State<ShowFormWidget> {
  final _form = GlobalKey<FormState>();

  TextEditingController _firstnamecontroller;
  TextEditingController _lastnamecontroller;
  TextEditingController _strengthcontroller;
  double _cuteness = 1;

  FocusNode _lastnamefocusnode;
  FocusNode _strengthfocusnode;

  @override
  void initState() {
    _firstnamecontroller = TextEditingController();
    _lastnamecontroller = TextEditingController();
    _strengthcontroller = TextEditingController();
    _lastnamefocusnode = FocusNode();
    _strengthfocusnode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
    _strengthcontroller.dispose();
    _lastnamefocusnode.dispose();
    _strengthfocusnode.dispose();
    super.dispose();
  }

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
                controller: _firstnamecontroller,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value.isEmpty) {
                    return "nah nah nah";
                  }
                  return null;
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_lastnamefocusnode);
                },
                decoration: textInputDecoration.copyWith(
                  labelText: "First Name",
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "nah nah nah";
                  }
                  return null;
                },
                focusNode: _lastnamefocusnode,
                controller: _lastnamecontroller,
                decoration:
                    textInputDecoration.copyWith(labelText: "Last Name"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_strengthfocusnode);
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _strengthcontroller,
                focusNode: _strengthfocusnode,
                validator: (value) {
                  if (value.isEmpty) {
                    return "nah nah nah";
                  }
                  return null;
                },
                decoration:
                    textInputDecoration.copyWith(labelText: "Primary Strength"),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      max: 10,
                      min: 1,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.cyan[300],
                      value: _cuteness,
                      onChanged: (value) {
                        setState(() {
                          _cuteness = value.roundToDouble();
                        });
                      },
                    ),
                  ),
                  Text(_cuteness.toString()),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              RaisedButton(
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (_form.currentState.validate()) {
//add to the database
                    Provider.of<ProviderPersons>(
                      context,
                      listen: false,
                    ).addPerson(Person(
                        _firstnamecontroller.text,
                        _lastnamecontroller.text,
                        _strengthcontroller.text,
                        _cuteness));

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Success!"),
                          content: Text("Record created"),
                          actions: [
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(color: Colors.white),
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        );
                      },
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("What the fuck moron!")));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
