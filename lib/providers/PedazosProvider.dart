import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:administracion_de_pedazos/repository/pedazo_repository.dart';
import 'package:flutter/foundation.dart';

/// Provider mejorado para gestionar pedazos
/// Demuestra las mejores prácticas de Provider
class PedazosProvider extends ChangeNotifier {
  // 1. Estado privado
  List<Pedazo> _pedazos = [];
  // Texto de búsqueda actual
  String _searchQuery = '';
  // Set que almacena los IDs de los pedazos seleccionados
  final Set<int> _selectedIds = {};

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
  Set<int> get selectedIds => _selectedIds;
  String get searchQuery => _searchQuery;

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

  /// Filtra la lista de pedazos según el texto de búsqueda
  /// Busca coincidencias en los campos: para, de, y numero
  List<Pedazo> getFilteredPedazos() {
    List<Pedazo> listaPedazos = _pedazos;
    // Si no hay búsqueda, retornar todos los pedazos
    if (_searchQuery.isEmpty) {
      return listaPedazos;
    }

    // Convertir la búsqueda a minúsculas para búsqueda case-insensitive
    final query = _searchQuery.toLowerCase();

    // Filtrar pedazos que coincidan en alguno de los campos
    return listaPedazos.where((pedazo) {
      final para = pedazo.remitente.toLowerCase();
      final de = pedazo.destinatario.toLowerCase();
      final numero = pedazo.numero.toLowerCase();

      // Retornar true si algún campo contiene la búsqueda
      return para.contains(query) || numero.contains(query);
    }).toList();
  }

  void cambiarQuery(String texto) {
    _searchQuery = texto;
    notifyListeners();
  }

  void limpiarSeletedId() {
    _selectedIds.clear();
    notifyListeners();
  }

  /// Calcula el valor total de los pedazos seleccionados
  double calculateTotal() {
    double total = 0;

    // Obtener los pedazos filtrados actualmente
    final filteredPedazos = getFilteredPedazos();

    // Sumar el valor de cada pedazo seleccionado
    for (var pedazo in filteredPedazos) {
      if (_selectedIds.contains(pedazo.id)) {
        total += pedazo.valor;
      }
    }

    return total;
  }

  /// Alterna la selección de todos los pedazos filtrados
  void toggleSelectAll() {
    final filteredPedazos = getFilteredPedazos();

    // Si todos están seleccionados, deseleccionar todos
    if (areAllSelected(filteredPedazos)) {
      _selectedIds.clear();
      notifyListeners();
    } else {
      // Si no todos están seleccionados, seleccionar todos los filtrados
      for (var pedazo in filteredPedazos) {
        _selectedIds.add(pedazo.id);
        notifyListeners();
      }
    }
  }

  /// Verifica si todos los pedazos de la lista están seleccionados
  bool areAllSelected(List<Pedazo> pedazos) {
    if (pedazos.isEmpty) return false;

    // Verificar si todos los IDs de los pedazos filtrados están en el set de seleccionados
    for (var pedazo in pedazos) {
      if (!_selectedIds.contains(pedazo.id)) {
        return false;
      }
    }
    return true;
  }

  /// Alterna la selección de un pedazo individual
  void toggleSelection(int pedazoId) {
    if (_selectedIds.contains(pedazoId)) {
      _selectedIds.remove(pedazoId);
      notifyListeners();
    } else {
      _selectedIds.add(pedazoId);
      notifyListeners();
    }
  }
}
