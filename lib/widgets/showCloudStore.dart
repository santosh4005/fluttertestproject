import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providercloudfstore.dart';
import 'package:testtodelete/widgets/showdismissable.dart';

class ShowCloudStoreDemo extends StatefulWidget {
  @override
  _ShowCloudStoreDemoState createState() => _ShowCloudStoreDemoState();
}

class _ShowCloudStoreDemoState extends State<ShowCloudStoreDemo> {
  @override
  Widget build(BuildContext context) {
    var clProvider =
        Provider.of<ProviderCloudFirestore>(context, listen: false);
    var user = FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";

    return Scaffold(
        appBar: AppBar(
          title: Text("Cloud Store"),
          actions: [
            IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () {
                clProvider.addPersonToCollection(Person(
                    id: DateTime.now().toString(),
                    createdby: user,
                    firstname: "Ding",
                    lastname: "Dong",
                    cuteness: 5,
                    strength: "door bell sound"));
              },
            )
          ],
        ),
        body: StreamBuilder<List<Person>>(
          stream: clProvider.persons,
          builder: (context, snapshot) {
            List<Person> personlist = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Waiting...."));
            }
            if (snapshot.hasData) {
              personlist = snapshot.data!;
              return ListView.builder(
                itemCount: personlist.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                      onDismissed: (direction) async {
                        print("removing ${personlist[index]}");
                        await clProvider
                            .removePersonFromInventory(personlist[index].id);
                      },
                      confirmDismiss: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    "Whoa! ${personlist[index].createdby} created this!"),
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
                      key: ValueKey(personlist[index]),
                      child: Card(
                        child: StupidListTile(
                            subtitle: personlist[index].strength,
                            title: personlist[index].firstname +
                                " " +
                                personlist[index].lastname),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ));
                },
              );
            } else
              return Center(child: Text("No Data Avaialble"));
          },
        ));
  }
}
