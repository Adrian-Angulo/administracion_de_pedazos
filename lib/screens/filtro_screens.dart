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

    /// Obtiene los nombres de los pedazos seleccionados
    String getSelectedPedazosNames() {
      return provider.selectedIds
          .map((id) => provider.obtenerPedazoPorId(id).destinatario)
          .toSet()
          .join(', ');
    }

    /// Verifica si todos los pedazos seleccionados tienen el mismo destinatario
    bool hasSameDestinatario() {
      if (provider.selectedIds.isEmpty) return false;

      final firstDestinatario = provider
          .obtenerPedazoPorId(provider.selectedIds.first)
          .destinatario;

      return provider.selectedIds.every(
        (id) =>
            provider.obtenerPedazoPorId(id).destinatario == firstDestinatario,
      );
    }

    Future alertError(BuildContext context, String remitentes) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E2A20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SizedBox(
            height: 340,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Error de Selección",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Estás seleccionando dos destinatarios diferentes. Para $remitentes",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Solo puedes entregar pedazos al mismo destinatario",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.5),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Entendido",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    /// Registra la entrega de los pedazos seleccionados
    void registerDelivery() async {
      String remitentes = getSelectedPedazosNames();
      bool unicoDestinatario = hasSameDestinatario();

      if (unicoDestinatario) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1E2A20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SizedBox(
              height: 320,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      size: 48,
                      color: Colors.green,
                    ),
                  ),
                  const Text(
                    "Confirmar Entrega",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "¿Está seguro de entregar ${provider.selectedIds.length} ${provider.selectedIds.length > 1 ? "pedazos" : "pedazo"} a $remitentes?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Total a entregar: \$${formatCOP(provider.calculateTotal())}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                        height: 1.4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            for (var id in provider.selectedIds) {
                              final Pedazo pedazo = provider.obtenerPedazoPorId(
                                id,
                              );
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
                            Navigator.pop(context);
                            provider.eliminacionMultiple();
                            provider.limpiarSeletedId();
                            MessageUtils.showSingleDelivery(context);
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Confirmar Entrega",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white60,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        alertError(context, remitentes);
      }
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
