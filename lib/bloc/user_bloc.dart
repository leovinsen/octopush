import 'package:octopush/database/database.dart';
import 'package:octopush/model/game_data.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/model/transaction.dart';
import 'package:octopush/model/user.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/repository/user_repository.dart';

import 'user_event.dart';
import 'user_state.dart';
import 'package:bloc/bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final _startingBalance = 2000000.0;

  final UserRepository _userRepo;
  final GameDataRepository _gameDataRepo;
  final TransactionRepository _transactionRepository;

  UserBloc(this._userRepo, this._gameDataRepo)
      : _transactionRepository = TransactionRepository();

  User _activeUser;
  GameData _gameData;

  User get activeUser => _activeUser;
  GameData get gameData => _gameData;

  @override
  UserState get initialState => AppStart();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is GetUser) {
      _activeUser = _userRepo.getUser();

      if (_activeUser == null) {
        yield UserNotFound();
        return;
      }

      _gameData = _gameDataRepo.getGameData();
      if (_gameData == null) {
        yield GameDataNotFound(_activeUser.name);
        return;
      }

      yield GameDataFound(_activeUser, _gameData);
    }

    if (event is RegisterUser) {
      _activeUser = User(event.name, event.phone, event.university);
      _userRepo.saveUser(_activeUser);

      yield UserAdded(_activeUser.name);
    }

    if (event is InitializeGame) {
      bool b = await _gameDataRepo.initializeData(event.jobIndex);
    
      await _addInitialSavings();
      
      _gameData = _gameDataRepo.getGameData();

      yield GameDataFound(_userRepo.getUser(), _gameData);
    }

    if (event is ClearData) {
      await _userRepo.clearUser();
      await DatabaseProvider.instance.deleteDB();
      //Invalidate cache
      _activeUser = null;
      _gameData = null;

      yield UserNotFound();
    }
  }

  @override
  void onTransition(Transition<UserEvent, UserState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  Future<int> _addInitialSavings() async {
      var t = Transaction(null, DateTime.now(), TimeInterval.DAY1_A.index,
          "Initial Savings", _startingBalance);
      return _transactionRepository.addTranscation(t);
  }
}
