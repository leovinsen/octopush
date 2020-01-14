import 'package:equatable/equatable.dart';
import 'package:octopush/model/user.dart';
import 'package:octopush/model/game_data.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class AppStart extends UserState {

  const AppStart();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return "$AppStart { }";
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


class UserAdded extends UserState {
  final String name;

  const UserAdded(this.name);

  @override
  List<Object> get props => [name];

  @override
  String toString() {
    return '$UserAdded { $name }';
  }
}

class GameDataNotFound extends UserState {
  const GameDataNotFound();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$GameDataNotFound { }';
  }
}

class GameDataFound extends UserState {
  final User user;
  final GameData gameData;

  const GameDataFound(this.user, this.gameData);

  @override
  List<Object> get props => [user, gameData];

  @override
  String toString() {
    return '$UserNotFound { }';
  }
}

class DataCleared extends UserState {
  const DataCleared();

  @override
  List<Object> get props => null;

  @override
  String toString() {
    return '$DataCleared { }';
  }
}