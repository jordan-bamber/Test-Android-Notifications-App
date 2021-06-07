import 'package:flutter/material.dart';
import 'package:jlb_flutter_app_2/main.dart';
import 'package:jlb_flutter_app_2/Actions/FlutterLocalNotificationsPlugin_Settings.dart';

//Defines class for UI box?
class NotificationSwitchBuilder extends StatefulWidget {
    @override
    _NotificationSwitchBuilderState createState() => _NotificationSwitchBuilderState();
}

//Actually makes the IO checkbox for the reminders
class _NotificationSwitchBuilderState  extends State<NotificationSwitchBuilder> {
    bool isSwitched = true;

    @override
    Widget build(BuildContext context) {
      return SizedBox(
        child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    if(!value){
                      cancelNotification(flutterLocalNotificationsPlugin);
                    }
                    setState(() {
                      isSwitched = value;
                    });
                  },
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.lightGreenAccent,
                ),
                Text('Cancel All', style: TextStyle(fontWeight: FontWeight.bold)),
          ]))
      );
    }
}