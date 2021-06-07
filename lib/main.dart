import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:jlb_flutter_app_2/Actions/Reminder.dart';
import 'package:jlb_flutter_app_2/State/AppState.dart';
import 'package:jlb_flutter_app_2/Store/Store.dart';
import 'package:jlb_flutter_app_2/Actions/FlutterLocalNotificationsPlugin_Settings.dart';
import 'package:jlb_flutter_app_2/Builders/NotificationSwitchBuilder.dart';
import 'package:jlb_flutter_app_2/Builders/ReminderNotificationBuilder.dart';
import 'package:jlb_flutter_app_2/Builders/RemindersListViewBuilder.dart';

export 'package:jlb_flutter_app_2/Actions/Reminder.dart';
export 'package:jlb_flutter_app_2/Actions/ReminderNotification.dart';

/* To Do
-Examine/Improve upon Cancel All button
-Replace deprecated stuff (RaisedButton RAB.dart)
-Comments & organize?
-ReExamine Import vs Export
-File/Folder names (Builder files without builder int the title?)
Rethink 'dialog' names (RAB.dart)
-Naming nomenclature for everything, camelCase no uderscores?
-Get all icons working
-Find new icons for reminders
-ReExamine notification ID numbers
Replace scheduleNotification func (FlutterLocalNotificationsPlugin_Settings) with zonedSchedule func

 */

//Get current Date
final df = new DateFormat('dd-MM-yyyy hh:mm a');
//Define plug in
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
//Define initial store/app state
Store<AppState> store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  //set store equal to initial state defined above
  store = getStore();
  notificationAppLaunchDetails =
  await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);

  runApp(LaunchingApp(store));
}

class LaunchingApp extends StatelessWidget {
  final Store<AppState> store;
  LaunchingApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      child: MaterialApp(
          title: 'REMINDERS',
          home: Scaffold(
            appBar: AppBar(
              title: Text('Reminders App'),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: ReminderNotificationBuilder()),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: NotificationSwitchBuilder()),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Reminders list",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: SizedBox(
                            child: StoreConnector<AppState, List<Reminder>>(
                                converter: (store) =>
                                store.state.remindersState.remindersList,
                                builder: (context, reminders) {
                                  return RemindersList(remindersList: reminders);
                                }),
                            height: Platform.isAndroid ? 420 : 550,
                          ))),
                ],
              ),
            ),
          )),
      store: store,
    );

    ;
  }
}
