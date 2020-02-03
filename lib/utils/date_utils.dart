import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(DateTime dt) {
    var suffix = "th";
    var digit = DateTime.now().day % 10;
    if ((digit > 0 && digit < 4) && (dt.day < 11 || dt.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }

    var formatDate = DateFormat("EEEE, MMMM dd'$suffix' yyyy");
    return formatDate.format(dt);
  }

  static String formatDateDDMMYY(DateTime dt){
    return DateFormat("dd/MM/yyyy").format(dt);
  }

  static String formatTime(DateTime dt) {
    var format = DateFormat("hh:mm a");
    return format.format(dt);
  }
}
