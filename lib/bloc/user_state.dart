import 'package:equatable/equatable.dart';
import 'package:octopush/model/user.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class AppStarted extends UserState {

  const AppStarted();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return "$AppStarted { }";
  }

}

class UserFound extends UserState {
  final User user;

  const UserFound(this.user);

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$UserFound { user: $user}';
  }
}

class UserNotFound extends UserState {
  const UserNotFound();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$UserNotFound { }';
  }
}