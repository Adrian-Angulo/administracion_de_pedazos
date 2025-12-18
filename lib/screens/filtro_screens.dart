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
  final TextEditingController _searchController = TextEditingController();
  final Set<int> _selectedIndices = {};
  bool _isSearchVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final scheduleText =
        'Registrando entrega para hoy a las ${now.hour}:${now.minute.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: const Color(0xFF0D1A14),
      appBar: AppBar(
        title: _isSearchVisible
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  hintText: 'Buscar por destinatario (Para)...',
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
                onChanged: (value) {
                  // Implement search logic here
                },
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
          ResultsHeader(resultCount: 0, onSelectAll: () {}, allSelected: false),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              padding: const EdgeInsets.only(bottom: 16),
              itemBuilder: (context, index) {
                return PedazoListItem(
                  isSelected: _selectedIndices.contains(index),
                  onToggle: () {},
                );
              },
            ),
          ),
          DeliveryActionFooter(
            selectedCount: _selectedIndices.length,
            onRegister: () {},
            scheduleText: scheduleText,
          ),
        ],
      ),
    );
  }
}
