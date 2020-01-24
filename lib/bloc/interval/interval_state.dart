import 'package:equatable/equatable.dart';

abstract class IntervalState extends Equatable {
  const IntervalState();
}

class InitialInterval extends IntervalState {
  const InitialInterval();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$InitialInterval { }';
  }
}

class IntervalUpdated extends IntervalState {
  final int interval;

  const IntervalUpdated(this.interval);

  @override
  List<Object> get props => [interval];

  @override
  String toString() {
    return '$IntervalUpdated { interval: $interval}';
  }

}