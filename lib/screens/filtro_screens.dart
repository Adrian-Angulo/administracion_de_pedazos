import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:administracion_de_pedazos/settings/listPedazos.dart';
import 'package:administracion_de_pedazos/widgets/delivery_action_footer.dart';
import 'package:administracion_de_pedazos/widgets/pedazo_list_item.dart';
import 'package:administracion_de_pedazos/widgets/results_header.dart';
import 'package:flutter/material.dart';

class FiltroScreens extends StatefulWidget {
  const FiltroScreens({super.key});

  @override
  State<FiltroScreens> createState() => _FiltroScreensState();
}

class _FiltroScreensState extends State<FiltroScreens> {
  // Controller para manejar el texto de búsqueda
  final TextEditingController _searchController = TextEditingController();

  // Set que almacena los IDs de los pedazos seleccionados
  final Set<int> _selectedIds = {};

  // Controla si la barra de búsqueda está visible o no
  bool _isSearchVisible = false;

  // Texto de búsqueda actual
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Listener para actualizar la búsqueda cuando el usuario escribe
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    // Liberar recursos del controller cuando el widget se destruye
    _searchController.dispose();
    super.dispose();
  }

  /// Filtra la lista de pedazos según el texto de búsqueda
  /// Busca coincidencias en los campos: para, de, y numero
  List<Pedazo> _getFilteredPedazos() {
    // Si no hay búsqueda, retornar todos los pedazos
    if (_searchQuery.isEmpty) {
      return listPedazos;
    }

    // Convertir la búsqueda a minúsculas para búsqueda case-insensitive
    final query = _searchQuery.toLowerCase();

    // Filtrar pedazos que coincidan en alguno de los campos
    return listPedazos.where((pedazo) {
      final para = pedazo.para.toLowerCase();
      final de = pedazo.de.toLowerCase();
      final numero = pedazo.numero.toLowerCase();

      // Retornar true si algún campo contiene la búsqueda
      return para.contains(query) ||
          de.contains(query) ||
          numero.contains(query);
    }).toList();
  }

  /// Calcula el valor total de los pedazos seleccionados
  double _calculateTotal() {
    double total = 0;

    // Obtener los pedazos filtrados actualmente
    final filteredPedazos = _getFilteredPedazos();

    // Sumar el valor de cada pedazo seleccionado
    for (var pedazo in filteredPedazos) {
      if (_selectedIds.contains(pedazo.id)) {
        total += pedazo.valor;
      }
    }

    return total;
  }

  /// Alterna la selección de todos los pedazos filtrados
  void _toggleSelectAll() {
    setState(() {
      final filteredPedazos = _getFilteredPedazos();

      // Si todos están seleccionados, deseleccionar todos
      if (_areAllSelected(filteredPedazos)) {
        _selectedIds.clear();
      } else {
        // Si no todos están seleccionados, seleccionar todos los filtrados
        for (var pedazo in filteredPedazos) {
          _selectedIds.add(pedazo.id);
        }
      }
    });
  }

  /// Verifica si todos los pedazos de la lista están seleccionados
  bool _areAllSelected(List<Pedazo> pedazos) {
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
  void _toggleSelection(int pedazoId) {
    setState(() {
      if (_selectedIds.contains(pedazoId)) {
        _selectedIds.remove(pedazoId);
      } else {
        _selectedIds.add(pedazoId);
      }
    });
  }

  /// Registra la entrega de los pedazos seleccionados
  void _registerDelivery() {
    // Por ahora solo mostrar un mensaje
    if (_selectedIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay pedazos seleccionados'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final total = _calculateTotal();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Entrega registrada: ${_selectedIds.length} pedazos por un total de \$${total.toStringAsFixed(0)}',
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );

    // Limpiar la selección después de registrar
    setState(() {
      _selectedIds.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Obtener la lista de pedazos filtrados
    final filteredPedazos = _getFilteredPedazos();

    // Verificar si todos están seleccionados
    final allSelected = _areAllSelected(filteredPedazos);

    // Calcular el total de los seleccionados
    final total = _calculateTotal();

    // Obtener la hora actual para el mensaje de registro
    final now = DateTime.now();
    final scheduleText =
        'Total: \$${total.toStringAsFixed(0)} - Hoy a las ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: const Color(0xFF0D1A14),
      appBar: AppBar(
        title: _isSearchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Buscar por Para, De o Número...',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              )
            : const Text('Buscar Pedazos'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isSearchVisible = !_isSearchVisible;
                  if (!_isSearchVisible) {
                    // Limpiar búsqueda al cerrar
                    _searchController.clear();
                  }
                });
              },
              icon: Icon(_isSearchVisible ? Icons.close : Icons.search),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Header con contador de resultados y botón seleccionar todos
          ResultsHeader(
            resultCount: filteredPedazos.length,
            onSelectAll: _toggleSelectAll,
            allSelected: allSelected,
          ),

          // Lista de pedazos filtrados
          Expanded(
            child: filteredPedazos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No se encontraron pedazos',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                        if (_searchQuery.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'para: "$_searchQuery"',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.3),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredPedazos.length,
                    padding: const EdgeInsets.only(bottom: 16),
                    itemBuilder: (context, index) {
                      final pedazo = filteredPedazos[index];

                      return PedazoListItem(
                        pedazo: pedazo,
                        isSelected: _selectedIds.contains(pedazo.id),
                        onToggle: () => _toggleSelection(pedazo.id),
                      );
                    },
                  ),
          ),

          // Footer con información de selección y botón de registro
          DeliveryActionFooter(
            totalValue: _calculateTotal(),
            selectedCount: _selectedIds.length,
            onRegister: _registerDelivery,
            scheduleText: scheduleText,
          ),
        ],
      ),
    );
  }
}
