import 'package:flutter/material.dart';

class ShowDismissable extends StatefulWidget {
  @override
  _ShowDismissableState createState() => _ShowDismissableState();
}

class _ShowDismissableState extends State<ShowDismissable> {
  var _listitems = ["Test 1", "Test 2", "Test 3", "Test 4"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Dimissable demo ${_listitems.length} items"),
        ),
        body: ListView.builder(
          itemCount: _listitems.length,
          itemBuilder: (context, index) {
            return Dismissible(
                onDismissed: (direction) {
                  setState(() {
                    print("removing ${_listitems[index]}");
                    _listitems.removeAt(index);
                  });
                },
                confirmDismiss: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Whoa!"),
                          content: Text("Are you sure?"),
                          actions: [
                            ElevatedButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                }),
                            ElevatedButton(
                                child: Text("No"),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "PUSSY",
                                    textAlign: TextAlign.center,
                                  )));

                                  Navigator.of(context).pop(false);
                                })
                          ],
                        );
                      },
                    );
                  } else {
                    return Future<bool>.value(false);
                  }
                },
                key: ValueKey(_listitems[index]),
                background: Container(
                  decoration: BoxDecoration(color: Colors.redAccent),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Icon(
                      Icons.delete_sweep_rounded,
                      color: Colors.white,
                    ),
                  ),
                  alignment: Alignment.centerRight,
                ),
                child: Card(
                  child: StupidListTile(
                    title: _listitems[index],
                    subtitle: _listitems[index],
                  ),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ));
          },
        ));
  }
}

class StupidListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  StupidListTile({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: UniqueKey(),
      title: Text(title),
      subtitle: Text("Subtitle: $subtitle"),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: (Text('Dick bag!')),
          ));
        },
      ),
    );
  }
}
