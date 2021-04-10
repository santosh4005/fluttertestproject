import 'package:flutter/material.dart';

class ShowNewButtons extends StatefulWidget {
  @override
  _ShowNewButtonsState createState() => _ShowNewButtonsState();
}

class _ShowNewButtonsState extends State<ShowNewButtons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter 2.0 Buttons"),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.pink,
                  shadowColor: Colors.grey,
                ),
                onPressed: () => _buttonpressedaction("Text button pressed"),
                onLongPress: () =>
                    _buttonpressedaction("Text button long press"),
                child: _buildButton("Text BUtton")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                    elevation: 5.0,
                    onPrimary: Colors.white,
                    primary: Colors.pink),
                onPressed: () =>
                    _buttonpressedaction("Elevated button pressed"),
                onLongPress: () =>
                    _buttonpressedaction("Elevated button long press"),
                child: _buildButton("Elevated Button")),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.pink),
                  primary: Colors.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              onPressed: () => _buttonpressedaction("Outlined button pressed"),
              child: _buildButton("Outlined Button"),
            ),
            TextButton.icon(
              onPressed: () => _buttonpressedaction("Icon button pressed"),
              icon: Icon(Icons.ac_unit),
              label: Text("Icon Text Button"),
            ),
            ElevatedButton.icon(
              onPressed: () =>
                  _buttonpressedaction("Icon Elevated Button Pressed"),
              icon: Icon(Icons.ac_unit),
              label: Text(
                "Icon Elevated Button",
                style: TextStyle(fontSize: 28),
              ),
              style: ElevatedButton.styleFrom(
                  side: BorderSide(color: Colors.blue, width: 4),
                  primary: Colors.pink,
                  elevation: 15,
                  shadowColor: Colors.green.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0))),
            ),
            OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    primary: Colors.pink,
                    side: BorderSide(color: Colors.pink, width: 2.0)),
                onPressed: () =>
                    _buttonpressedaction("Outlined Icon Button Pressed"),
                icon: Icon(Icons.ac_unit),
                label: Text("Icon Outlined Button"))
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return Text(text, style: TextStyle(fontSize: 28));
  }

  void _buttonpressedaction(String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
