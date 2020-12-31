import 'package:flutter/material.dart';

class ShowSlider extends StatefulWidget {
  @override
  _ShowSliderState createState() => _ShowSliderState();
}

class _ShowSliderState extends State<ShowSlider> {
  double _selectedValue = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider Demo ${_selectedValue.toStringAsFixed(1)}"),
      ),
      body: Center(
        child: Slider(
          max: 10,
          min: 1,
          inactiveColor: Colors.pink,
          activeColor: Colors.purple,
          value: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}
