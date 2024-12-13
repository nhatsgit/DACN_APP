import 'package:intl/intl.dart';

class MyFormat {
  static String formatCurrency(double amount,
      {String locale = 'vi_VN', String symbol = '₫'}) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(amount);
  }
}
