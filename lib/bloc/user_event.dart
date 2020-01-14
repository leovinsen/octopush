import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class GetUser extends UserEvent {
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$GetUser { }';
  }
}

class RegisterUser extends UserEvent {
  final String name;
  final String phone;
  final String university;

  RegisterUser(this.name, this.phone, this.university);

  @override
  List<Object> get props => [name, phone, university];
}

class InitializeGame extends UserEvent {

  final int jobIndex;
  const InitializeGame(this.jobIndex);

  @override
  List<Object> get props => [jobIndex];

  @override
  String toString() {
    return '$GetUser { jobIndex: $jobIndex }';
  }
}

class ClearData extends UserEvent {
  const ClearData();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$ClearData { } ';
  }
}