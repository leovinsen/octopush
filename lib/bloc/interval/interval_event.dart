import 'package:equatable/equatable.dart';

abstract class IntervalEvent extends Equatable {
  const IntervalEvent();
}

class GetInterval extends IntervalEvent {
  const GetInterval();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$GetInterval { }';
  }

}

class IncrementInterval extends IntervalEvent {
  const IncrementInterval();
  
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$IncrementInterval { }';
  }

}