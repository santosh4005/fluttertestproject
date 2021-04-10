// import 'dart:io';
// import 'dart:typed_data';

// import 'package:device_info/device_info.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart' as path;

// class NotificationHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   AndroidInitializationSettings androidInitializationSettings;
//   IOSInitializationSettings iosInitializationSettings;
//   InitializationSettings initializationSettings;
//   final String title;
//   final String body;

//   NotificationHelper({this.title, this.body}) {
//     tz.initializeTimeZones();
//     initializing();
//   }

//   Future onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//     return CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(body),
//       actions: <Widget>[
//         CupertinoDialogAction(
//             isDefaultAction: true,
//             onPressed: () {
//               // print("");
//             },
//             child: Text("Okay")),
//       ],
//     );
//   }

//   Future<void> onSelectNotification(String payLoad) async {
//     if (payLoad != null) {
//       print(payLoad);
//     }

//     // we can set navigator to navigate another screen
//   }

//   void initializing() async {
//     androidInitializationSettings = AndroidInitializationSettings('app_icon');
//     iosInitializationSettings = IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     initializationSettings = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future<void> showNotification() async {
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             'Channel ID', 'Channel title', 'channel body',
//             priority: Priority.high,
//             importance: Importance.max,
//             ticker: 'cybertruck_notifications');

//     IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(
//         0, title, body, notificationDetails);
//   }

//   Future<String> _downloadAndSaveFile(String url, String fileName) async {
//     final Directory directory = await path.getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';

//     final Uri uri = Uri(path: url);
//     final http.Response response = await http.get(uri);
//     final File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }

//   Future<void> showBigPictureNotificationHiddenLargeIcon() async {
//     final String largeIconPath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/48x48', 'largeIcon');
//     final String bigPicturePath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/400x800', 'bigPicture');
//     final BigPictureStyleInformation bigPictureStyleInformation =
//         BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
//             hideExpandedLargeIcon: true,
//             contentTitle: 'overridden <b>big</b> content title',
//             htmlFormatContentTitle: true,
//             summaryText: 'summary <i>text</i>',
//             htmlFormatSummaryText: true);
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('big text channel id',
//             'big text channel name', 'big text channel description',
//             largeIcon: FilePathAndroidBitmap(largeIconPath),
//             styleInformation: bigPictureStyleInformation);
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics);
//   }

//   Future<void> showNotificationAfterDuration(Duration duration,
//       {int id = 1}) async {
//     var timeDelayed = DateTime.now().add(duration);
//     tz.TZDateTime selectedDate;
//     selectedDate = tz.TZDateTime.from(timeDelayed, tz.local);

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             'second channel ID', 'second Channel title', 'second channel body',
//             priority: Priority.high,
//             importance: Importance.max,
//             ticker: 'cybertruck_notifications');

//     IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: iosNotificationDetails);

//     await _deleteNotificationChannel('second channel ID');

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         id, title, body, selectedDate, notificationDetails,
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   Future<void> _deleteNotificationChannel(var channelId) async {
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.deleteNotificationChannel(channelId);
//   }

//   Future<void> showTimeoutNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('silent channel id', 'silent channel name',
//             'silent channel description',
//             timeoutAfter: 3000,
//             styleInformation: DefaultStyleInformation(true, true));
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, 'timeout notification',
//         'Times out after 3 seconds', platformChannelSpecifics);
//   }

//   Future<void> cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancel(0);
//   }

//   Future<void> showInsistentNotification() async {
//     // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
//     const int insistentFlag = 4;
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker',
//             additionalFlags: Int32List.fromList(<int>[insistentFlag]));
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'insistent title', 'insistent body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithNoBody() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', null, platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithNoTitle() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.show(
//         0, null, 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationCustomSound() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your other channel id',
//       'your other channel name',
//       'your other channel description',
//       sound: RawResourceAndroidNotificationSound('slow_spring_board'),
//     );
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(sound: 'slow_spring_board.aiff');
//     const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics,
//         macOS: macOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'custom sound notification title',
//         'custom sound notification body',
//         platformChannelSpecifics);
//   }

//   Future<void> showNotificationCustomVibrationIconLed() async {
//     final Int64List vibrationPattern = Int64List(4);
//     vibrationPattern[0] = 0;
//     vibrationPattern[1] = 1000;
//     vibrationPattern[2] = 5000;
//     vibrationPattern[3] = 2000;

//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('other custom channel id',
//             'other custom channel name', 'other custom channel description',
//             icon: 'secondary_icon',
//             largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
//             vibrationPattern: vibrationPattern,
//             enableLights: true,
//             color: const Color.fromARGB(255, 255, 0, 0),
//             ledColor: const Color.fromARGB(255, 255, 0, 0),
//             ledOnMs: 1000,
//             ledOffMs: 500);

//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'title of notification with custom vibration pattern, LED and icon',
//         'body of notification with custom vibration pattern, LED and icon',
//         platformChannelSpecifics);
//   }

//   Future<void> zonedScheduleNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'scheduled title',
//         'scheduled body',
//         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//         const NotificationDetails(
//             android: AndroidNotificationDetails('your channel id',
//                 'your channel name', 'your channel description')),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime);
//   }

//   Future<void> showNotificationWithNoSound() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('silent channel id', 'silent channel name',
//             'silent channel description',
//             playSound: false,
//             styleInformation: DefaultStyleInformation(true, true));
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(presentSound: false);
//     const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails(presentSound: false);
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics,
//         macOS: macOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, '<b>silent</b> title',
//         '<b>silent</b> body', platformChannelSpecifics);
//   }

//   Future<String> downloadAndSaveFile(String url, String fileName) async {
//     final Directory directory = await path.getApplicationDocumentsDirectory();
//     final String filePath = '${directory.path}/$fileName';
//     final Uri uri = Uri(path: url);
//     final http.Response response = await http.get(uri);
//     final File file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }

//   Future<void> showBigPictureNotification() async {
//     final String largeIconPath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/48x48', 'largeIcon');
//     final String bigPicturePath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/400x800', 'bigPicture');
//     final BigPictureStyleInformation bigPictureStyleInformation =
//         BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
//             largeIcon: FilePathAndroidBitmap(largeIconPath),
//             contentTitle: 'overridden <b>big</b> content title',
//             htmlFormatContentTitle: true,
//             summaryText: 'summary <i>text</i>',
//             htmlFormatSummaryText: true);
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('big text channel id',
//             'big text channel name', 'big text channel description',
//             styleInformation: bigPictureStyleInformation);
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics);
//   }

//   Future<void> showNotificationMediaStyle() async {
//     final String largeIconPath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/128x128/00FF00/000000', 'largeIcon');
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'media channel id',
//       'media channel name',
//       'media channel description',
//       largeIcon: FilePathAndroidBitmap(largeIconPath),
//       styleInformation: const MediaStyleInformation(),
//     );
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'notification title', 'notification body', platformChannelSpecifics);
//   }

//   Future<void> showBigTextNotification() async {
//     const BigTextStyleInformation bigTextStyleInformation =
//         BigTextStyleInformation(
//       'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//       htmlFormatBigText: true,
//       contentTitle: 'overridden <b>big</b> content title',
//       htmlFormatContentTitle: true,
//       summaryText: 'summary <i>text</i>',
//       htmlFormatSummaryText: true,
//     );
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('big text channel id',
//             'big text channel name', 'big text channel description',
//             styleInformation: bigTextStyleInformation);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics);
//   }

//   Future<void> showGroupedNotifications() async {
//     const String groupKey = 'com.android.example.WORK_EMAIL';
//     const String groupChannelId = 'grouped channel id';
//     const String groupChannelName = 'grouped channel name';
//     const String groupChannelDescription = 'grouped channel description';
//     // example based on https://developer.android.com/training/notify-user/group.html
//     const AndroidNotificationDetails firstNotificationAndroidSpecifics =
//         AndroidNotificationDetails(
//             groupChannelId, groupChannelName, groupChannelDescription,
//             importance: Importance.max,
//             priority: Priority.high,
//             groupKey: groupKey);
//     const NotificationDetails firstNotificationPlatformSpecifics =
//         NotificationDetails(android: firstNotificationAndroidSpecifics);
//     await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
//         'You will not believe...', firstNotificationPlatformSpecifics);
//     const AndroidNotificationDetails secondNotificationAndroidSpecifics =
//         AndroidNotificationDetails(
//             groupChannelId, groupChannelName, groupChannelDescription,
//             importance: Importance.max,
//             priority: Priority.high,
//             groupKey: groupKey);
//     const NotificationDetails secondNotificationPlatformSpecifics =
//         NotificationDetails(android: secondNotificationAndroidSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         2,
//         'Jeff Chang',
//         'Please join us to celebrate the...',
//         secondNotificationPlatformSpecifics);

//     // Create the summary notification to support older devices that pre-date
//     /// Android 7.0 (API level 24).
//     ///
//     /// Recommended to create this regardless as the behaviour may vary as
//     /// mentioned in https://developer.android.com/training/notify-user/group
//     const List<String> lines = <String>[
//       'Alex Faarborg  Check this out',
//       'Jeff Chang    Launch Party'
//     ];
//     const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
//         lines,
//         contentTitle: '2 messages',
//         summaryText: 'janedoe@example.com');
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             groupChannelId, groupChannelName, groupChannelDescription,
//             styleInformation: inboxStyleInformation,
//             groupKey: groupKey,
//             setAsGroupSummary: true);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         3, 'Attention', 'Two messages', platformChannelSpecifics);
//   }

//   Future<void> checkPendingNotificationRequests(BuildContext context) async {
//     final List<PendingNotificationRequest> pendingNotificationRequests =
//         await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content:
//             Text('${pendingNotificationRequests.length} pending notification '
//                 'requests'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   Future<void> showOngoingNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ongoing: true,
//             autoCancel: false);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
//         'ongoing notification body', platformChannelSpecifics);
//   }

//   Future<void> repeatNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('repeating channel id',
//             'repeating channel name', 'repeating description');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
//         'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
//         androidAllowWhileIdle: true);
//   }

//   Future<void> scheduleDailyTenAMNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'daily scheduled notification title',
//         'daily scheduled notification body',
//         _nextInstanceOfTenAM(),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//               'daily notification channel id',
//               'daily notification channel name',
//               'daily notification description'),
//         ),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.time);
//   }

//   Future<void> scheduleWeeklyTenAMNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'weekly scheduled notification title',
//         'weekly scheduled notification body',
//         _nextInstanceOfTenAM(),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//               'weekly notification channel id',
//               'weekly notification channel name',
//               'weekly notificationdescription'),
//         ),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
//   }

//   Future<void> scheduleWeeklyMondayTenAMNotification() async {
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//         0,
//         'weekly scheduled notification title',
//         'weekly scheduled notification body',
//         _nextInstanceOfMondayTenAM(),
//         const NotificationDetails(
//           android: AndroidNotificationDetails(
//               'weekly notification channel id',
//               'weekly notification channel name',
//               'weekly notificationdescription'),
//         ),
//         androidAllowWhileIdle: true,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
//   }

//   tz.TZDateTime _nextInstanceOfTenAM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   tz.TZDateTime _nextInstanceOfMondayTenAM() {
//     tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
//     while (scheduledDate.weekday != DateTime.monday) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   Future<void> showNotificationWithNoBadge() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'no badge channel', 'no badge name', 'no badge description',
//             channelShowBadge: false,
//             importance: Importance.max,
//             priority: Priority.high,
//             onlyAlertOnce: true);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'no badge title', 'no badge body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showProgressNotification() async {
//     const int maxProgress = 5;
//     for (int i = 0; i <= maxProgress; i++) {
//       await Future<void>.delayed(const Duration(seconds: 1), () async {
//         final AndroidNotificationDetails androidPlatformChannelSpecifics =
//             AndroidNotificationDetails('progress channel', 'progress channel',
//                 'progress channel description',
//                 channelShowBadge: false,
//                 importance: Importance.max,
//                 priority: Priority.high,
//                 onlyAlertOnce: true,
//                 showProgress: true,
//                 maxProgress: maxProgress,
//                 progress: i);
//         final NotificationDetails platformChannelSpecifics =
//             NotificationDetails(android: androidPlatformChannelSpecifics);
//         await flutterLocalNotificationsPlugin.show(
//             0,
//             'progress notification title',
//             'progress notification body',
//             platformChannelSpecifics,
//             payload: 'item x');
//       });
//     }
//   }

//   Future<void> showIndeterminateProgressNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'indeterminate progress channel',
//             'indeterminate progress channel',
//             'indeterminate progress channel description',
//             channelShowBadge: false,
//             importance: Importance.max,
//             priority: Priority.high,
//             onlyAlertOnce: true,
//             showProgress: true,
//             indeterminate: true);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'indeterminate progress notification title',
//         'indeterminate progress notification body',
//         platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationUpdateChannelDescription() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             'your updated channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             channelAction: AndroidNotificationChannelAction.update);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'updated notification channel',
//         'check settings to see updated channel description',
//         platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showPublicNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker',
//             visibility: NotificationVisibility.public);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, 'public notification title',
//         'public notification body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithSubtitle() async {
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(subtitle: 'the subtitle');
//     const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails(subtitle: 'the subtitle');
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'title of notification with a subtitle',
//         'body of notification with a subtitle',
//         platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithIconBadge() async {
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(badgeNumber: 1);
//     const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails(badgeNumber: 1);
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'icon badge title', 'icon badge body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithoutTimestamp() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//             'your channel id', 'your channel name', 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             showWhen: false);
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithCustomTimestamp() async {
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
//     );
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithChronometer() async {
//     final AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
//     );
//     final NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> showNotificationWithAttachment() async {
//     final String bigPicturePath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/600x200', 'bigPicture.jpg');
//     final IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(attachments: <IOSNotificationAttachment>[
//       IOSNotificationAttachment(bigPicturePath)
//     ]);
//     final MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails(attachments: <MacOSNotificationAttachment>[
//       MacOSNotificationAttachment(bigPicturePath)
//     ]);
//     final NotificationDetails notificationDetails = NotificationDetails(
//         iOS: iOSPlatformChannelSpecifics, macOS: macOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'notification with attachment title',
//         'notification with attachment body',
//         notificationDetails);
//   }

//   Future<void> createNotificationChannelGroup(BuildContext context) async {
//     const String channelGroupId = 'your channel group id';
//     // create the group first
//     const AndroidNotificationChannelGroup androidNotificationChannelGroup =
//         AndroidNotificationChannelGroup(
//             channelGroupId, 'your channel group name',
//             description: 'your channel group description');
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         .createNotificationChannelGroup(androidNotificationChannelGroup);

//     // create channels associated with the group
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         .createNotificationChannel(const AndroidNotificationChannel(
//             'grouped channel id 1',
//             'grouped channel name 1',
//             'grouped channel description 1',
//             groupId: channelGroupId));

//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         .createNotificationChannel(const AndroidNotificationChannel(
//             'grouped channel id 2',
//             'grouped channel name 2',
//             'grouped channel description 2',
//             groupId: channelGroupId));

//     await showDialog<void>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//               content: Text('Channel group with name '
//                   '${androidNotificationChannelGroup.name} created'),
//               actions: <Widget>[
//                 FlatButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             ));
//   }

//   Future<void> deleteNotificationChannelGroup(BuildContext context) async {
//     const String channelGroupId = 'your channel group id';
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.deleteNotificationChannelGroup(channelGroupId);

//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: const Text('Channel group with id $channelGroupId deleted'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> createNotificationChannel(BuildContext context) async {
//     const AndroidNotificationChannel androidNotificationChannel =
//         AndroidNotificationChannel(
//       'your channel id 2',
//       'your channel name 2',
//       'your channel description 2',
//     );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(androidNotificationChannel);

//     await showDialog<void>(
//         context: context,
//         builder: (BuildContext context) => AlertDialog(
//               content:
//                   Text('Channel with name ${androidNotificationChannel.name} '
//                       'created'),
//               actions: <Widget>[
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             ));
//   }

//   Future<void> deleteNotificationChannel(BuildContext context) async {
//     const String channelId = 'your channel id 2';
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.deleteNotificationChannel(channelId);

//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: const Text('Channel with id $channelId deleted'),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> getActiveNotifications(BuildContext context) async {
//     final Widget activeNotificationsDialogContent =
//         await getActiveNotificationsDialogContent();
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: activeNotificationsDialogContent,
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Widget> getActiveNotificationsDialogContent() async {
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     if (!(androidInfo.version.sdkInt >= 23)) {
//       return const Text(
//         '"getActiveNotifications" is available only for Android 6.0 or newer',
//       );
//     }

//     try {
//       final List<ActiveNotification> activeNotifications =
//           await flutterLocalNotificationsPlugin
//               .resolvePlatformSpecificImplementation<
//                   AndroidFlutterLocalNotificationsPlugin>()
//               ?.getActiveNotifications();

//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           const Text(
//             'Active Notifications',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const Divider(color: Colors.black),
//           if (activeNotifications.isEmpty)
//             const Text('No active notifications'),
//           if (activeNotifications.isNotEmpty)
//             for (ActiveNotification activeNotification in activeNotifications)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     'id: ${activeNotification.id}\n'
//                     'channelId: ${activeNotification.channelId}\n'
//                     'title: ${activeNotification.title}\n'
//                     'body: ${activeNotification.body}',
//                   ),
//                   const Divider(color: Colors.black),
//                 ],
//               ),
//         ],
//       );
//     } on PlatformException catch (error) {
//       return Text(
//         'Error calling "getActiveNotifications"\n'
//         'code: ${error.code}\n'
//         'message: ${error.message}',
//       );
//     }
//   }
// }
