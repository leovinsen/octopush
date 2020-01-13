import 'package:bloc/bloc.dart';
import 'package:octopush/repository/user_data_repository.dart';

import 'user_data_event.dart';
import 'user_data_state.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {

  final UserDataRepository _repo;

  UserDataBloc(this._repo);

  @override
  UserDataState get initialState => UserDataBlocCreated();

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if(event is GetUserData){
      var data = _repo.getUserData();
      yield data == null ? UserDataUninitialized() : UserDataInitialized(data);
    }

    if(event is InitUserData){
      bool saveJob = await _repo.saveUserJob(event.jobIndex);
      if (!saveJob) print('error saving job'); //TODO: Implement error handling 

      bool saveBalance = await _repo.saveBalance(STARTING_BALANCE);
      if (!saveBalance) print('error saving balance'); //TODO : Implement error handling()

      if(saveJob && saveBalance){
        var userData = _repo.getUserData();
        yield UserDataInitialized(userData);
      }
    }

    if(event is ClearUserData){
      yield await _repo.clearUserData() ? UserDataUninitialized : UserDataError("Failed to clear user data"); 
    }
  }

  @override
  void onTransition(Transition<UserDataEvent, UserDataState> transition) {
    super.onTransition(transition);
    print(transition);
  }

}