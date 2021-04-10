import 'package:flutter/material.dart';
import '../helpers/static_methods.dart';

class ShowChipAndSpacer extends StatefulWidget {
  @override
  _ShowChipAndSpacerState createState() => _ShowChipAndSpacerState();
}

enum ChipAndSpacerEnum {
  Chip,
  Spacer,
}

class _ShowChipAndSpacerState extends State<ShowChipAndSpacer> {
  ChipAndSpacerEnum _titlename = ChipAndSpacerEnum.Chip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${getEnumValueAsString(_titlename.toString())} demo"),
        actions: [
          PopupMenuButton<ChipAndSpacerEnum>(
              onSelected: (value) {
                setState(() {
                  _titlename = value;
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem(
                    child: Text(getEnumValueAsString(
                        ChipAndSpacerEnum.Chip.toString())),
                    value: ChipAndSpacerEnum.Chip,
                  ),
                  PopupMenuItem(
                    child: Text(getEnumValueAsString(
                        ChipAndSpacerEnum.Spacer.toString())),
                    value: ChipAndSpacerEnum.Spacer,
                  ),
                ];
              })
        ],
      ),
      body: Center(
        child: _titlename == ChipAndSpacerEnum.Chip
            ? Chip(
                label: Text(
                  "Chip",
                  style: TextStyle(color: Colors.white),
                ),
                avatar: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColor,
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.purple,
                          Colors.pink,
                          Colors.white,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: Colors.black),
                        top: BorderSide(width: 1.0, color: Colors.black),
                        left: BorderSide(width: 1.0, color: Colors.black),
                        right: BorderSide(width: 1.0, color: Colors.black),
                      )),
                  child: Row(
                    children: [
                      Text("Dingis"),
                      Spacer(),
                      Chip(
                        label: Text(
                          "Chip",
                          style: TextStyle(color: Colors.white),
                        ),
                        avatar: Icon(
                          Icons.supervised_user_circle,
                          color: Colors.white,
                        ),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      Text("Dongis"),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
