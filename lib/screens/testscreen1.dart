import 'package:flutter/material.dart';
import 'package:testtodelete/widgets/showdatepicker.dart';
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
            Icon(
              Icons.settings,
              size: 80,
              color: Colors.red,
            ),
            ShowDatePickerControl()),
        CustomGridTile(
            "Text Field",
            Icon(
              Icons.settings,
              size: 80,
              color: Colors.green,
            ),
            ShowTextField()),
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
        },
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
