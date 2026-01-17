import 'package:administracion_de_pedazos/models/pedazo_historial.dart';
import 'package:administracion_de_pedazos/repository/pedazo_historial_repository.dart';
import 'package:flutter/material.dart';

class HistorialProviders extends ChangeNotifier {
  List<Pedazohistorial> _historial = [];
  final PedazoHistorialRepository _repository = PedazoHistorialRepository();
  DateTime? _fechaSeleccionada = DateTime.now();


  List<Pedazohistorial> get historial => _historial;
  DateTime? get fechaSeleccionada => _fechaSeleccionada;

  void cambiarFechaSelecionada(DateTime? fecha) {
    _fechaSeleccionada = fecha;
    notifyListeners();
  }
  

  Future<void> cargarHistorial() async {
    _historial = await _repository.obtenerHistorial();
    notifyListeners();
  }

  List<Pedazohistorial> filtrarHistorial() {
    if (_fechaSeleccionada == DateTime.now()) {
      return _historial;
    }

    return _historial.where((historial) {
      return historial.fecha.year == _fechaSeleccionada!.year &&
          historial.fecha.month == _fechaSeleccionada!.month &&
          historial.fecha.day == _fechaSeleccionada!.day;
    }).toList();
  }

  Future<void> agregarHistorial(Pedazohistorial historial) async {
    try {
      _historial.add(historial);
      await _repository.registrarHistorial(historial);
      notifyListeners();
    } catch (e) {
      throw Exception("error: $e");
    }
  }
}
