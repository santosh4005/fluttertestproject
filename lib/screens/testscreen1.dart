import 'package:flutter/material.dart';
import 'package:testtodelete/widgets/showSearchAbility.dart';
import 'package:testtodelete/widgets/showchipandspacer.dart';
import 'package:testtodelete/widgets/showdatepicker.dart';
import 'package:testtodelete/widgets/showdismissable.dart';
import 'package:testtodelete/widgets/showform.dart';
import 'package:testtodelete/widgets/showpopupmenubutton.dart';
import 'package:testtodelete/widgets/showprovider.dart';
import 'package:testtodelete/widgets/showproviderconsumer.dart';
import 'package:testtodelete/widgets/showslider.dart';
import 'package:testtodelete/widgets/showtextfield.dart';

class TestScreen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      children: <Widget>[
        CustomGridTile(
            "Date",
            Icon(Icons.settings, size: 80, color: Colors.red),
            ShowDatePickerControl()),
        CustomGridTile(
            "Text Field",
            Icon(Icons.settings, size: 80, color: Colors.green),
            ShowTextField()),
        CustomGridTile(
            "Popupmenu",
            Icon(Icons.settings, size: 80, color: Colors.orange),
            ShowPopupMenuButton()),
        CustomGridTile(
            "Chip & Spacer",
            Icon(Icons.settings, size: 80, color: Colors.orange),
            ShowChipAndSpacer()),
        CustomGridTile(
            "Dismissable",
            Icon(Icons.settings, size: 80, color: Colors.purple),
            ShowDismissable()),
        CustomGridTile(
            "Form",
            Icon(Icons.settings, size: 80, color: Colors.cyan),
            ShowFormWidget()),
        CustomGridTile("Slider",
            Icon(Icons.settings, size: 80, color: Colors.grey), ShowSlider()),
        CustomGridTile(
            "Search",
            Icon(Icons.settings, size: 80, color: Colors.teal),
            ShowSearchAbility()),
        CustomGridTile("Provider",
            Icon(Icons.settings, size: 80, color: Colors.blue), ShowProvider()),
        CustomGridTile(
            "Consumer",
            Icon(Icons.settings, size: 80, color: Colors.pink),
            ShowProviderConsumer()),
      ],
    );
  }
}

class CustomGridTile<Tingle> extends StatelessWidget {
  final String name;
  final Icon icon;
  final Widget creator;

  CustomGridTile(this.name, this.icon, this.creator);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        title: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      child: InkWell(
        splashColor: Theme.of(context).primaryColor,
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return creator;
          }));
        }, //testing git pull
        child: Card(
          // color: Colors.transparent,
          child: icon,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
