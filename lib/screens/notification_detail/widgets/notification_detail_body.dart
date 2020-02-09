import 'package:flutter/material.dart';
import 'package:octopush/model/challenge.dart';
import 'package:octopush/model/installment.dart';
import 'package:octopush/model/time_interval.dart';
import 'package:octopush/repository/installment_repository.dart';
import 'package:octopush/screens/installment_detail/widgets/installment_option_list.dart';
import 'package:octopush/styles.dart';
import 'package:octopush/utils/currency_utils.dart';

import 'notification_action_button.dart';
import 'payment_options.dart';

class NotificationDetailBody extends StatelessWidget {
  final Challenge challenge;
  final InstallmentRepository _installmentRepository = InstallmentRepository();

  NotificationDetailBody({Key key, this.challenge}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Hardcode special cases
    switch (challenge.timeInterval) {
      case TimeInterval.DAY1_B:
        return PlayMinesweeperButton();
        break;
      case TimeInterval.DAY2_B:
        return _buildInstallmentWidget(InstallmentType.AUTOMOBILE);
        break;
      case TimeInterval.DAY5_A:
        return _buildInstallmentWidget(InstallmentType.MORTGAGE);
        break;
      case TimeInterval.DAY11_B:
        return PlayJutawanButton();
        break;
      default:
        //Most notifications will use the following Widget
        return challenge.lowestReward.isNegative
            ? PaymentOptions()
            : NotificationActionButton(
                text: 'Claim Rewards',
                onPressed: null,
              );
        break;
    }
  }

  Widget _buildInstallmentWidget(InstallmentType type) {
    var options = _installmentRepository.getOptions(type);
    var basePrice = CurrencyUtils.formatToIdr(
        basePrices[InstallmentType.AUTOMOBILE.index].toDouble());
    return Column(
      children: <Widget>[
        Text(
          'Base Price: $basePrice',
          style: largeTextStyleLight,
        ),
        InstallmentOptionList(options: options),
      ],
    );
  }
}

class PlayMinesweeperButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationActionButton(
      text: 'Play Now!',
      onPressed: () => Navigator.of(context).pushNamed('/minesweeper'),
    );
  }
}

class PlayJutawanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationActionButton(
      text: 'Play Now!',
      onPressed: () => Navigator.of(context).pushNamed('/jutawan'),
    );
  }
}
