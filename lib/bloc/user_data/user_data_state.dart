import 'package:equatable/equatable.dart';
import 'package:octopush/model/user_data.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
}

class UserDataBlocCreated extends UserDataState {
  const UserDataBlocCreated();

  @override
  List<Object> get props => null;
}

class UserDataUninitialized extends UserDataState {
  const UserDataUninitialized();

  @override
  List<Object> get props => null;
}

class UserDataInitialized extends UserDataState {
  final UserData data;
  
  const UserDataInitialized(this.data);

  @override
  List<Object> get props => [data];
}

class UserDataError extends UserDataState {
  final String message;

  const UserDataError(this.message);

  @override
  List<Object> get props => [message];
}