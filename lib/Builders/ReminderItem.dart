import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:jlb_flutter_app_2/Builders/ReminderNotificationBuilder.dart';

//rename or move this file???????? Builder or no?

class ReminderItem extends StatelessWidget {
    final bool checkBoxValue;
    final void Function(bool) onChanged;
    final String iconName;

    ReminderItem({this.checkBoxValue, this.onChanged, this.iconName});

    Widget build(BuildContext context) {

      //iOS Only
      double margin = Platform.isIOS ? 10 : 5;

      return Card(
          margin: new EdgeInsets.only(left: 0.0, right: 0.0, top: margin),
          child: CheckboxListTile(
              value: checkBoxValue,
              onChanged: onChanged,
            title: Row(children: <Widget>[
              Expanded( flex: 1,
                  child: Row(
                  children: <Widget>[
                    Expanded(flex:1, child: Icon(
                      remindersIcons[iconName],
                      color: Colors.cyan,
                      size: 30.0,
                    )),
                  Expanded(flex:1 , child:Padding(
                      padding: new EdgeInsets.only(left: margin),
                      child: Text(
                        iconName,
                        style: TextStyle(
                          fontSize:  16,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                        ))),
                ],
                  ),)
            ])));
    }


}