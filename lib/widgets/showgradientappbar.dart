import 'package:flutter/material.dart';

class ShowGradientAppBar extends StatelessWidget {
  final String title;

  ShowGradientAppBar({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Colors.red, Colors.orange, Colors.yellow],
          )),
        ),
      ),
      body: Center(
        child: Text("Funky Appbar"),
      ),
    );
  }
}
