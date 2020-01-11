import 'job.dart';

class User {
  final String name;
  final String phone;
  final String university;
  final Job job;

  User(this.name, this.phone, this.university, this.job);

  @override
  String toString() {
    return 'name: $name, phone: $phone, univ: $university, job: $job';
   }
}
