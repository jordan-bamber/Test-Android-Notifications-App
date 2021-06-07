import 'package:jlb_flutter_app_2/State/RemindersState.dart';
//import 'RemindersState.dart';
import 'package:meta/meta.dart';


//Define AppState class
@immutable
class AppState{
  final RemindersState remindersState;

  AppState({@required this.remindersState});

  //Sets the initial AppState for all instances of AppState class?
  //Factory keyword ensures return type is same as class type
  factory AppState.initial(){
    return AppState(remindersState: RemindersState.initial(),);
  }

  //copyWith function used to create new copy of AppState to maintain unidirectional data flow
  // If a null reminderState is passed to this func, it instead assigns the current app state, thus the AppState is never null
  AppState copyWith({RemindersState remindersState}){
      return AppState(remindersState: remindersState ?? this.remindersState);
  }

  //Used once: Store.dart line 24
  static AppState fromJson(dynamic json) {
    return json != null
        ? AppState(
        remindersState: RemindersState.fromJson(json["remindersState"]))
        : {};
  }

  //Not used?
  dynamic toJson() {
    return {'remindersState': this.remindersState.toJson()};
  }

}

