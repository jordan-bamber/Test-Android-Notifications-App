import 'package:meta/meta.dart';

//Why does this ReminderNotification class not have convert JSON & Parse methods like Reminder class?

//Define ReminderNotification Class, Vars & Object
class ReminderNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  ReminderNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });
}
