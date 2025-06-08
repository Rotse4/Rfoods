import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatKES(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'en_KE',
      symbol: 'KSh ',
      decimalDigits: 2,
    );
    return formatter.format(amount);
  }
} 