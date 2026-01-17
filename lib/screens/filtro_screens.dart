import 'package:administracion_de_pedazos/formatters/formatters.dart';
import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:administracion_de_pedazos/models/pedazo_historial.dart';
import 'package:administracion_de_pedazos/providers/PedazosProvider.dart';
import 'package:administracion_de_pedazos/providers/historial_providers.dart';
import 'package:administracion_de_pedazos/utils/message_utils.dart';
import 'package:administracion_de_pedazos/widgets/delivery_action_footer.dart';
import 'package:administracion_de_pedazos/widgets/pedazo_list_item.dart';
import 'package:administracion_de_pedazos/widgets/results_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltroScreens extends StatefulWidget {
  const FiltroScreens({super.key});

  @override
  State<FiltroScreens> createState() => _FiltroScreensState();
}

class _FiltroScreensState extends State<FiltroScreens> {
  // Controller para manejar el texto de búsqueda
  final TextEditingController _searchController = TextEditingController();

  // Controla si la barra de búsqueda está visible o no
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
    // Listener para actualizar la búsqueda cuando el usuario escribe
    _searchController.addListener(() {
      context.read<PedazosProvider>().cambiarQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    // Liberar recursos del controller cuando el widget se destruye
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PedazosProvider>();
    final historialProvider = context.watch<HistorialProviders>();

    // Obtener la lista de pedazos filtrados
    final filteredPedazos = provider.getFilteredPedazos();

    // Verificar si todos están seleccionados
    final allSelected = provider.areAllSelected(filteredPedazos);

    /// Registra la entrega de los pedazos seleccionados
    void registerDelivery() async {
      for (var id in provider.selectedIds) {
        final Pedazo pedazo = provider.obtenerPedazoPorId(id);
        final historial = Pedazohistorial(
          0,
          pedazo.id,
          remitente: pedazo.remitente,
          destinatario: pedazo.destinatario,
          valor: pedazo.valor,
          numero: pedazo.numero,
          fecha: DateTime.now(),
          estado: "Entregado",
          isCompleted: 1,
        );
        historialProvider.agregarHistorial(historial);
      }
      // Limpiar la selección después de registrar
      provider.eliminacionMultiple();
      provider.limpiarSeletedId();
      MessageUtils.showSingleDelivery(context);
    }

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
            onSelectAll: provider.toggleSelectAll,
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
                        if (provider.searchQuery.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            'para: "${provider.searchQuery}"',
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

                      return Dismissible(
                        key: ValueKey(pedazo.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            provider.eliminarPedazo(pedazo.id);
                            MessageUtils.showPedazoDeleted(
                              context,
                              numero: pedazo.numero,
                            );
                          });
                        },
                        child: PedazoListItem(
                          pedazo: pedazo,
                          isSelected: provider.selectedIds.contains(pedazo.id),
                          onToggle: () => provider.toggleSelection(pedazo.id),
                        ),
                      );
                    },
                  ),
          ),

          // Footer con información de selección y botón de registro
          DeliveryActionFooter(
            totalValue: provider.calculateTotal(),
            selectedCount: provider.selectedIds.length,
            onRegister: registerDelivery,
          ),
        ],
      ),
    );
  }
}
