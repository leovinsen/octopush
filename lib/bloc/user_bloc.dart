import 'package:octopush/model/user.dart';
import 'package:octopush/repository/user_repository.dart';

import 'user_event.dart';
import 'user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {

  final UserRepository _repo;

  UserBloc(this._repo);

  User _activeUser;

  User get activeUser => _activeUser;

  @override
  UserState get initialState => AppStart();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUser){
      _activeUser = _repo.getUser();
      yield _activeUser == null ? UserNotFound() : UserFound(_activeUser);
    }

    if (event is RegisterUser){
      _activeUser = User(
        event.name,
        event.phone,
        event.university
      );
      _repo.saveUser(_activeUser);

      yield UserFound(_activeUser);
    }

    if (event is ClearData){
      await _repo.clearUser();
      //Invalidate cache
      _activeUser = null;

      yield UserNotFound();
    }
  }

    @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);
  }
}