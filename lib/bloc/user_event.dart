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

class AddUser extends UserEvent {
  final String name;
  final String phone;
  final String university;

  AddUser(this.name, this.phone, this.university);

  @override
  List<Object> get props => [name, phone, university];
}

class ClearUser extends UserEvent {
  const ClearUser();

  @override
  List<Object> get props => null;
}