import 'package:intl/intl.dart';

class MyFormat {
  static String formatCurrency(double amount,
      {String locale = 'vi_VN', String symbol = '₫'}) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(amount);
  }

  static String formatDateTime(DateTime dateTime) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String hour = twoDigits(dateTime.hour);
    String minute = twoDigits(dateTime.minute);
    String day = twoDigits(dateTime.day);
    String month = twoDigits(dateTime.month);
    String year = dateTime.year.toString();

    return "$hour:$minute $day/$month/$year";
  }
}
