import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetInterval extends HomeEvent {
  const GetInterval();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$GetInterval { }';
  }

}

class IncrementInterval extends HomeEvent {
  const IncrementInterval();
  
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$IncrementInterval { }';
  }

}