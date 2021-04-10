import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:testtodelete/models/person.dart';

class ProviderCloudFirestore extends ChangeNotifier {
  bool _isLoadedEver = false;
  List<Person> _items = [];
  List<Person> get items {
    if (!_isLoadedEver) fetchAndSetPersons();
    return [..._items];
  }

  Future<void> fetchAndSetPersons() async {
    _isLoadedEver = true;
    var loggedInUser =
        FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";
    var persons = await FirebaseFirestore.instance.collection("persons").get();

    _items.clear();
    persons.docs.forEach((element) {
      _items.add(Person(
        id: element.id,
        createdby: loggedInUser,
        cuteness: element.data()["cuteness"],
        firstname: element.data()["firstname"],
        lastname: element.data()["lastname"],
        strength: element.data()["strength"],
      ));
    });

    notifyListeners();
  }

  Stream<List<Person>> fetchPersonStream() {
    var result = FirebaseFirestore.instance
        .collection("persons")
        .snapshots()
        .map(_getPersonListFromQuerySnapshot);

    return result;
  }

  List<Person> _getPersonListFromQuerySnapshot(QuerySnapshot query) {
    var result = <Person>[];
    var loggedInUser =
        FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";
    try {
      result = query.docs
          .map((e) => Person(
                createdby: loggedInUser,
                id: e.id,
                cuteness: e.data()["cuteness"],
                firstname: e.data()["firstname"],
                lastname: e.data()["lastname"],
                strength: e.data()["strength"],
              ))
          .toList();

      return result;
    } catch (e) {
      return result;
    }
  }

  Stream<List<Person>> get persons {
    return FirebaseFirestore.instance
        .collection("persons")
        .snapshots()
        .map(_getPersonsFromSnapshot);
  }

  List<Person> _getPersonsFromSnapshot(QuerySnapshot snapshot) {
    var loggedInUser =
        FirebaseAuth.instance.currentUser!.displayName ?? "dingleberry";
    try {
      var snapdocs = snapshot.docs
          .map((element) => Person(
                createdby: loggedInUser,
                id: element.id,
                cuteness: element.data()["cuteness"],
                firstname: element.data()["firstname"],
                lastname: element.data()["lastname"],
                strength: element.data()["strength"],
              ))
          .toList();
      return snapdocs;
    } catch (e) {
      print(e.toString());
    }

    return [];
  }

  Future<Person> addPersonToCollection(Person person) async {
    var loggedInUser = FirebaseAuth.instance.currentUser;
    var createdon = DateTime.now();

    var addedPersonDoc =
        await FirebaseFirestore.instance.collection("persons").add({
      "createdby": loggedInUser!.uid,
      "cuteness": person.cuteness,
      "firstname": person.firstname,
      "lastname": person.lastname,
      "strength": person.strength,
      "createdon": createdon,
    });

    var addedPerson = Person(
      id: addedPersonDoc.id,
      createdby: loggedInUser.uid,
      cuteness: person.cuteness,
      firstname: person.firstname,
      lastname: person.lastname,
      strength: person.strength,
    );

    _items.add(addedPerson);
    notifyListeners();
    return addedPerson;
  }

  Future<void> removePersonFromInventory(String id) async {
    await FirebaseFirestore.instance.collection("persons").doc(id).delete();

    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
