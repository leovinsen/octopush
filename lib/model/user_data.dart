import 'package:equatable/equatable.dart';

import 'job.dart';

// TODO: Add other game data variables
class UserData extends Equatable {
  final Job job;
  final double balance;

  UserData(this.job, this.balance);

  @override
  List<Object> get props => [job, balance];
}
