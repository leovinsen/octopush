import 'package:octopush/model/time_interval.dart';

class IllegalIntervalException implements Exception {
  final String msg;
  const IllegalIntervalException(int interval)
      : this.msg =
            "Only intervals from $TIME_1A to $TIME_12B are allowed; found $interval instead";
}

class InvalidIntervalAdditionException implements Exception {
  final String msg;
  const InvalidIntervalAdditionException()
      : this.msg = "Unable to increment interval as it exceeds $TIME_12B";
}
