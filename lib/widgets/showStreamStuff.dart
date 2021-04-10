import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/models/person.dart';
import 'package:testtodelete/providers/providercloudfstore.dart';

class ShowStreamStuff extends StatefulWidget {
  @override
  _ShowStreamStuffState createState() => _ShowStreamStuffState();
}

class _ShowStreamStuffState extends State<ShowStreamStuff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Live Stream"),
        ),
        body: StreamBuilder<List<Person>>(
          stream:
              Provider.of<ProviderCloudFirestore>(context).fetchPersonStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].firstname +
                        ' ' +
                        snapshot.data![index].lastname),
                    subtitle: Text(snapshot.data![index].strength),
                    trailing: Text(snapshot.data![index].cuteness.toString()),
                  );
                },
              );
            }
            return Center(
              child: Text("Bingo Bango"),
            );
          },
        ));
  }
}
