

import 'package:octopush/base/base_bloc.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interval_event.dart';
import 'interval_state.dart';

class IntervalBloc extends BaseBloc<IntervalEvent, IntervalState> {

  GameDataRepository _gameDataRepository;
  IntervalBloc();

  @override
  IntervalState get initialState => InitialInterval();

  @override
  Stream<IntervalState> mapEventToState(IntervalEvent event) async* {

    //TODO: Use a DI Framework
    if(_gameDataRepository == null) _gameDataRepository = GameDataRepository(await SharedPreferences.getInstance());

    if(event is GetInterval) {
      var data = _gameDataRepository.getGameData();
      yield IntervalUpdated(data.currentInterval.index);
    }

    if(event is IncrementInterval) {
      await _gameDataRepository.incrementInterval();
      var data = _gameDataRepository.getGameData();
      yield IntervalUpdated(data.currentInterval.index);
    }
  }

}