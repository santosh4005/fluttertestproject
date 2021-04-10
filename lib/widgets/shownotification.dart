import 'package:flutter/material.dart';
import 'package:testtodelete/helpers/notifhelper.dart';
import 'package:testtodelete/helpers/notifhelperv2.dart';
import 'package:testtodelete/helpers/notifhelperv3.dart';

class ShowLocalNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Notifications"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Quickie Notification",
                        body: "Quickie Notification body")
                    .showNotification();
              },
              label: Text("Quickie"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Quickie Notification",
                        body: "Quickie Notification body")
                    .cancelAllNotifications();
              },
              label: Text("Cancel"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Quickie Notification",
                        body: "Quickie Notification body")
                    .showInsistentNotification();
              },
              label: Text("Insistent"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "10 sec Notification",
                        body: "10 sec Notification body")
                    .zonedScheduleNotification();
              },
              label: Text("10 sec"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Big picture notification",
                        body: "10 sec Notification body")
                    .showBigPictureNotification();
              },
              label: Text("Big picture notification"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Big picture notification",
                        body: "10 sec Notification body")
                    .showBigTextNotification();
              },
              label: Text("Big text notification"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Big picture notification",
                        body: "10 sec Notification body")
                    .showGroupedNotifications();
              },
              label: Text("Group notification"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Big picture notification",
                        body: "10 sec Notification body")
                    .showIndeterminateProgressNotification();
              },
              label: Text("Indeterminate Progress"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Big picture notification",
                        body: "10 sec Notification body")
                    .getActiveNotifications(context);
              },
              label: Text("Custom sound"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                await NotificationHelperV3(
                        title: "Badge notification",
                        body: "Badge Notification body")
                    .showNotificationWithoutTimestamp();
              },
              label: Text("Badge"),
              icon: Icon(
                Icons.notification_important,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
