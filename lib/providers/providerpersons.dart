import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:testtodelete/helpers/dbhelper.dart';
import 'package:testtodelete/models/person.dart';

class ProviderPersons with ChangeNotifier {
  List<Person> _items = [];

  List<Person> get items {
    return [..._items];
  }

  Future<void> fetchPersonRecords() async {
    var personlistmap = await DBHelper.getData("persons");
    _items = personlistmap
        .map((e) => (Person(
            e["firstname"], e["lastname"], e["strength"], e["cuteness"])))
        .toList();
    notifyListeners();
  }

  void addPerson(Person person) async {
    _items.add(person);
    notifyListeners();
    await DBHelper.insert("persons", {
      "id": person.firstname +
          person.lastname +
          person.strength +
          person.cuteness.toString(),
      "firstname": person.firstname,
      "lastname": person.lastname,
      "strength": person.strength,
      "cuteness": person.cuteness
    });
  }
}
