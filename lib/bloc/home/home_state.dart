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

  const HomeStateLoaded(this.interval, this.challenges);

  @override
  List<Object> get props => [interval, challenges];

  @override
  String toString() {
    return '$HomeStateLoaded { interval: $interval, challenge: $challenges}';
  }

}

class HomeStateIncremented extends HomeState {
  final int interval;
  final List<Challenge> challenges;

  const HomeStateIncremented(this.interval, this.challenges);

  @override
  List<Object> get props => [interval, challenges];

  @override
  String toString() {
    return '$HomeStateIncremented { interval: $interval, challenge: $challenges}';
  }

}