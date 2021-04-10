import 'package:flutter/material.dart';

class ShowPopupMenuButton extends StatefulWidget {
  @override
  _ShowPopupMenuButtonState createState() => _ShowPopupMenuButtonState();
}

class _ShowPopupMenuButtonState extends State<ShowPopupMenuButton> {
  Dingisdongis _selectedValue = Dingisdongis.Dingis;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popup Menu Button"),
        actions: [
          PopupMenuButton<Dingisdongis>(
              icon: Icon(Icons.more_vert),
              onSelected: (value) {
                setState(() {
                  _selectedValue = value;
                });
                print(value);
              },
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text("Dingis"),
                    value: Dingisdongis.Dingis,
                  ),
                  PopupMenuItem(
                    child: Text("Dongis"),
                    value: Dingisdongis.Dongis,
                  ),
                ];
              }),
        ],
      ),
      body: Center(
        child: Text(
            "you have selected: ${_selectedValue.toString().split('.').last}"),
      ),
    );
  }
}

enum Dingisdongis {
  Dingis,
  Dongis,
}
