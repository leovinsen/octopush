import 'package:octopush/base/base_bloc.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/repository/challenge_repository.dart';
import 'package:octopush/repository/game_data_repository.dart';
import 'package:octopush/repository/income_repository.dart';
import 'package:octopush/repository/transaction_repository.dart';
import 'package:octopush/service/transaction_service.dart';
import 'package:octopush/service/trb_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  GameDataRepository _gameDataRepository;
  var _challengeRepository = ChallengeRepository();
  var _transactionRepository = TransactionRepository();
  TransactionService _transactionService;
  var _incomeRepository = IncomeRepository();

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

    _transactionService =
        TransactionService(_transactionRepository, TrbService());

    if (event is GetInterval) {
      var data = _gameDataRepository.getGameData();
      int interval = data.currentInterval.index;

      var challenge = await _challengeRepository.getUntilInterval(interval);

      var currentBalance = await calculateTRB();

      var incomeExpenses = getNextIncomeAndExpenses(interval);

      yield HomeStateLoaded(
        interval,
        challenge,
        currentBalance,
        incomeExpenses[0].toDouble(),
        incomeExpenses[1].toDouble(),
      );
    }

    if (event is IncrementInterval) {
      await _gameDataRepository.incrementInterval();

      var data = _gameDataRepository.getGameData();

      int interval = data.currentInterval.index;

      var challenge = await _challengeRepository.getUntilInterval(interval);

      var currentBalance = await calculateTRB();

      var incomeExpenses = getNextIncomeAndExpenses(interval);

      var currentIncomeAndExpenses = _getCurrentIncomeAndExpenses(interval);

      _transactionService.addIncome(TimeInterval.values[interval],
          currentIncomeAndExpenses[0].toDouble());
      _transactionService.addExpenses(TimeInterval.values[interval],
          currentIncomeAndExpenses[1].toDouble());

      yield HomeStateIncremented(
        interval,
        challenge,
        currentBalance,
        incomeExpenses[0].toDouble(),
        incomeExpenses[1].toDouble(),
      );
    }
  }

  List<int> getNextIncomeAndExpenses(int interval) {
    if (interval >= TimeInterval.DAY12_B.index) return [0, 0];

    return _incomeRepository
        .getIncomeAndExpensesFor(TimeInterval.values[interval + 1]);
  }

  List<int> _getCurrentIncomeAndExpenses(int interval) {
    //TODO: Throw error in this case
    if (interval > TimeInterval.DAY12_B.index) return [0, 0];

    return _incomeRepository
        .getIncomeAndExpensesFor(TimeInterval.values[interval]);
  }

  Future<double> calculateTRB() async {
    var transactions = await _transactionRepository.getAllTranscation();

    var trb = 0.0;

    transactions.forEach((t) => trb += t.amount);

    return trb;
  }
}
