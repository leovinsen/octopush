import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {

}

class GetUser extends UserEvent {
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$GetUser { }';
  }
}