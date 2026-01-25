import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

String formatTime(DateTime fecha) {
  initializeDateFormatting('es_CO', null);
  final formatter = DateFormat('d \'de\' MMM hh:mm a', 'es_CO');
  return formatter.format(fecha);
}

String formatDateTime() {
  initializeDateFormatting('es_CO', null);
  final formatter = DateFormat('d \'de\' MMM', 'es_CO');
  return formatter.format(DateTime.now());
}

String formatHour(DateTime fecha) {
  initializeDateFormatting('es_CO', null);
  final formatter = DateFormat('hh:mm a', 'es_CO');
  return formatter.format(fecha);
}
