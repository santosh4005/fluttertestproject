import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/helpers/constants.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providerpersons.dart';

class ShowFormWidget extends StatefulWidget {
  @override
  _ShowFormWidgetState createState() => _ShowFormWidgetState();
}

class _ShowFormWidgetState extends State<ShowFormWidget> {
  final _form = GlobalKey<FormState>();

  late TextEditingController _firstnamecontroller;
  late TextEditingController _lastnamecontroller;
  late TextEditingController _strengthcontroller;
  int _cuteness = 1;
  int _rating = 1;

  late FocusNode _lastnamefocusnode;
  late FocusNode _strengthfocusnode;

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
    var user = FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Form"),
      ),
      body: Container(
        padding: EdgeInsets.all(9),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _firstnamecontroller,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.toString().isEmpty) {
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
                    if (value.toString().isEmpty) {
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
                    if (value.toString().isEmpty) {
                      return "nah nah nah";
                    }
                    return null;
                  },
                  decoration: textInputDecoration.copyWith(
                      labelText: "Primary Strength"),
                ),
                SizedBox(
                  height: 5,
                ),
                DropdownButtonFormField<int>(
                    value: _rating,
                    onChanged: (val) {
                      setState(() {
                        _rating = val!;
                      });
                    },
                    items: [1, 2, 3, 4, 5]
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text("Item Number: ${e.toString()}")))
                        .toList()),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        max: 10,
                        min: 1,
                        activeColor: Colors.pink,
                        inactiveColor: Colors.cyan[300],
                        value: _cuteness * 1.0,
                        onChanged: (value) {
                          setState(() {
                            _cuteness = value.round();
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.pink),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  // elevation: 5,
                  // shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(20)),
                  // color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_form.currentState!.validate()) {
//add to the database
                      Provider.of<ProviderPersons>(
                        context,
                        listen: false,
                      ).addPerson(Person(
                          createdby: user,
                          id: DateTime.now().toString(),
                          firstname: _firstnamecontroller.text,
                          lastname: _lastnamecontroller.text,
                          strength: _strengthcontroller.text,
                          cuteness: _cuteness));

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
      ),
    );
  }
}
