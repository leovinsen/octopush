import 'package:equatable/equatable.dart';

import 'job.dart';
import 'time_interval.dart';

class GameData extends Equatable {
  final Job job;
  final TimeInterval currentInterval;

  GameData(this.job, this.currentInterval);

  @override
  List<Object> get props => [job, currentInterval];
}
