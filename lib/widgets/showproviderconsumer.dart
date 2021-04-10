import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providerpersons.dart';

class ShowProviderConsumer extends StatefulWidget {
  @override
  _ShowProviderConsumerState createState() => _ShowProviderConsumerState();
}

class _ShowProviderConsumerState extends State<ShowProviderConsumer> {
  var user = FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumer Demo"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () {
              Provider.of<ProviderPersons>(context, listen: false).addPerson(
                  Person(
                      createdby: user,
                      id: DateTime.now().toString(),
                      firstname: "Santosh",
                      lastname: "Chintamaneni",
                      strength: "Executioner",
                      cuteness: 10));
            },
          )
        ],
      ),
      body: Consumer<ProviderPersons>(
        builder: (context, value, _) {
          print(
              "--------------------------->${DateTime.now().toString()}<---------------------");
          return ListView.builder(
            itemCount: value.items.length,
            itemBuilder: (context, index) {
              var personInQuestion = value.items[index];
              return Dismissible(
                onDismissed: (direction) {
                  Provider.of<ProviderPersons>(context, listen: false)
                      .removePerson(personInQuestion);
                },
                key: UniqueKey(),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(personInQuestion.firstname),
                  subtitle: Text(personInQuestion.strength),
                  trailing: Text(personInQuestion.cuteness.toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
