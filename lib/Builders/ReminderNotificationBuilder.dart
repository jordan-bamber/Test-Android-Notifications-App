import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:jlb_flutter_app_2/main.dart';
import 'package:jlb_flutter_app_2/Actions/Actions.dart';
import 'package:jlb_flutter_app_2/Store/Store.dart';
import 'package:jlb_flutter_app_2/Actions/FlutterLocalNotificationsPlugin_Settings.dart';
import 'ReminderCustomItem.dart';
import 'ReminderItem.dart';

export 'package:jlb_flutter_app_2/Actions/Reminder.dart';
export 'package:jlb_flutter_app_2/Actions/ReminderNotification.dart';

const String mindBodyBalance = 'Mindy/Body Balance';
const String questForSunshine = 'Quest for Sunshine';
const String drinkWater = 'Drink Water';
const String dreamAboutBasketball = 'Dream about Basketball';
const String custom = 'Custom time';

const remindersIcons = {
  mindBodyBalance: Icons.audiotrack,
  questForSunshine: Icons.local_florist,
  drinkWater: Icons.directions_walk,
  dreamAboutBasketball: Icons.local_drink,
  custom: Icons.image,
};

class ReminderNotificationBuilder extends StatefulWidget {

    //Widget Keys
    ReminderNotificationBuilder({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _ReminderNotificationBuilderState createState() => _ReminderNotificationBuilderState();
}

class _ReminderNotificationBuilderState extends State<ReminderNotificationBuilder> {

  bool mindBodyBalanceReminder = false;
  bool questForSunshineReminder = false;
  bool drinkWaterReminder = false;
  bool dreamAboutBasketballReminder = false;
  bool customReminder = false;

  double margin = Platform.isIOS ? 10 : 5;
  TimeOfDay customNotificationTime;

  @override
  Widget build(BuildContext context) {
    _prepareState();
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Manage reminders'),
              color: Colors.blue,
              onPressed: _showMaterialDialog,
              textColor: Colors.white,
            ),
          ],
      ),
    );
  }//End Widget build

//showMaterialDialog
  _showMaterialDialog() {

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: Colors.white,
          content:  StatefulBuilder(
            builder: (BuildContext context, StateSetter setState){
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 80,
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding (
                        padding: new EdgeInsets.only(bottom: margin),
                        child: Text(
                            'Remind me everyday',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w500),
                          )),
                      ReminderItem(
                        onChanged: (value) {
                          setState(() { mindBodyBalanceReminder = value;});
                            _configureMindBodyBalance(value);
                          },
                          checkBoxValue: mindBodyBalanceReminder,
                          iconName: mindBodyBalance,
                      ),
                      Padding(
                          padding: new EdgeInsets.only(
                              bottom: margin, top: margin),
                          child: Text(
                            'Remind me every week',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500),
                          )),
                      ReminderItem(
                        onChanged: (value) {
                          setState(() {
                            questForSunshineReminder = value;
                          });
                          _configureQuestForSunshine(value);
                        },
                        checkBoxValue: questForSunshineReminder,
                        iconName: questForSunshine,
                      ),
                      Padding(
                          padding: new EdgeInsets.only(
                              bottom: margin, top: margin),
                          child: Text(
                            'Remind me every hour',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500),
                          )),
                      ReminderItem(
                        onChanged: (value) {
                          setState(() {
                            drinkWaterReminder = value;
                          });
                          _configureDrinkWater(value);
                        },
                        checkBoxValue: drinkWaterReminder,
                        iconName: drinkWater,
                      ),
                      Padding(
                          padding: new EdgeInsets.only(
                              bottom: margin, top: margin),
                          child: Text(
                            'Remind me every minute',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500),
                          )),
                      ReminderItem(
                        onChanged: (value) {
                          setState(() {
                            dreamAboutBasketballReminder = value;
                          });
                          _configureDreamAboutBasketball(value);
                        },
                        checkBoxValue: dreamAboutBasketballReminder,
                        iconName: dreamAboutBasketball,
                      ),
                      Padding(
                          padding: new EdgeInsets.only(
                              bottom: margin, top: margin),
                          child: Text(
                            'Custom',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500),
                          )),
                      ReminderCustomItem(
                        checkBoxValue: customReminder,
                        iconName: custom,
                        onChanged: (value) {
                          setState(() {
                            customReminder = value;
                          });
                          _configureCustomReminder(value);
                        },
                        showTimeDialog: () {
                          _showTimeDialog(setState);
                        },
                      ),
                      Padding(
                        padding: new EdgeInsets.only(
                            top: margin * 2, bottom: margin),
                        child: RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
               ),
              );
            }));
        }); //Shape, Builder
  }// showMaterialDialog func


//showTimeDialog
  _showTimeDialog(StateSetter setState) async {

    TimeOfDay selectedTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    setState((){
      customNotificationTime = selectedTime;
      customReminder = true;
    });

    _configureCustomReminder(true);
  }

//prepareState
  _prepareState() {

    List<Reminder> list = getStore().state.remindersState.remindersList;

    list.forEach((item){
      switch (item.name) {
        case mindBodyBalance:
          mindBodyBalanceReminder = true;
          break;
        case questForSunshine:
          questForSunshineReminder = true;
          break;
        case drinkWater:
          drinkWaterReminder = true;
          break;
        case dreamAboutBasketball:
          dreamAboutBasketballReminder = true;
          break;
        case custom:
          customReminder = true;
          break;
      }
    });
  }


//configure each of the 5 reminders

  void _configureMindBodyBalance(bool value){

    if(value){
      getStore().dispatch(
        SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: mindBodyBalance,
          repeat: RepeatInterval.daily
      ));//dispatch

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '0', mindBodyBalance, RepeatInterval.daily);
    }
    else {
      cancelNotificationByID(flutterLocalNotificationsPlugin, 0);
      getStore().dispatch(RemoveReminderAction(mindBodyBalance));
    }
  }

  void _configureQuestForSunshine(bool value){

    if(value){
      getStore().dispatch(
        SetReminderAction(
        time: new DateTime.now().toIso8601String(),
        name: questForSunshine,
        repeat: RepeatInterval.weekly
      ));//dispatch

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '1', questForSunshine, RepeatInterval.weekly);
    }
    else {
      cancelNotificationByID(flutterLocalNotificationsPlugin, 1);
      getStore().dispatch(RemoveReminderAction(questForSunshine));
    }
  }

  void _configureDrinkWater(bool value){

    if(value){
      getStore().dispatch(
        SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: drinkWater,
          repeat: RepeatInterval.hourly
      ));//dispatch

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '2', drinkWater, RepeatInterval.hourly);
    }
    else {
      cancelNotificationByID(flutterLocalNotificationsPlugin, 2);
      getStore().dispatch(RemoveReminderAction(drinkWater));
    }
  }

  void _configureDreamAboutBasketball(bool value){

    if(value){
      getStore().dispatch(
        SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: dreamAboutBasketball,
          repeat: RepeatInterval.everyMinute
    ));//dispatch

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '3', dreamAboutBasketball, RepeatInterval.everyMinute);
    }
    else {
      cancelNotificationByID(flutterLocalNotificationsPlugin, 3);
      getStore().dispatch(RemoveReminderAction(dreamAboutBasketball));
    }
  }

  void _configureCustomReminder(bool value){
    if (customNotificationTime != null){
      if(value){
        var now = new DateTime.now();
        var notificationTime = new DateTime(now.year, now.month, now.day, customNotificationTime.hour, customNotificationTime.minute);

        getStore().dispatch(
          SetReminderAction(
            time: new DateTime.now().toIso8601String(),
            name: custom,
            repeat: RepeatInterval.daily
      ));//dispatch

        scheduleNotification(flutterLocalNotificationsPlugin, '4', custom, notificationTime);
      }
      else {
        cancelNotificationByID(flutterLocalNotificationsPlugin, 4);
        getStore().dispatch(RemoveReminderAction(custom));
      }
    }
  }


}//End class