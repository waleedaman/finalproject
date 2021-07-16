import 'package:finalproject/actions.dart';
import 'package:finalproject/app_state.dart';

AppState updateModeReducer(AppState state, dynamic action){
  if(action is UpdateModeAction){
    if(action.updatedMode == "offline"){
      action.updatedMode = "online";
    }else{
      action.updatedMode = "offline";
    }
    return AppState(mode:action.updatedMode);
  }
  return state;
}

