import 'package:octopush/repository/user_data_repository.dart';

import 'user_event.dart';
import 'user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserDataRepository _repo;

  UserBloc(this._repo);

  @override
  UserState get initialState => AppStarted();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUser){
      var user = _repo.getUser();
      yield user == null ? UserNotFound() : UserFound(user);
    }
  }

}