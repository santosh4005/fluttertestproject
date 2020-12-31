import 'package:flutter/material.dart';
import 'package:testtodelete/models/searchitem.dart';

class ShowSearchAbility extends StatefulWidget {
  @override
  _ShowSearchAbilityState createState() => _ShowSearchAbilityState();
}

class _ShowSearchAbilityState extends State<ShowSearchAbility> {
  List<SearchItem> _searchItems;

  @override
  void initState() {
    _searchItems = [
      SearchItem(name: "Santosh", location: "Minneapolis"),
      SearchItem(name: "Amy", location: "St. Paul"),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Demo"),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: PeopleSearch(sItems: _searchItems));
              })
        ],
      ),
    );
  }
}

class PeopleSearch extends SearchDelegate<SearchItem> {
  List<SearchItem> sItems;

  PeopleSearch({this.sItems});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionlist = query.isEmpty
        ? sItems.take(1).toList()
        : sItems
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionlist.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionlist[index].name),
          subtitle: Text(suggestionlist[index].location),
        );
      },
    );
  }
}
