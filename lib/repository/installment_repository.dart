import 'package:octopush/model/installment.dart';

class InstallmentRepository {
  final Map<InstallmentType, List<InstallmentOption>> options;

  InstallmentRepository() : options = InstallmentOption.buildOptions();

  List<InstallmentOption> getOptions(InstallmentType installmentType) {
    return options[installmentType];
  }
}
