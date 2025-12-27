import 'package:intl/intl.dart';

double obtenerValorDouble(String texto) {
  final limpio = texto.replaceAll(RegExp(r'[^0-9]'), '');
  return double.parse(limpio);
}

String formatCOP(num value, {bool showSymbol = false}) {
  final formatter = NumberFormat.currency(
    locale: 'es_CO',
    symbol: showSymbol ? '\$ ' : '',
    decimalDigits: 0,
  );

  return formatter.format(value);
}
