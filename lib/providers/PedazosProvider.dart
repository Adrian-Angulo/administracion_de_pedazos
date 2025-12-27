import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:administracion_de_pedazos/repository/pedazo_repository.dart';
import 'package:flutter/foundation.dart';

/// Provider mejorado para gestionar pedazos
/// Demuestra las mejores prácticas de Provider
class PedazosProvider extends ChangeNotifier {
  // 1. Estado privado
  List<Pedazo> _pedazos = [];

  // iniciarlizar el repositorio

  final PedazoRepository _repository = PedazoRepository();
  bool _isLoading = false;
  String _error = '';

  // 2. Getters públicos (inmutables)
  List<Pedazo> get pedazos => List.unmodifiable(_pedazos);
  bool get isLoading => _isLoading;
  String get error => _error;
  int get totalPedazos => _pedazos.length;
  bool get tienePedazos => _pedazos.isNotEmpty;

  Future<void> cargarPedazos() async {
    _pedazos = await _repository.getPedazos();
    notifyListeners();
  }

  // 3. Métodos públicos con validación
  Future<bool> agregarPedazo(Pedazo pedazo) async {
    // Validación
    if (_pedazos.contains(pedazo)) {
      _error = 'El pedazo ya existe';
      notifyListeners();
      return false;
    }

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();
      // Simular operación asíncrona
      await _repository.registrarPedazo(pedazo);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error al agregar pedazo: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> eliminarPedazo(int index) async {
    try {
      await _repository.eliminarPedazo(index);
      _error = '';
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error al eliminar pedazo: $e';
      notifyListeners();
      return false;
    }
  }

  void limpiarError() {
    _error = '';
    notifyListeners();
  }

  // 4. Método de búsqueda
  /*   List<Pedazo> buscarPedazos(String query) {
    if (query.isEmpty) return pedazos;

    return _pedazos
        .where((pedazo) => pedazo.toLowerCase().contains(query.toLowerCase()))
        .toList();
  } */
}
