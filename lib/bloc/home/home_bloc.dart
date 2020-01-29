import 'package:octopush/base/base_bloc.dart';
import 'package:octopush/repository/challenge_repository.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  GameDataRepository _gameDataRepository;
  var _challengeRepository = ChallengeRepository();

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

      yield HomeStateLoaded(interval, challenge);
    }

    if (event is IncrementInterval) {
      await _gameDataRepository.incrementInterval();

      var data = _gameDataRepository.getGameData();

      int interval = data.currentInterval.index;

      var challenge = await _challengeRepository.getUntilInterval(interval);

      yield HomeStateIncremented(interval, challenge);
    }
  }
}
