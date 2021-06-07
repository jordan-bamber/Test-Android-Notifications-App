import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

//Define Reminder class

class Reminder {

  final String time;
  final RepeatInterval repeat;
  final String name;

  const Reminder({
    @required this.time,
    @required this.repeat,
    @required this.name,
  });

  //Parse RepeatInterval to String from Value
  static String parseRepeatIntervalToString(RepeatInterval repeat) {
    switch (repeat) {
      case RepeatInterval.daily:
        return "Daily";
      case RepeatInterval.everyMinute:
        return "EveryMinute";
      case RepeatInterval.hourly:
        return "Hourly";
      case RepeatInterval.weekly:
        return "Weekly";
      default:
        return "Daily";
    }
  }

  //Parse RepeatInterval to Value from String
  static RepeatInterval parseRepeatIntervalToValue(String repeat) {
    switch (repeat) {
      case "Daily":
        return RepeatInterval.daily;
      case "EveryMinute":
        return RepeatInterval.everyMinute;
      case "Hourly":
        return RepeatInterval.hourly;
      case "Weekly":
        return RepeatInterval.weekly;
      default:
        return RepeatInterval.weekly;
    }
  }

  //Convert from Json if exists?
  static Reminder fromJson(dynamic json) {
    return json != null
        ? new Reminder(
        time: json["time"],
        repeat: parseRepeatIntervalToValue(json["repeat"]),
        name: json["name"])
        : null;
  }

  //Convert to Json
  dynamic toJson() {
    return {
      "time": time,
      "repeat": parseRepeatIntervalToString(repeat),
      "name": name,
    };
  }
}