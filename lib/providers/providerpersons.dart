import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:testtodelete/helpers/dbhelper.dart';
import 'package:testtodelete/models/person.dart';

class ProviderPersons with ChangeNotifier {
  List<Person> _items = [];
  bool _isLoadedEver = false;

  List<Person> get items {
    if (!_isLoadedEver) fetchPersonRecords();
    return [..._items];
  }

  Future<void> fetchPersonRecords() async {
    var personlistmap = await DBHelper.getData("persons");

    var user = FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";
    _items = personlistmap
        .map((e) => (Person(
            id: DateTime.now().toString(),
            firstname: e["firstname"],
            lastname: e["lastname"],
            strength: e["strength"],
            cuteness: int.tryParse(e["cuteness"].toString()) ?? 0,
            createdby: user)))
        .toList();
    _isLoadedEver = true;
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
      "cuteness": person.cuteness,
    });
  }

  void removePerson(Person person) async {
    _items.remove(person);
    await DBHelper.delete(
        "persons",
        person.firstname +
            person.lastname +
            person.strength +
            person.cuteness.toString());
    notifyListeners();
  }
}
