enum InstallmentType { MORTGAGE, AUTOMOBILE }

const int million = 1000000;

const List<int> durations = [
  2,
  4,
  6,
  8,
  10,
  12,
];

const List<double> interests = [
  15,
  20,
  25,
  30,
  33,
  35,
];

const List<int> basePrices = [
  1000 * million,
  500 * million,
];

class InstallmentOption {
  ///measured in a [TimeInterval]
  final int duration;

  final double interest;
  final double amount;

  InstallmentOption(this.duration, this.interest, int basePrice)
      : amount = basePrice * (1 + (interest / 100));

  double get intervalInstallment => amount / duration;

  static Map<InstallmentType, List<InstallmentOption>> buildOptions() {
    var map = Map<InstallmentType, List<InstallmentOption>>();

    InstallmentType.values.forEach((type) {
      List<InstallmentOption> list = [];
      int price = basePrices[type.index];

      for (int i = 0; i < durations.length; i++) {
        list.add(InstallmentOption(durations[i], interests[i], price));
      }

      map[type] = list;
    });

    return map;
  }
}
