import 'actions.dart';
import 'app_state.dart';

AppState appStateReducer(AppState state, dynamic action){
  if(action is UpdateModeAction){
    return AppState(mode:action.updatedMode,authMode:state.authMode,userName:state.userName,userId:state.userId,openProjectId:state.openProjectId);
  }else if(action is UpdateUserNameAction){
    return updateUserNameReducer(state, action);
  }else if(action is UpdateUserIdAction){
    return updateUserIdReducer(state, action);
  }else if(action is UpdateOpenProjectIdAction){
    return updateOpenProjectIdReducer(state, action);
  }
  return state;
}

AppState updateUserNameReducer(AppState state, dynamic action){
  return AppState(mode:state.mode,authMode:state.authMode,userName:action.updatedUserName,userId:state.userId,openProjectId:state.openProjectId);
}

AppState updateUserIdReducer(AppState state, dynamic action){
  return AppState(mode:state.mode,authMode:state.authMode,userName:state.userName,userId:action.updatedUserId,openProjectId:state.openProjectId);
}

AppState updateOpenProjectIdReducer(AppState state, dynamic action){
  return AppState(mode:state.mode,authMode:state.authMode,userName:state.userName,userId:state.userId,openProjectId:action.updatedOpenProjectId);
}