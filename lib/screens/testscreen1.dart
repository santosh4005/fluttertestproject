import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtodelete/providers/providergooglesigin.dart';
import 'package:testtodelete/widgets/showCloudStore.dart';
import 'package:testtodelete/widgets/showSearchAbility.dart';
import 'package:testtodelete/widgets/showStreamStuff.dart';
import 'package:testtodelete/widgets/showchipandspacer.dart';
import 'package:testtodelete/widgets/showdatepicker.dart';
import 'package:testtodelete/widgets/showdismissable.dart';
import 'package:testtodelete/widgets/showform.dart';
import 'package:testtodelete/widgets/showgradientappbar.dart';
import 'package:testtodelete/widgets/showimagestuff.dart';
import 'package:testtodelete/widgets/showlistreverse.dart';
import 'package:testtodelete/widgets/shownewbuttons.dart';
import 'package:testtodelete/widgets/shownotification.dart';
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
            ShowDatePickerControl(),
            null),
        CustomGridTile(
            "Text Field",
            Icon(Icons.settings, size: 80, color: Colors.green),
            ShowTextField(),
            null),
        CustomGridTile(
            "Popupmenu",
            Icon(Icons.settings, size: 80, color: Colors.orange),
            ShowPopupMenuButton(),
            null),
        CustomGridTile(
            "Chip & Spacer",
            Icon(Icons.settings, size: 80, color: Colors.orange),
            ShowChipAndSpacer(),
            null),
        CustomGridTile(
            "Dismissable",
            Icon(Icons.settings, size: 80, color: Colors.purple),
            ShowDismissable(),
            null),
        CustomGridTile(
            "Form",
            Icon(Icons.settings, size: 80, color: Colors.cyan),
            ShowFormWidget(),
            null),
        CustomGridTile(
            "Slider",
            Icon(Icons.settings, size: 80, color: Colors.grey),
            ShowSlider(),
            null),
        CustomGridTile(
            "Search",
            Icon(Icons.settings, size: 80, color: Colors.teal),
            ShowSearchAbility(),
            null),
        CustomGridTile(
            "Provider",
            Icon(Icons.settings, size: 80, color: Colors.blue),
            ShowProvider(),
            null),
        CustomGridTile(
            "Consumer",
            Icon(Icons.settings, size: 80, color: Colors.pink),
            ShowProviderConsumer(),
            null),
        CustomGridTile(
            "Notification",
            Icon(Icons.settings, size: 80, color: Colors.teal),
            ShowLocalNotification(),
            null),
        CustomGridTile(
            "Signout",
            Icon(Icons.settings, size: 80, color: Colors.pink),
            ShowCloudStoreDemo(),
            Provider.of<ProviderGoogleSignin>(context, listen: false).logout),
        CustomGridTile(
            "Cloud",
            Icon(Icons.settings, size: 80, color: Colors.teal),
            ShowCloudStoreDemo(),
            null),
        CustomGridTile(
            "Funkyappbar",
            Icon(Icons.settings, size: 80, color: Colors.pink),
            ShowGradientAppBar(
              title: "Funky as hell",
            ),
            null),
        CustomGridTile(
            "Streams",
            Icon(Icons.settings, size: 80, color: Colors.teal),
            ShowStreamStuff(),
            null),
        CustomGridTile(
            "ReverseList",
            Icon(Icons.settings, size: 80, color: Colors.pink),
            ShowListReverse(),
            null),
        CustomGridTile(
            "Images",
            Icon(Icons.settings, size: 80, color: Colors.teal),
            ShowImageStuff(),
            null),
        CustomGridTile(
            "New Buttons",
            Icon(Icons.settings, size: 80, color: Colors.pink),
            ShowNewButtons(),
            null),
      ],
    );
  }
}

class CustomGridTile<Tingle> extends StatelessWidget {
  final String name;
  final Icon icon;
  final Widget creator;
  final void Function()? action;

  CustomGridTile(this.name, this.icon, this.creator, this.action);

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
          if (action != null) {
            action!();
          } else
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
