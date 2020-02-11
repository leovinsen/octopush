import 'package:octopush/model/time_interval.dart';

///Key value pair where value is the Earnings & Expenses user will get on that time interval
///Earnings & Expenses are stated in Million IDR
const Map<TimeInterval, List<int>> earnings = {
  TimeInterval.DAY1_A: [20, 0],
  TimeInterval.DAY1_B: [0, 0],
  TimeInterval.DAY2_A: [72, 70],
  TimeInterval.DAY2_B: [180, 110],
  TimeInterval.DAY3_A: [200, 100],
  TimeInterval.DAY3_B: [220, 110],
  TimeInterval.DAY4_A: [250, 140],
  TimeInterval.DAY4_B: [350, 160],
  TimeInterval.DAY5_A: [400, 190],
  TimeInterval.DAY5_B: [500, 230],
  TimeInterval.DAY6_A: [575, 270],
  TimeInterval.DAY6_B: [625, 330],
  TimeInterval.DAY7_A: [800, 270],
  TimeInterval.DAY7_B: [1000, 330],
  TimeInterval.DAY8_A: [1050, 400],
  TimeInterval.DAY8_B: [1050, 500],
  TimeInterval.DAY9_A: [272, 350],
  TimeInterval.DAY9_B: [200, 250],
  TimeInterval.DAY10_A: [90, 250],
  TimeInterval.DAY10_B: [90, 230],
  TimeInterval.DAY11_A: [120, 250],
  TimeInterval.DAY11_B: [120, 230],
  TimeInterval.DAY12_A: [150, 250],
  TimeInterval.DAY12_B: [150, 230],
};
