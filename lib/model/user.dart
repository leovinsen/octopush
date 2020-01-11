class User {
  final String name;
  final String phone;
  final String university;

  User(this.name, this.phone, this.university);

  @override
  String toString() {
    return 'name: $name, phone: $phone, univ: $university';
   }
}
