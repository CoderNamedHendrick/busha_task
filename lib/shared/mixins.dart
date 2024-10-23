import 'package:intl/intl.dart';

mixin class IntlFormats {
  NumberFormat currencyFormat({int decimalDigits = 0, String symbol = '₦'}) =>
      NumberFormat.currency(symbol: symbol, decimalDigits: decimalDigits);

  NumberFormat percentageFormat({int decimalDigits = 0}) =>
      NumberFormat.decimalPercentPattern(decimalDigits: decimalDigits);
}
