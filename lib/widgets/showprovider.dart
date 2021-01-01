import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providerpersons.dart';

class ShowProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedPersons = Provider.of<ProviderPersons>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              Provider.of<ProviderPersons>(context, listen: false).addPerson(
                  Person("Santosh", "Chintamaneni", "Executioner", 10));
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: loadedPersons.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(loadedPersons[index].firstname),
            subtitle: Text(loadedPersons[index].strength),
            trailing: Text(loadedPersons[index].cuteness.toString()),
          );
        },
      ),
    );
  }
}
