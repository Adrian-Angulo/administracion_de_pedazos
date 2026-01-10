import 'package:administracion_de_pedazos/models/pedazo_historial.dart';
import 'package:administracion_de_pedazos/repository/pedazo_historial_repository.dart';
import 'package:flutter/material.dart';

class HistorialProviders extends ChangeNotifier {
  List<Pedazohistorial> _historial = [];
  final PedazoHistorialRepository _repository = PedazoHistorialRepository();

  List<Pedazohistorial> get historial => _historial;

  Future<void> cargarHistorial() async {
    _historial = await _repository.obtenerHistorial();
    notifyListeners();
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
