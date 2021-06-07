import 'package:jlb_flutter_app_2/State/AppState.dart';
import 'package:jlb_flutter_app_2/State/RemindersState.dart';
import 'package:jlb_flutter_app_2/Actions/Actions.dart';
import 'package:jlb_flutter_app_2/Actions/Reminder.dart';
import 'package:jlb_flutter_app_2/State/RemindersState.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

//Reducers handling all the actions
//uses combined reducers rather than one overly large and cumbersome reducer
//Params for Reducers are usually 1) AppState 2) Action

AppState appReducer(AppState state, dynamic action) =>
    AppState(remindersState: combinedReducer (state.remindersState, action),);

final combinedReducer = combineReducers<RemindersState>([
  TypedReducer<RemindersState, SetReminderAction>(_setReminderAction),
  TypedReducer<RemindersState, ClearReminderAction>(_clearReminderAction),
  TypedReducer<RemindersState, RemoveReminderAction>(_removeReminderAction),
]);

//Inputs: State & New reminder to add => Add the new reminder to the list of reminders, then return a new copy of the state/reminders list
RemindersState _setReminderAction(RemindersState state, SetReminderAction action){
  var remindersList = state.remindersList;
  if(remindersList != null){
    // new UI reminder
    remindersList.add(new Reminder(repeat: action.repeat, name: action.name, time: action.time));
  }
  return state.copyWith(remindersList: remindersList);
}

//Inputs: State & reminder to remove => remove the reminder from the list of reminders, then return a new copy of the state/reminders list
RemindersState _removeReminderAction(RemindersState state, RemoveReminderAction action){
  var remindersList = state.remindersList;
  remindersList.removeWhere((reminder) => reminder.name == action.name);
  return state.copyWith(remindersList: remindersList);
}

RemindersState _clearReminderAction(RemindersState state, ClearReminderAction) => state.copyWith(remindersList: []);


