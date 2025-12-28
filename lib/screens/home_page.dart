import 'package:administracion_de_pedazos/providers/PedazosProvider.dart';
import 'package:administracion_de_pedazos/providers/pageProvider.dart';
import 'package:administracion_de_pedazos/settings/pages.dart';
import 'package:administracion_de_pedazos/widgets/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PedazosProvider>().cargarPedazos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<Pageprovider>();
    final pageIndex = context.watch<Pageprovider>().pageIndex;
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: pages[pageIndex],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: context.watch<Pageprovider>().pageIndex,
        onDestinationSelected: (value) {
          provider.cambiarPage(value);
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Incio',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_box_outlined),
            selectedIcon: Icon(Icons.add_box),
            label: 'Registrar',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory_2),
            label: 'Entregar',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
      ),
    );
  }
}
