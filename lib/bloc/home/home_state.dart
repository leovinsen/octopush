import 'package:equatable/equatable.dart';
import 'package:octopush/model/challenge.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialHomeState extends HomeState {
  const InitialHomeState();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$InitialHomeState { }';
  }
}

class HomeStateLoaded extends HomeState {
  final int interval;
  final List<Challenge> challenges;
  final double trb;
  final double nextIncome;
  final double nextExpenses;

  const HomeStateLoaded(this.interval, this.challenges, this.trb,
      this.nextIncome, this.nextExpenses);

  @override
  List<Object> get props =>
      [interval, challenges, trb, nextIncome, nextExpenses];

  @override
  String toString() {
    return '$HomeStateLoaded { interval: $interval, challenge: $challenges, trb: $trb';
  }
}

class HomeStateIncremented extends HomeState {
  final int interval;
  final List<Challenge> challenges;
  final double trb;
  final double nextIncome;
  final double nextExpenses;

  const HomeStateIncremented(this.interval, this.challenges, this.trb, this.nextIncome, this.nextExpenses);

  @override
  List<Object> get props => [interval, challenges, trb, nextIncome, nextExpenses];

  @override
  String toString() {
    return '$HomeStateIncremented { interval: $interval, challenge: $challenges, trb: $trb}';
  }
}
