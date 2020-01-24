import 'package:equatable/equatable.dart';

import 'job.dart';
import 'time_interval.dart';

// TODO: Add other game data variables
class GameData extends Equatable {
  final Job job;
  final double balance;
  final TimeInterval currentInterval;

  GameData(this.job, this.balance, this.currentInterval);

  @override
  List<Object> get props => [job, balance];
}
