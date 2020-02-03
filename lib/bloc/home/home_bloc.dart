import 'package:octopush/base/base_bloc.dart';
import 'package:octopush/repository/challenge_repository.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  GameDataRepository _gameDataRepository;
  var _challengeRepository = ChallengeRepository();
  var _transactionRepository = TransactionRepository();

  HomeBloc();

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    //TODO: Use a DI Framework
    print(event);
    if (_gameDataRepository == null)
      _gameDataRepository =
          GameDataRepository(await SharedPreferences.getInstance());

    if (event is GetInterval) {
      var data = _gameDataRepository.getGameData();
      int interval = data.currentInterval.index;

      var challenge = await _challengeRepository.getUntilInterval(interval);

      var currentBalance = await calculateTRB();

      yield HomeStateLoaded(interval, challenge, currentBalance);
    }

    if (event is IncrementInterval) {
      await _gameDataRepository.incrementInterval();

      var data = _gameDataRepository.getGameData();

      int interval = data.currentInterval.index;

      var challenge = await _challengeRepository.getUntilInterval(interval);

      var currentBalance = await calculateTRB();

      yield HomeStateIncremented(interval, challenge, currentBalance);
    }
  }

  Future<double> calculateTRB() async {
    var transactions = await _transactionRepository.getAllTranscation();

    var trb = 0.0;

    transactions.forEach((t) => trb +=  t.amount);

    return trb;
  }
}
