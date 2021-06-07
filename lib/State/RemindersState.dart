import 'package:jlb_flutter_app_2/Actions/Reminder.dart';
import 'package:meta/meta.dart';

//should this be immutable?
@immutable
class RemindersState{
  final List<Reminder> remindersList;

  RemindersState({this.remindersList});

  //initialize with empty list of reminders
  factory RemindersState.initial(){
    return new RemindersState(remindersList: []);
  }

  RemindersState copyWith({List<Reminder> remindersList}){
    return RemindersState(remindersList: remindersList ?? this.remindersList);
  }

  static RemindersState fromJson(dynamic json) {
    return json != null
        ? RemindersState(
      remindersList: parseList(json),
    )
        : [];
  }

  dynamic toJson() {
    return {
      'reminders': this.remindersList.map((reminder) => reminder.toJson()).toList()
    };
  }
}

List<Reminder> parseList(dynamic json) {
  List<Reminder> list = new List<Reminder>();
  json["reminders"].forEach((item) => list.add(Reminder.fromJson(item)));
  return list;
}
