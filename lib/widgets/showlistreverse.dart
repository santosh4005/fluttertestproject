import 'package:flutter/material.dart';

class ShowListReverse extends StatelessWidget {
  final arraylist = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        reverse: true,
        children: arraylist
            .map((e) => ListTile(
                  title: Text("Item number $e"),
                  subtitle: Text("Sub Item for $e"),
                  trailing: Text("$e/${arraylist.length}"),
                ))
            .toList(),
      ),
    );
  }
}
