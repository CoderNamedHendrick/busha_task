import 'package:intl/intl.dart';

mixin class IntlFormats {
  NumberFormat currencyFormat({int decimalDigits = 0, String symbol = '₦'}) =>
      NumberFormat.currency(symbol: symbol, decimalDigits: decimalDigits);

  NumberFormat get decimalOnlyFormat => NumberFormat('.00');

  NumberFormat get percentageFormat => NumberFormat('.00');
}
