import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:jlb_flutter_app_2/main.dart';
import 'package:jlb_flutter_app_2/Builders/ReminderNotificationBuilder.dart';

export 'package:jlb_flutter_app_2/Actions/Reminder.dart';
export 'package:jlb_flutter_app_2/Actions/ReminderNotification.dart';


class RemindersList extends StatelessWidget {
  final List<Reminder> remindersList;
  RemindersList({this.remindersList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: remindersList.length,
        itemBuilder: (context, index) {
          final item = remindersList[index];
          return ListTile(
              title: Row(
                children: <Widget>[
                  Icon(
                    remindersIcons[item.name],
                    color: Colors.black,
                    size: 30.0,
                  ),
                  Text(item.name)
                ],
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Start time: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(df.format(DateTime.parse(item.time))),
                          ],
                        )),
                    Text(Reminder.parseRepeatIntervalToString(item.repeat))
                  ]));
        });
  }
}
