import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providerpersons.dart';

class ShowProviderConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Consumer<ProviderPersons>(
        builder: (context, value, _) {
          value.fetchPersonRecords();
          return ListView.builder(
            itemCount: value.items.length,
            itemBuilder: (context, index) {
              var personInQuestion = value.items[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(personInQuestion.firstname),
                subtitle: Text(personInQuestion.strength),
                trailing: Text(personInQuestion.cuteness.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
