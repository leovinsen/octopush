import 'package:equatable/equatable.dart';

import 'job.dart';

// TODO: Add other game data variables
class GameData extends Equatable {
  final Job job;
  final double balance;

  GameData(this.job, this.balance);

  @override
  List<Object> get props => [job, balance];
}
